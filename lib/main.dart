
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:socialmedia/presentation/login_screen/controller/login_controller.dart';
import 'package:socialmedia/presentation/login_screen/view/login_screen.dart';
import 'package:socialmedia/presentation/news_screen/controller/news_controller.dart';
import 'package:socialmedia/presentation/registration_screen/controller/registration_controller.dart';
import 'package:socialmedia/presentation/registration_screen/view/registration_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BottomNavController()),
    ChangeNotifierProvider(create: (context) => NewsController()),
    ChangeNotifierProvider(create: (context) => loginController()),
    ChangeNotifierProvider(create: (context) => RegistrationController()),

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorTheme.brown),
        useMaterial3: true,
      ),
      home: RegistrationScreen(
      ),
    );
  }
}
