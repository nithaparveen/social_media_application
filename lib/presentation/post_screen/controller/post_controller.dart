import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';

import '../../../core/utils/app_utils.dart';

class PostController extends ChangeNotifier {
  Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? tokenJsonString = sharedPreferences.getString(AppConfig.loginData);
    if (tokenJsonString != null) {
      Map<String, dynamic> tokenData = jsonDecode(tokenJsonString);
      String? accessToken = tokenData['data']['access'];
      return accessToken;
    }
    return null;
  }

  Future<void> onCreatePost(BuildContext context, File? image, String caption,
      String location) async {
    try {
      String? accessToken = await getAccessToken();
      var imageUrl = "${AppConfig.baseurl}create-post/";
      onUploadImage(imageUrl, image, caption, location, accessToken)
          .then((value) {
        log("${value.statusCode}");
        if (value.statusCode == 200 || value.statusCode == 201) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBar(),
              ));
        } else {
          var message = jsonDecode(value.body)["msg"];
          AppUtils.oneTimeSnackBar(message, context: context);
        }
      });
    } catch (e) {
      log("$e");
    }
  }

  Future<http.Response> onUploadImage(String url, File? selectedImage,
      String caption, String location, String? accessToken) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $accessToken"
    };
    if (selectedImage != null) {
      print("Image file size: ${selectedImage.lengthSync()} bytes <<<<<<<<<<<");
      // var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          selectedImage.path,
        ),
      );
    }
    request.fields['caption'] = caption;
    request.fields['location'] = location;

    request.headers.addAll(headers);
    log("request : " + request.toString());
    var res = await request.send();
    return await http.Response.fromStream(res);
  }
}
