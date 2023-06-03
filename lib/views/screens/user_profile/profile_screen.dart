import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/screens/user_profile/components/profile_header.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:gogoos_app/views/widgets/button.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/user_controller.dart';
import 'components/profile_menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

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
            return Container(
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
                    Text(
                      // user.name,
                      userData['name'],
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    // Text('@${user.username}'),
                    Text('@${userData['username']}'),
                    const SizedBox(height: 20),

                    /// -- BUTTON
                    SizedBox(
                      width: 200,
                      child: Mybutton(
                        onTap: () {},
                        text: 'Edit Profile',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // -- MENU
                    ProfileMenuWidget(
                      title: "Settings",
                      icon: Icons.settings,
                      onPress: () {},
                    ),
                    const SizedBox(height: 15),
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
