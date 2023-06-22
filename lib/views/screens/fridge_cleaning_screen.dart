import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/controllers/user_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../controllers/recipe_controller.dart';
import '../../models/ingredient.dart';
import '../../models/recipe.dart';
import '../../models/role.dart';
import '../utils/app_color.dart';
import '../widgets/fridge_cleaning_recipe_tile.dart';

class FridgeCleaningScreen extends StatefulWidget {
  const FridgeCleaningScreen({Key? key}) : super(key: key);

  @override
  State<FridgeCleaningScreen> createState() => _FridgeCleaningScreenState();
}

class _FridgeCleaningScreenState extends State<FridgeCleaningScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Ingredient> _ingredientList = [];
  List<Ingredient> _filteredIngredients = [];
  final List<Ingredient> _selectedIngredients = [];
  List<Recipe> _recipes = [];
  late UserRole _userRole;
  bool showIngredientsList = false;

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  void _loadIngredients() async {
    RecipeController recipeController = RecipeController();
    List<Ingredient> ingredients = await recipeController.getAllIngredients();
    setState(() {
      _ingredientList = ingredients;
    });

    String? userRole = await UserController().getUserRole();
    if (userRole != null && mounted) {
      setState(() {
        _userRole = (userRole == 'Free' ? UserRole.Free : UserRole.Premium);
      });
    }
  }

  void _searchIngredients(String searchQuery) {
    RecipeController recipeController = RecipeController();
    if (searchQuery.isEmpty || searchQuery == "") {
      _filteredIngredients = [];
    } else {
      _filteredIngredients = recipeController.searchIngredients(
        _ingredientList,
        searchQuery,
      );
    }
    setState(() {
      showIngredientsList = true;
    });
  }

  void _selectIngredient(Ingredient ingredient) {
    if (_userRole == UserRole.Free && _selectedIngredients.length >= 2) {
      // User is a free user and has already selected 2 ingredients
      _showMessage('Free users can only select 2 ingredients.');
      return;
    }

    setState(() {
      if (!_selectedIngredients.contains(ingredient)) {
        _selectedIngredients.add(ingredient);
        _searchRecipes();
        _searchController.clear();
        showIngredientsList = false;
      }
    });
  }

  void _removeIngredient(Ingredient ingredient) {
    setState(() {
      _selectedIngredients.remove(ingredient);
      _searchRecipes(); // Call searchRecipes when ingredient is removed
    });
  }

  void _searchRecipes() {
    RecipeController recipeController = RecipeController();
    recipeController
        .getRecipesByIngredients(_selectedIngredients)
        .then((recipes) {
      setState(() {
        _recipes = recipes;
      });
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ),
        title: const Text(
          'Fridge Cleaning',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _searchController,
                cursorColor: AppColor.darkColor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 24,
                  ),
                  hintText: 'Select your ingredients',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                onChanged: _searchIngredients,
              ),
            ),

            // Ingredient List
            Expanded(
              child: showIngredientsList
                  ? ListView.builder(
                      itemCount: _filteredIngredients.length,
                      itemBuilder: (context, index) {
                        Ingredient ingredient = _filteredIngredients[index];
                        return ListTile(
                          title: Text(ingredient.name),
                          onTap: () => _selectIngredient(ingredient),
                        );
                      },
                    )
                  : Container(
                      height: 0,
                    ),
            ),

            // Selected Ingredients
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 40, // Specify the desired height of the list view
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedIngredients.length,
                itemBuilder: (context, index) {
                  Ingredient ingredient = _selectedIngredients[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InputChip(
                      label: Text(ingredient.name),
                      deleteIcon: const Icon(
                        LineAwesomeIcons.times,
                        size: 14,
                      ),
                      onDeleted: () => _removeIngredient(ingredient),
                    ),
                  );
                },
              ),
            ),

            // Recipe List
            FridgeCleaningRecipeTile(recipes: _recipes),
          ],
        ),
      ),
    );
  }
}
