// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole {
  Admin,
  Premium,
  Free,
}

void initializeUserRolesCollection() async {
  // Initialize Firebase
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Define a collection reference
  CollectionReference userRolesCollection = firestore.collection('userRoles');

  // Add documents for each enum value
  for (UserRole role in UserRole.values) {
    await userRolesCollection.doc(role.toString().split('.').last).set({});
  }
}
