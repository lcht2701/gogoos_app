// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../models/recipe.dart';

class TopRecipeCard extends StatefulWidget {
  final Recipe? recipe;
  const TopRecipeCard({Key? key, this.recipe}) : super(key: key);

  @override
  State<TopRecipeCard> createState() => _TopRecipeCardState();
}

class _TopRecipeCardState extends State<TopRecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recipe Photo
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width * 45 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey,
            image: const DecorationImage(
              image: AssetImage('assets/images/pancake.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Recipe title
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 8),
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            // data.title,
            widget.recipe!.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Recipe calories and time
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
                    '${widget.recipe?.time} min',
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
                    '${widget.recipe?.calories} calories',
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
