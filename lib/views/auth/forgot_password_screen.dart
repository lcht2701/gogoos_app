import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/widgets/button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../utils/app_color.dart';
import '../widgets/text_field.dart';
import 'components/welcome_signature.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailTextController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool _isButtonDisabled = false;

  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
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
                          margin: const EdgeInsets.only(bottom: 30),
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // Form
                        MyTextField(
                          controller: emailTextController,
                          hintText: 'Email Address',
                          obsecureText: false,
                          color: AppColor.lightColor,
                          inputType: TextInputType.emailAddress,
                          icon: const Icon(LineAwesomeIcons.envelope),
                        ),
                      ],
                    ),
                    MyFilledbutton(
                      text: 'Submit',
                      onTap: _isButtonDisabled ? null : resetPassword,
                      color: AppColor.orangeSoftColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    setState(() {
      _isButtonDisabled = true;
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailTextController.text.trim());
      _showSnackbar('Password reset email sent. Please check your email!');

      // Delay the button re-enabling for 5 seconds
      await Future.delayed(const Duration(seconds: 5));
    } catch (error) {
      _showSnackbar('Error: $error');
    }

    setState(() {
      _isButtonDisabled = false;
    });
  }

  void _showSnackbar(String message) {
    final snackbar = SnackBar(content: Text(message));
    _scaffoldKey.currentState?.showSnackBar(snackbar);
  }
}
