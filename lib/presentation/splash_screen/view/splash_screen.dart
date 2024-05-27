import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:socialmedia/presentation/login_screen/view/login_screen.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _logged;

  checkLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _logged = sharedPreferences.getBool(AppConfig.loggedIn);
  }

  @override
  void initState() {
    checkLoggedIn();
    Timer(Duration(seconds: 3), () {
      if (_logged == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (route) => false);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorTheme.blue,
      body: Center(
        child: Container(
            height:size.height*.4,
            width: size.height*.4,
            child: Image.asset("assets/images/ThingShare logo.png"))
        // Text(
        //   "ThingShare",
        //   style: GLTextStyles.leagueSpartan(
        //       size: 28, weight: FontWeight.w600, color: ColorTheme.brown),
        // ),
      ),
    );
  }
}
