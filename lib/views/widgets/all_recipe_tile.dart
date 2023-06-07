import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogoos_app/controllers/recipe_controller.dart';
import 'package:gogoos_app/models/recipe.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../screens/detail_recipe_screen.dart';
import '../utils/app_color.dart';

class AllRecipesTile extends StatelessWidget {
  const AllRecipesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: RecipeController().getAllRecipes(),
      builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while fetching data
        }

        if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show an error message if there's an error
        }
        List<Recipe> recipes = snapshot.data ?? []; // Retr
        return ListView.builder(
          shrinkWrap: true,
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            Recipe recipe = recipes[index];
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
                  borderRadius: BorderRadius.circular(10),
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
                            fit: BoxFit.cover),
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
                                // data.title,
                                recipe.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'inter'),
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
        );
      },
    );
  }
}
