import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../models/recipe.dart';
import '../screens/detail_recipe_screen.dart';
import '../utils/app_color.dart';

class FridgeCleaningRecipeTile extends StatelessWidget {
  const FridgeCleaningRecipeTile({
    super.key,
    required List<Recipe> recipes,
  }) : _recipes = recipes;

  final List<Recipe> _recipes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          Recipe recipe = _recipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(
                    data: recipe,
                  ),
                ),
              );
            },
            child: Container(
              height: 90,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  // Recipe Photo
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueGrey,
                      image: DecorationImage(
                        image: NetworkImage(recipe.photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Recipe Info
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Recipe title
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              recipe.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Recipe Calories and Time
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    LineAwesomeIcons.stopwatch,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      '${recipe.time} min',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  const Icon(
                                    LineAwesomeIcons.fire,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      '${recipe.calories} calories',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
