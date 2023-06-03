import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeController {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Recipes');
  final _currentUser = FirebaseAuth.instance.currentUser;
}
