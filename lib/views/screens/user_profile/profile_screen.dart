import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/screens/user_profile/components/profile_header.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/user_controller.dart';
import 'components/profile_menu_widget.dart';
import 'components/profile_text_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  //all user
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');
  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.white),
          ),
          onChanged: (value) => newValue = value,
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          //save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 32,
                  left: 16,
                  right: 16,
                ),
                child: Center(
                  child: Column(
                    children: [
                      const ProfileScreenHeader(),
                      const SizedBox(height: 20),

                      /// -- IMAGE
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: NetworkImage(userData['profileImg']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColor.orangeColor,
                              ),
                              child: IconButton(
                                color: Colors.white,
                                iconSize: 20,
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  UserController()
                                      .uploadProfileImg(); // Call the function without assigning its result
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ProfileTextBoxWidget(
                        sectionName: 'Name',
                        text: userData['name'],
                        onPressed: () => editField('name'),
                      ),
                      ProfileTextBoxWidget(
                        sectionName: 'Username',
                        text: userData['username'],
                        onPressed: () => editField('username'),
                      ),
                      ProfileTextBoxWidget(
                        sectionName: 'Phone Number',
                        text: userData['phoneNumber'],
                        onPressed: () => editField('phoneNumber'),
                      ),
                      const SizedBox(height: 20),
                      ProfileMenuWidget(
                        title: "Logout",
                        icon: Icons.logout,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          AuthController().signOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
