import 'package:flutter/material.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

class MyFilledbutton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;

  const MyFilledbutton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 85 / 100,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class BorderedButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? filledColor;
  const BorderedButton({
    super.key,
    this.onTap,
    required this.text,
    this.filledColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 85 / 100,
        height: 40,
        decoration: BoxDecoration(
          color: filledColor,
          border: Border.all(
            color: Colors.orange,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
