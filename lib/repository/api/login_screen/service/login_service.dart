import 'dart:developer';

import 'package:socialmedia/repository/helper/api_helper.dart';

class LoginService {
  static Future<dynamic> postLoginData(Map<String, dynamic> data) async {
    try {
      var decodedData =
          await ApiHelper.postData(endPoint: "login/", body: data);
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
