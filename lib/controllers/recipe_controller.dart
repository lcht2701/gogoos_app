import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shortid/shortid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gogoos_app/models/ingredient.dart';
import 'package:gogoos_app/models/review.dart';
import 'package:gogoos_app/models/tutorial.dart';
import 'package:image_picker/image_picker.dart';

import '../models/recipe.dart';

class RecipeController {
  final CollectionReference _recipesCollection =
      FirebaseFirestore.instance.collection('Recipes');
  final CollectionReference _ingredientsCollection =
      FirebaseFirestore.instance.collection('Ingredients');

  Future<List<Ingredient>> getAllIngredients() async {
    List<Ingredient> ingredientList = [];

    QuerySnapshot<Object?> ingredientSnapshot =
        await _ingredientsCollection.get();
    for (var item in ingredientSnapshot.docs) {
      String id = item.get('id');
      String name = item.get('name');

      Ingredient ingredient = Ingredient(
        id: id,
        name: name,
      );
      ingredientList.add(ingredient);
    }
    return ingredientList;
  }

  Future<List<Recipe>> getAllRecipes() async {
    List<Recipe> recipesList = [];

    QuerySnapshot<Object?> recipeSnapshot = await _recipesCollection.get();
    for (var rec in recipeSnapshot.docs) {
      String id = rec.get('id');
      String title = rec.get('title');
      String photoUrl = rec.get('photoUrl');
      int calories = rec.get('calories');
      int time = rec.get('time');
      String description = rec.get('description');
      bool isTopRecipe = rec.get('isTopRecipe');

      // Initialize ingredientList, tutorialsList, and reviewList for each recipe
      List<Ingredient> ingredientList = [];
      List<Tutorial> tutorialsList = [];
      List<Review> reviewList = [];

      QuerySnapshot<Map<String, dynamic>> ingredientSnapshot =
          await rec.reference.collection('ingredients').get();
      for (var i in ingredientSnapshot.docs) {
        String iid = i.get('id');
        String iname = i.get('name');
        int iamount = i.get('amount');
        String iunit = i.get('unit');
        String irecipeId = i.get('recipeId');

        Ingredient ingredient = Ingredient(
          id: iid,
          unit: iunit,
          amount: iamount,
          name: iname,
          recipeId: irecipeId,
        );
        ingredientList.add(ingredient);
      }

      QuerySnapshot<Map<String, dynamic>> tutorialSnapshot =
          await rec.reference.collection('tutorials').get();
      for (var t in tutorialSnapshot.docs) {
        String tid = t.get('id');
        String tstep = t.get('step');
        String tdescription = t.get('description');
        String trecipeId = t.get('recipeId');

        Tutorial tutorial = Tutorial(
          id: tid,
          description: tdescription,
          step: tstep,
          recipeId: trecipeId,
        );
        tutorialsList.add(tutorial);
      }

      QuerySnapshot<Map<String, dynamic>> reviewSnapshot =
          await rec.reference.collection('reviews').get();
      for (var rev in reviewSnapshot.docs) {
        String rid = rev.get('id');
        String rreview = rev.get('review');
        String rusername = rev.get('username');
        String rrecipeId = rev.get('recipeId');

        Review review = Review(
          id: rid,
          review: rreview,
          username: rusername,
          recipeId: rrecipeId,
        );
        reviewList.add(review);
      }

      Recipe recipe = Recipe(
        id: id,
        title: title,
        photoUrl: photoUrl,
        calories: calories,
        time: time,
        isTopRecipe: isTopRecipe,
        description: description,
        ingredients: ingredientList,
        tutorials: tutorialsList,
        reviews: reviewList,
      );
      recipesList.add(recipe);
    }

    return recipesList;
  }

  Future<List<Recipe>> getTopRecipes() async {
    // Get full recipe list
    List<Recipe> recipesList = await getAllRecipes();

    // Filter the list based on the isTopRecipe property
    List<Recipe> topRecipes =
        recipesList.where((recipe) => recipe.isTopRecipe).toList();

    return topRecipes;
  }

  List<Recipe> searchRecipes(List<Recipe> recipes, String searchQuery) {
    if (searchQuery.isEmpty) {
      // If the search query is empty, return the original list
      return recipes;
    }

    // Convert the search query to lowercase for case-insensitive search
    String lowercaseQuery = searchQuery.toLowerCase();

    // Filter the list based on the search query
    List<Recipe> filteredList = recipes.where((recipe) {
      String lowercaseTitle = recipe.title.toLowerCase();
      String lowercaseDescription = recipe.description.toLowerCase();

      return lowercaseTitle.contains(lowercaseQuery) ||
          lowercaseDescription.contains(lowercaseQuery);
    }).toList();

    return filteredList;
  }

  Future<void> addRecipe(Recipe recipe) async {
    final docRecipe = _recipesCollection.doc();
    String recipeId = docRecipe.id;
    // Set the data for the main recipe document
    await docRecipe.set({
      'id': recipeId,
      'title': recipe.title,
      'photoUrl': recipe.photoUrl,
      'calories': recipe.calories,
      'time': recipe.time,
      'description': recipe.description,
      'isTopRecipe': false,
    });
    // Add ingredients to Ingredients sub-collection
    if (recipe.ingredients != null) {
      CollectionReference ingredientCollection =
          docRecipe.collection('ingredients');
      for (Ingredient ingredient in recipe.ingredients!) {
        // Create a new document in the Ingredients sub-collection
        DocumentReference ingredientDoc = ingredientCollection.doc();

        // Set the data for the ingredient document
        await ingredientDoc.set({
          'id': ingredientDoc.id,
          'name': ingredient.name,
          'amount': ingredient.amount,
          'unit': ingredient.unit,
          'recipeId': recipeId
        });
      }
    }

    // Add tutorials to Tutorials sub-collection
    if (recipe.tutorials != null) {
      CollectionReference tutorialCollection =
          docRecipe.collection('tutorials');
      for (Tutorial tutorial in recipe.tutorials!) {
        // Create a new document in the Tutorials sub-collection
        DocumentReference tutorialDoc = tutorialCollection.doc();

        // Set the data for the tutorial document
        await tutorialDoc.set({
          'id': tutorialDoc.id,
          'step': tutorial.step,
          'description': tutorial.description,
          'recipeId': recipeId
        });
      }
    }
  }

  Future updateRecipe(Recipe recipe) async {
    await _recipesCollection.doc(recipe.id).update(recipe.toMap());
  }

  Future deleteRecipe(Recipe recipe) async {
    await _recipesCollection.doc().delete();
  }

  Future<String> uploadRecipeImg() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      // No image selected
      return ''; // Return an empty string or handle the error
    }
    String? currentUserId = FirebaseAuth.instance.currentUser!.email;
    // Generate a unique filename using a combination of UUID and timestamp
    String fileName =
        '${currentUserId?.split('@')[0]}_recipe_${shortid.generate()}.jpg';

    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    await ref.putFile(File(image.path));

    String imgUrl = await ref.getDownloadURL();
    return imgUrl;
  }
}
