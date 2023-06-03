import 'package:firebase_auth/firebase_auth.dart';

import 'user_controller.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await UserController().createUser(email, name);
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
