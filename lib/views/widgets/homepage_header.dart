import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Welcome To ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
                children: [
                  TextSpan(
                    text: 'Gogoo\'s',
                    style: TextStyle(
                      color: AppColor.orangeColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Daily Quotes',
              style: TextStyle(
                color: AppColor.orangeColor,
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: FirebaseAuth.instance.signOut,
          icon: const Icon(
            Icons.notifications_outlined,
            size: 36,
          ),
        ),
      ],
    );
  }
}
