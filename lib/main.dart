import 'package:flutter/material.dart';
import 'package:gogoos_app/views/auth/auth_screen.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: AppColor.primaryColor,
      ),
      home: const AuthPage(),
    );
  }
}
