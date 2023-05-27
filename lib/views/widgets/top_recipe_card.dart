import 'package:flutter/material.dart';

class TopRecipeCard extends StatelessWidget {
  const TopRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Photo
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width * 45 / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey,
              image: DecorationImage(
                image: AssetImage('assets/images/pancake.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Recipe title
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 8),
            padding: EdgeInsets.only(left: 4),
            child: Text(
              // data.title,
              'Pancake',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Recipe calories and time
          Container(
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      size: 12,
                      color: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        '25 min',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(
                      Icons.dining_rounded,
                      size: 12,
                      color: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        '1 serving',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
