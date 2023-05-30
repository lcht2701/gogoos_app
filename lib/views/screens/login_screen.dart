import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/screens/forgot_password_screen.dart';
import 'package:gogoos_app/views/widgets/button.dart';
import 'package:gogoos_app/views/widgets/text_field.dart';

import '../auth/auth_controller.dart';
import '../utils/app_color.dart';
import '../widgets/welcome_signature.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //try sign in
    try {
      Auth().registerWithEmailAndPassword(
          _emailTextController.value.text, _passwordTextController.value.text);
      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //display error message
      displayMessage(e.code);
    }
  }

  //display dialog message
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

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
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter'),
                      ),
                    ),
                    // Form
                    MyTextField(
                        controller: _emailTextController,
                        hintText: 'Email Address',
                        obsecureText: false,
                        color: AppColor.lightColor,
                        inputType: TextInputType.emailAddress,
                        icon: const Icon(Icons.mail)),
                    MyTextField(
                        controller: _passwordTextController,
                        hintText: 'Password',
                        obsecureText: true,
                        color: AppColor.lightColor,
                        inputType: TextInputType.visiblePassword,
                        icon: const Icon(Icons.key)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen()));
                          },
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
                Mybutton(
                  onPressed: signIn,
                  text: 'Log in',
                ),
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
                'Don\'t have a account?',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    height: 150 / 100,
                    fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterScreen()));
                },
                child: Text(
                  'Sign Up Now!',
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
