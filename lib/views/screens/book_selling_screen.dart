import 'package:flutter/material.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

class BookSellingScreen extends StatefulWidget {
  const BookSellingScreen({super.key});

  @override
  State<BookSellingScreen> createState() => _BookSellingScreenState();
}

class _BookSellingScreenState extends State<BookSellingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: AppColor.orangeColor,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // title: const Text(
        //   'Edit Profile',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //   ),
        // ),
      ),
      body: const Center(
        child: Text(
          "Currently, this feature continues to get developed. Please return later!",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
