import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenImage extends StatelessWidget {
  final String image;

  const FullScreenImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        // Image Wrapper
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          // Image Widget
          child: Image(image: NetworkImage(image)),
        ),
      ),
    );
  }
}
