import 'package:flutter/material.dart';
import 'package:gogoos_app/views/screens/login_screen.dart';
import 'package:gogoos_app/views/widgets/button.dart';

import '../utils/app_color.dart';
import '../widgets/text_field.dart';
import '../widgets/welcome_signature.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailTextController = TextEditingController();

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
                Column(
                  children: [
                    // header
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter'),
                      ),
                    ),
                    // Form
                    MyTextField(
                        controller: emailTextController,
                        hintText: 'Email Address',
                        obsecureText: false,
                        color: AppColor.lightColor,
                        inputType: TextInputType.emailAddress,
                        icon: const Icon(Icons.mail)),
                  ],
                ),
                Mybutton(
                  text: 'Submit',
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already Have A Account?',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  height: 150 / 100,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Sign In Now!',
                  style: TextStyle(
                      color: AppColor.orangeColor,
                      fontWeight: FontWeight.w700,
                      height: 150 / 100),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
