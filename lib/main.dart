import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:socialmedia/presentation/chat_screen/controller/chat_controller.dart';
import 'package:socialmedia/presentation/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';
import 'package:socialmedia/presentation/login_screen/controller/login_controller.dart';
import 'package:socialmedia/presentation/message_screen/controller/message_screen_controller.dart';
import 'package:socialmedia/presentation/news_screen/controller/news_controller.dart';
import 'package:socialmedia/presentation/post_screen/controller/post_controller.dart';
import 'package:socialmedia/presentation/profile_screen/controller/profile_controller.dart';
import 'package:socialmedia/presentation/registration_screen/controller/registration_controller.dart';
import 'package:socialmedia/presentation/search_screen/controller/search_controller.dart';
import 'package:socialmedia/presentation/splash_screen/view/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BottomNavController()),
    ChangeNotifierProvider(create: (context) => NewsController()),
    ChangeNotifierProvider(create: (context) => loginController()),
    ChangeNotifierProvider(create: (context) => RegistrationController()),
    ChangeNotifierProvider(create: (context) => ProfileController()),
    ChangeNotifierProvider(create: (context) => PostController()),
    ChangeNotifierProvider(create: (context) => EditProfileController()),
    ChangeNotifierProvider(create: (context) => HomeController()),
    ChangeNotifierProvider(create: (context) => SearchScreenController()),
    ChangeNotifierProvider(create: (context) => MessageScreenController()),
    ChangeNotifierProvider(create: (context) => ChatController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorTheme.brown),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
