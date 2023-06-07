import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gogoos_app/models/ingredient.dart';
import 'package:gogoos_app/models/review.dart';
import 'package:gogoos_app/models/tutorial.dart';

import '../models/recipe.dart';

class RecipeController {
  final CollectionReference _recipesCollection =
      FirebaseFirestore.instance.collection('Recipes');

  Future<List<Recipe>> getAllRecipes() async {
    List<Recipe> recipesList = [];
    List<Ingredient> ingredientList = [];
    List<Tutorial> tutorialsList = [];
    List<Review> reviewList = [];

    //Add Recipe Information
    QuerySnapshot<Object?> recipeSnapshot = await _recipesCollection.get();
    for (var rec in recipeSnapshot.docs) {
      String id = rec.get('id');
      String title = rec.get('title');
      String photoUrl = rec.get('photoUrl');
      int calories = rec.get('calories');
      int time = rec.get('time');
      String description = rec.get('description');

      //add ingredients' list
      QuerySnapshot<Map<String, dynamic>> ingredientSnapshot =
          await rec.reference.collection('Ingredients').get();

      for (var i in ingredientSnapshot.docs) {
        String iid = i.get('id');
        String iname = i.get('name');
        int iamount = i.get('amount');
        String iunit = i.get('unit');

        Ingredient ingredient = Ingredient(
          id: iid,
          amount: iamount,
          name: iname,
          unit: iunit,
        );
        ingredientList.add(ingredient);
      }

      //add tutorial steps
      QuerySnapshot<Map<String, dynamic>> tutorialSnapshot =
          await rec.reference.collection('Tutorials').get();

      for (var t in tutorialSnapshot.docs) {
        String tid = t.get('id');
        String tstep = t.get('step');
        String tdescription = t.get('description');

        Tutorial tutorial = Tutorial(
          id: tid,
          step: tstep,
          description: tdescription,
        );
        tutorialsList.add(tutorial);
      }

      //add tutorial steps
      QuerySnapshot<Map<String, dynamic>> reviewSnapshot =
          await rec.reference.collection('Reviews').get();

      for (var rev in reviewSnapshot.docs) {
        String rid = rev.get('id');
        String rreview = rev.get('review');
        String rusername = rev.get('username');
        Review review = Review(
          id: rid,
          review: rreview,
          username: rusername,
        );

        reviewList.add(review);
      }

      //add recipe information
      Recipe recipe = Recipe(
          id: id,
          title: title,
          photoUrl: photoUrl,
          calories: calories,
          time: time,
          description: description,
          ingredients: ingredientList,
          tutorials: tutorialsList,
          reviews: reviewList);
      recipesList.add(recipe);
    }
    return recipesList;
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

  Future addRecipe(Recipe recipe) async {
    await _recipesCollection.doc().set(recipe.toMap());
  }

  Future updateRecipe(Recipe recipe) async {
    await _recipesCollection.doc(recipe.id).update(recipe.toMap());
  }

  Future deleteRecipe(Recipe recipe) async {
    await _recipesCollection.doc().delete();
  }
}
