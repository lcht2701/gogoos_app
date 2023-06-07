import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeScreenFunctions extends StatefulWidget {
  const HomeScreenFunctions({super.key});

  @override
  State<HomeScreenFunctions> createState() => _HomeScreenFunctionsState();
}

class _HomeScreenFunctionsState extends State<HomeScreenFunctions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black, width: 3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(LineAwesomeIcons.book),
            iconSize: 36,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LineAwesomeIcons.book),
            iconSize: 36,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
