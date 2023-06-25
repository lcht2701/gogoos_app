import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/auth/verify_email_screen.dart';
import 'login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user is logged in
          if (snapshot.hasData) {
            return const VerifyEmailScreen();
          }
          //if user is NOT logged in
          else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
