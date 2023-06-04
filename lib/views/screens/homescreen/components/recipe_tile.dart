import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.all(10),
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
                  image: AssetImage('assets/images/pancake.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          // Recipe Info
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe title
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Text(
                      // data.title,
                      'Pancake',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontFamily: 'inter'),
                    ),
                  ),
                  // Recipe Calories and Time
                  Row(
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
                      SizedBox(
                        width: 10,
                      ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
