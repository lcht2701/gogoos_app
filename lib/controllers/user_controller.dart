import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gogoos_app/models/role.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

class UserController {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('Users');
  final _auth = FirebaseAuth.instance;

  Future<void> createUser(String email, String name) async {
    final docUser = _usersCollection.doc(_auth.currentUser!.uid);
    AppUser newUser = AppUser(
      id: docUser.id,
      username: email.split('@')[0],
      profileImg: '',
      name: name,
      email: email,
      phoneNumber: '',
      role: UserRole.Free,
    );
    docUser.set(newUser.toMap());
  }

  Future<void> uploadProfileImg() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    //get user id to find collection
    final uid = _auth.currentUser!.uid;
    //use email to name the profile img
    final email = _auth.currentUser!.email;

    Reference ref = FirebaseStorage.instance.ref().child('$email.jpg');
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) async {
      await _usersCollection.doc(uid).update({"profileImg": value});
    });
  }

  Future<User?> getCurrentUser() async {
    try {
      final User? user = _auth.currentUser;
      return user;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  Future<String?> getUserRole() async {
    try {
      final User? user = await getCurrentUser();
      if (user != null) {
        final DocumentSnapshot snapshot =
            await _usersCollection.doc(user.uid).get();
        final data = snapshot.data() as Map<String, dynamic>?;
        final String? userRole = data?['role'];
        return userRole;
      }
    } catch (e) {
      print('Error getting user role: $e');
    }
    return null;
  }
}
