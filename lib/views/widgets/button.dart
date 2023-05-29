import 'package:flutter/material.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

class Mybutton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const Mybutton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 85 / 100,
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.orangeSoftColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
