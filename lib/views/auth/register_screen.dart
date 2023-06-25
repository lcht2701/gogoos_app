import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/auth/login_screen.dart';
import 'package:gogoos_app/views/widgets/button.dart';
import 'package:gogoos_app/views/widgets/text_field.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../utils/app_color.dart';
import 'components/welcome_signature.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmpasswordTextController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //make sure password match
    if (_confirmpasswordTextController.text != _passwordTextController.text) {
      //pop loading circle
      Navigator.pop(context);
      //display error message
      displayMessage("Password don't match");
      return;
    }

    try {
      await AuthController().registerWithEmailAndPassword(
        _emailTextController.text,
        _passwordTextController.text,
        _nameTextController.text,
      );
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/auth');
      }
    } on FirebaseAuthException catch (e) {
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
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Form
                    MyTextField(
                        controller: _nameTextController,
                        hintText: 'Name',
                        obsecureText: false,
                        color: AppColor.lightColor,
                        inputType: TextInputType.text,
                        icon: const Icon(LineAwesomeIcons.user)),
                    MyTextField(
                        controller: _emailTextController,
                        hintText: 'Email Address',
                        obsecureText: false,
                        color: AppColor.lightColor,
                        inputType: TextInputType.emailAddress,
                        icon: const Icon(LineAwesomeIcons.envelope)),
                    MyTextField(
                        controller: _passwordTextController,
                        hintText: 'Password',
                        obsecureText: true,
                        color: AppColor.lightColor,
                        inputType: TextInputType.visiblePassword,
                        icon: const Icon(LineAwesomeIcons.key)),
                    MyTextField(
                        controller: _confirmpasswordTextController,
                        hintText: 'Confirm Password',
                        obsecureText: true,
                        color: AppColor.lightColor,
                        inputType: TextInputType.visiblePassword,
                        icon: const Icon(LineAwesomeIcons.key)),
                  ],
                ),
                MyFilledbutton(
                  onTap: signUp,
                  text: 'Sign Up',
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
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
