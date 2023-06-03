import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/controllers/user_controller.dart';
import 'package:gogoos_app/views/screens/user_profile/components/profile_header.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:gogoos_app/views/widgets/button.dart';
import 'package:image_picker/image_picker.dart';

import 'components/edit_user_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<EditProfileScreen> {
  final _nameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
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
                    ProfileScreenHeader(),
                    SizedBox(height: 20),

                    /// -- IMAGE
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: InkWell(
                          onTap: () {
                            UserController().uploadProfileImg();
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: userData['profileImg'] == ""
                                ? const Center(
                                    child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ))
                                : Image.network(userData['profileImg']),
                          )),
                    ),
                    // Form
                    EditProfileTextField(
                        controller: _nameTextController,
                        hintText: 'Name',
                        obsecureText: false,
                        color: AppColor.darkColor,
                        inputType: TextInputType.text,
                        icon: const Icon(Icons.text_fields)),
                    const SizedBox(height: 5),
                    EditProfileTextField(
                        controller: _usernameTextController,
                        hintText: 'Name',
                        obsecureText: false,
                        color: AppColor.lightColor,
                        inputType: TextInputType.text,
                        icon: const Icon(Icons.text_fields)),
                    const SizedBox(height: 5),
                    EditProfileTextField(
                        controller: _emailTextController,
                        hintText: 'Email Address',
                        obsecureText: false,
                        color: AppColor.lightColor,
                        inputType: TextInputType.emailAddress,
                        icon: const Icon(Icons.mail)),
                    const SizedBox(height: 5),
                    EditProfileTextField(
                        controller: _phoneNumberController,
                        hintText: 'Password',
                        obsecureText: true,
                        color: AppColor.lightColor,
                        inputType: TextInputType.visiblePassword,
                        icon: const Icon(Icons.key)),
                    const SizedBox(height: 30),
                    Mybutton(
                      onTap: () {},
                      text: 'Submit',
                    )
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
