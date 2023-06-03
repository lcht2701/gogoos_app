import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:gogoos_app/views/auth/auth_screen.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

import 'package:firebase_core/firebase_core.dart';
import 'controllers/user_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //remove splash screen
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: AppColor.primaryColor,
      ),
      home: const AuthScreen(),
    );
  }
}
