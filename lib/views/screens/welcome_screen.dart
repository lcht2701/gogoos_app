import 'package:flutter/material.dart';
import 'package:gogoos_app/views/screens/login_screen.dart';
import 'package:gogoos_app/views/screens/register_screen.dart';
import '../widgets/welcome_signature.dart';

import '../utils/app_color.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        },
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
      ],
    ));
  }
}
