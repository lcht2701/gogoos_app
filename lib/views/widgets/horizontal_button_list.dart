// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../screens/book_selling_screen.dart';
import '../screens/fridge_cleaning_screen.dart';

class HorizontalButtonList extends StatefulWidget {
  const HorizontalButtonList({super.key});

  @override
  State<HorizontalButtonList> createState() => _HorizontalButtonListState();
}

class _HorizontalButtonListState extends State<HorizontalButtonList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWithIcon(
          buttonText: 'Fridge',
          icon: LineAwesomeIcons.utensils,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FridgeCleaningScreen()),
            );
          },
        ),
        ButtonWithIcon(
          buttonText: 'Book',
          icon: LineAwesomeIcons.book,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BookSellingScreen()),
            );
          },
        ),
      ],
    );
  }
}

class ButtonWithIcon extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonWithIcon({
    Key? key,
    required this.buttonText,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(30)),
                  color: Colors.orange),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              buttonText,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
