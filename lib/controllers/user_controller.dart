import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

class UserController {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  final _currentUser = FirebaseAuth.instance.currentUser;
  Future<void> createUser(String email, String name) async {
    final docUser = usersCollection.doc(email);
    AppUser newUser = AppUser(
      username: email.split('@')[0],
      profileImg: '',
      name: name,
      email: email,
      phoneNumber: '',
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
    final email = _currentUser!.email;
    Reference ref = FirebaseStorage.instance.ref().child('$email.jpg');
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) async {
      await usersCollection.doc(email).update({"profileImg": value});
    });
  }
}