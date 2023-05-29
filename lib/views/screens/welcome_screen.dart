import 'package:flutter/material.dart';
import '../widgets/welcome_signature.dart';

import '../utils/app_color.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 97 / 100,
            decoration: BoxDecoration(gradient: AppColor.linearBlackBottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const WelcomeSignature(),
                const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text('Let\'s\nCooking',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                              color: Colors.white)),
                    ),
                    Text("Find Best Recipes For Cooking",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Get Started Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 85 / 100,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: AppColor.orangeSoftColor,
                        ),
                        onPressed: () {},
                        child: Text('Get Started',
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter')),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Log in Button
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: TextButton(
              onPressed: () {},
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Already Registered? ',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), height: 150 / 100),
                  children: [
                    TextSpan(
                      text: 'Login Now! ',
                      style: TextStyle(
                          color: AppColor.orangeColor,
                          fontWeight: FontWeight.w700,
                          height: 150 / 100),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
