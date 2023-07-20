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
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<List<Ingredient>> getAllIngredients() async {
    final QuerySnapshot<Object?> ingredientSnapshot =
        await _ingredientsCollection.get();

    return ingredientSnapshot.docs.map((item) {
      final Map<String, dynamic>? data = item.data() as Map<String, dynamic>?;
      String id = data?['id'] as String? ?? '';
      String name = data?['name'] as String? ?? '';

      return Ingredient(
        id: id,
        name: name,
      );
    }).toList();
  }

  Future<List<Recipe>> getAllRecipes() async {
    final QuerySnapshot<Object?> recipeSnapshot =
        await _recipesCollection.get();

    final List<Recipe> recipesList = [];
    final List<Future<QuerySnapshot<Object?>>> recipeSubCollections = [];

    // Fetch all sub-collections (ingredients, tutorials, and reviews) in parallel
    for (var rec in recipeSnapshot.docs) {
      recipeSubCollections.add(rec.reference.collection('ingredients').get());
      recipeSubCollections.add(rec.reference.collection('tutorials').get());
      recipeSubCollections.add(rec.reference.collection('reviews').get());
    }

    final List<QuerySnapshot<Object?>> subCollectionSnapshots =
        await Future.wait(recipeSubCollections);

    for (int i = 0; i < recipeSnapshot.docs.length; i++) {
      final QueryDocumentSnapshot rec = recipeSnapshot.docs[i];
      final String id = rec.get('id') as String;
      final String title = rec.get('title') as String;
      final String photoUrl = rec.get('photoUrl') as String;
      final int calories = rec.get('calories') as int;
      final int time = rec.get('time') as int;
      final String description = rec.get('description') as String;
      final bool isTopRecipe = rec.get('isTopRecipe') as bool;

      final Timestamp timestamp = rec.get('dateCreated') as Timestamp;
      final DateTime dateCreated = timestamp.toDate();

      final List<Ingredient> ingredientList =
          (subCollectionSnapshots[i * 3] as QuerySnapshot<Map<String, dynamic>>)
              .docs
              .map((i) => Ingredient.fromMap(i.data()))
              .toList();
      final List<Tutorial> tutorialsList = (subCollectionSnapshots[i * 3 + 1]
              as QuerySnapshot<Map<String, dynamic>>)
          .docs
          .map((t) => Tutorial.fromMap(t.data()))
          .toList();
      final List<Review> reviewList = (subCollectionSnapshots[i * 3 + 2]
              as QuerySnapshot<Map<String, dynamic>>)
          .docs
          .map((r) => Review.fromMap(r.data()))
          .toList();

      final Recipe recipe = Recipe(
        id: id,
        title: title,
        photoUrl: photoUrl,
        calories: calories,
        time: time,
        description: description,
        dateCreated: dateCreated,
        ingredients: ingredientList,
        tutorials: tutorialsList,
        reviews: reviewList,
        isTopRecipe: isTopRecipe,
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

    // Use RegExp to perform a case-insensitive search
    final RegExp regExp = RegExp(searchQuery, caseSensitive: false);

    // Filter the list based on the search query using RegExp
    List<Recipe> filteredList =
        recipes.where((recipe) => regExp.hasMatch(recipe.title)).toList();

    return filteredList;
  }

  List<Ingredient> searchIngredients(
      List<Ingredient> ingredients, String searchQuery) {
    if (searchQuery.isEmpty) {
      // If the search query is empty, return the original list
      return ingredients;
    }

    // Convert the search query to lowercase for case-insensitive search
    String lowercaseQuery = searchQuery.toLowerCase();

    // Filter the list based on the search query
    List<Ingredient> filteredList = ingredients.where((ingredient) {
      String lowercaseTitle = ingredient.name.toLowerCase();
      return lowercaseTitle.contains(lowercaseQuery);
    }).toList();

    return filteredList;
  }

  Future<void> addRecipe(Recipe recipe, String userId) async {
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
      'dateCreated': recipe.dateCreated
    });

    // Update the user's myRecipes list with the recipe ID
    final userDoc = _usersCollection.doc(userId);
    final userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      List<dynamic> myRecipes = (userData['myRecipes'] ?? []) as List<dynamic>;
      myRecipes.add(recipeId);

      await userDoc.update({'myRecipes': myRecipes});
    } else {
      throw Exception('User document not found');
    }

    // Add ingredients to Ingredients sub-collection
    if (recipe.ingredients != null) {
      CollectionReference ingredientCollection =
          docRecipe.collection('ingredients');
      for (Ingredient ingredient in recipe.ingredients!) {
        // Create a new document in the Ingredients sub-collection
        DocumentReference ingredientDoc =
            ingredientCollection.doc(ingredient.id);

        // Set the data for the ingredient document
        await ingredientDoc.set({
          'id': ingredient.id,
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
    await _recipesCollection.doc(recipe.id).delete();
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

  Future<List<Recipe>> getRecipesByIngredients(
      List<Ingredient> selectedIngredients) async {
    // Get full recipe list
    List<Recipe> recipesList = await getAllRecipes();

    List<Recipe> filteredRecipes = [];

    // Iterate through the recipe list
    for (Recipe recipe in recipesList) {
      bool containsAllIngredients = true;

      // Check if the recipe contains all the selected ingredient IDs
      for (Ingredient selectedIngredient in selectedIngredients) {
        bool containsSelectedIngredient = false;

        // Check if the recipe contains the selected ingredient ID
        for (Ingredient recipeIngredient in recipe.ingredients!) {
          if (recipeIngredient.id == selectedIngredient.id) {
            containsSelectedIngredient = true;
            break;
          }
        }

        // If the recipe does not contain the selected ingredient, break the loop
        if (!containsSelectedIngredient) {
          containsAllIngredients = false;
          break;
        }
      }

      if (containsAllIngredients) {
        filteredRecipes.add(recipe);
      }
    }

    return filteredRecipes;
  }
}
