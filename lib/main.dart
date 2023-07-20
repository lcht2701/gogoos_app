import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gogoos_app/views/screens/add_recipe_screen.dart';
import 'package:gogoos_app/views/screens/edit_profile_screen.dart';
import 'package:gogoos_app/views/screens/home_screen.dart';
import 'package:gogoos_app/views/screens/momo_qr_screen.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'firebase_options.dart';
import 'package:gogoos_app/views/auth/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
      routes: {
        '/home': (context) => const HomeScreen(),
        '/add_recipe': (context) => const AddRecipeScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/momo_qr': (context) => const MomoQrCodeScreen(),
        '/auth': (context) => const AuthScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: AppColor.primaryColor,
      ),
      home: const AuthScreen(),
    );
  }
}
