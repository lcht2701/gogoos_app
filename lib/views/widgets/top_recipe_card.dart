import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:gogoos_app/controllers/recipe_controller.dart';
import 'package:gogoos_app/models/recipe.dart';

import '../screens/detail_recipe_screen.dart';
import '../utils/app_color.dart';

class TopRecipeCard extends StatelessWidget {
  const TopRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Recipe>> topRecipesFuture = RecipeController().getTopRecipes();

    return FutureBuilder<List<Recipe>>(
      future: topRecipesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<Recipe> recipes = snapshot.data ?? [];
        return SizedBox(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) {
              return const SizedBox(width: 16);
            },
            itemBuilder: (context, index) {
              Recipe recipe = recipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(data: recipe),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe Photo
                      Container(
                        width: MediaQuery.of(context).size.width * 45 / 100,
                        height: 120,
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
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Recipe title
                              Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  recipe.title,
                                  maxLines: 1,
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
                                          '${recipe.calories} cal',
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
      },
    );
  }
}
