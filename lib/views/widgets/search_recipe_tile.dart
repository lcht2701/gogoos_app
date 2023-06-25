// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gogoos_app/models/recipe.dart';

import '../screens/detail_recipe_screen.dart';
import '../utils/app_color.dart';

class SearchRecipeTile extends StatelessWidget {
  List<Recipe> data = [];
  SearchRecipeTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Recipe recipe = data[index];
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
                            ),
                          ),
                        ),
                        // Recipe Calories and Time
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.alarm,
                                  size: 12,
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
                                SvgPicture.asset(
                                    'assets/icons/fire-filled.svg'),
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
  }
}
