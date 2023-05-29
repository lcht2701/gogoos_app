import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogoos_app/models/recipe.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'views/screens/home_screen.dart';
import 'views/screens/profile_screen.dart';
import 'views/screens/recipe_detail_screen.dart';
import 'views/screens/welcome_screen.dart';
import 'views/screens/login_screen.dart';
import 'views/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: AppColor.primaryColor,
      ),
      home: const ProfilePage(),
    );
  }
}
