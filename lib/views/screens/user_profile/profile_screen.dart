import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogoos_app/views/auth/auth_controller.dart';
import 'package:gogoos_app/views/screens/user_profile/components/profile_header.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:gogoos_app/views/widgets/button.dart';

import 'components/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage('assets/images/hamburger.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.orangeColor),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Full Name',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Text('@' + 'username'),
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
                  AuthController().logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
