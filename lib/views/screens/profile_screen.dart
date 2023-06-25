import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../widgets/profile_menu_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/add_recipe');
            },
            child: const Icon(
              Icons.add_box_outlined,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (BuildContext context) {
                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: 10,
                          child: Container(
                            height: 4,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ProfileMenuWidget(
                                title: "Edit Profile",
                                icon: LineAwesomeIcons.user_cog,
                                iconColor: Colors.black,
                                textColor: Colors.black,
                                endIcon: false,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/edit_profile');
                                },
                              ),
                              ProfileMenuWidget(
                                title: "Logout",
                                icon: LineAwesomeIcons.alternate_sign_out,
                                iconColor: Colors.red,
                                textColor: Colors.red,
                                endIcon: false,
                                onPressed: () {
                                  AuthController().signOut();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(
              LineAwesomeIcons.bars,
              color: Colors.black,
            ),
          ),
        ],
      ),
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
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    /// -- USER PROFILE
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Profile Image + Numbers
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Images
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: userData['profileImg'] != null
                                          ? Image.network(
                                              userData['profileImg'],
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey,
                                                );
                                              },
                                            )
                                          : Container(
                                              color: Colors.grey,
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColor.orangeColor,
                                      ),
                                      child: IconButton(
                                        color: Colors.white,
                                        iconSize: 20,
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          UserController()
                                              .uploadProfileImg(); // Call the function without assigning its result
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Numbers
                              const Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '8',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text('Recipes'),
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    children: [
                                      Text(
                                        '8',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text('Followers'),
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    children: [
                                      Text(
                                        '8',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text('Followings'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //User Name
                          Container(
                            padding: const EdgeInsets.only(top: 15, left: 5),
                            child: Text(
                              userData['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
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
