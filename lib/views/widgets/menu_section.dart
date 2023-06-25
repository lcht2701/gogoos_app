// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class MenuSection extends StatelessWidget {
  final String leftText;
  final String textButton;
  final Function() onPressed;

  const MenuSection({
    Key? key,
    required this.leftText,
    required this.textButton,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: TextStyle(
              color: AppColor.darkColor,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              textButton,
              style: TextStyle(
                color: AppColor.orangeColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
