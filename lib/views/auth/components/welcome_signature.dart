import 'package:flutter/material.dart';

class WelcomeSignature extends StatelessWidget {
  const WelcomeSignature({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Image(
            image: AssetImage('assets/images/logo_light.PNG'),
            height: 150,
            width: 150,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text('GOGOO\'S RECIPES',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                  color: Colors.white)),
        ),
        Text(
          "Good Taste - Good Life",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
