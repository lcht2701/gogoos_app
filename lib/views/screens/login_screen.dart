import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../widgets/welcome_signature.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

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
                Column(
                  children: [
                    // header
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter'),
                      ),
                    ),
                    // Form
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: TextField(
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(Icons.mail),
                            prefixIconColor: Colors.white),
                      ),
                    ),
                    const TextField(
                      cursorColor: Colors.white,
                      obscureText: true,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(Icons.key),
                          prefixIconColor: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {},
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(
                                color: AppColor.lightColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'inter',
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                                style: TextStyle(
                                  color: AppColor.orangeColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'inter',
                                ),
                                text: 'Forgot Password?'),
                          ),
                        ),
                      ],
                    ),
                    // Log in Button
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
                        child: Text('Login',
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
                ),
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
                  text: 'Don\'t have a account? ',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), height: 150 / 100),
                  children: [
                    TextSpan(
                      text: 'Sign Up Now! ',
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
