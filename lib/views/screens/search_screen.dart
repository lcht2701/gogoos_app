import 'package:flutter/material.dart';
import 'package:gogoos_app/controllers/recipe_controller.dart';
import 'package:gogoos_app/models/recipe.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:gogoos_app/views/widgets/search_with_filter.dart';

import '../widgets/search_recipe_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];
  String _searchQuery = '';

  @override
  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    List<Recipe> recipes = await RecipeController().getAllRecipes();
    setState(() {
      _recipes = recipes;
    });
  }

  void _searchRecipes(String searchQuery) {
    setState(() {
      _searchQuery = searchQuery;
      if (_searchQuery.isNotEmpty) {
        _filteredRecipes =
            RecipeController().searchRecipes(_recipes, searchQuery);
      } else {
        _filteredRecipes = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightColor,
      body: Container(
        margin: const EdgeInsets.only(
          top: 40,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            SearchWithFilter(
              onSearch: _searchRecipes,
            ),
            const SizedBox(height: 14),
            Expanded(
              child: SearchRecipeTile(data: _filteredRecipes),
            ),
          ],
        ),
      ),
    );
  }
}
