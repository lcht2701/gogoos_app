import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gogoos_app/views/screens/recipe_detail/detail_recipe_screen.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/recipe.dart';
import 'models/tutorial_step.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //remove splash screen
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
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
      home:
          // const AuthScreen()

          RecipeDetailScreen(
              data: Recipe(
                  title: "Breakfast Delimenu.",
                  photo: 'assets/images/list3.jpg',
                  calories: '870 Cal',
                  time: '32 min',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
                  ingredients: [],
                  tutorial: [
            TutorialStep(
                step: '1. Tuangkan Air.',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat')
          ],
                  reviews: [])),
    );
  }
}
