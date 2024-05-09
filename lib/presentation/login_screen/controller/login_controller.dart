import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:socialmedia/repository/api/login_screen/service/login_service.dart';

class loginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;

  Future onLogin(String email, String password, BuildContext context) async {
    log("loginController -> onLogin() started");
    var data = {"email": email, "password": password};
    LoginService.postLoginData(data).then((value) {
      log("postLoginData() -> ${value["status"]}");
      if (value["status"] == 1) {
        log("token -> ${value["data"]["access"]}");
        storeLoginData(value);
        storeUserToken(value["data"]["access"]);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (route) => false);
      } else {
        var message = value["errors"].toString();
        AppUtils.oneTimeSnackBar(message, context: context,bgColor: Colors.red);
      }
    });
  }

  void onPressed() {
    visibility = !visibility;
    notifyListeners();
  }

  void storeLoginData(loginReceivedData) async {
    log("storeLoginData()");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    sharedPreferences.setString(AppConfig.loginData, storeData);
    sharedPreferences.setBool(AppConfig.loggedIn, true);
  }

  void storeUserToken(resData) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    String dataUser = json.encode(resData);
    sharedPreferences.setString(AppConfig.token, dataUser);
  }
}
