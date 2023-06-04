import 'package:flutter/material.dart';

class ProfileTextBoxWidget extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;

  const ProfileTextBoxWidget(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Section Name
              Text(
                sectionName,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              //Edit Button
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.settings,
                  size: 20,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
