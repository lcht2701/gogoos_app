import 'package:flutter/material.dart';

class HomePageFunctions extends StatefulWidget {
  const HomePageFunctions({super.key});

  @override
  State<HomePageFunctions> createState() => _HomePageFunctionsState();
}

class _HomePageFunctionsState extends State<HomePageFunctions> {
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
            icon: Icon(Icons.book),
            iconSize: 36,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.book),
            iconSize: 36,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
