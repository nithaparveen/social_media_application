import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/presentation/login_screen/view/login_screen.dart';

class RegistrationController extends ChangeNotifier {
  Future<void> onRegister(BuildContext context, File? image, String username,
      String email, String password) async {
    try {
      var imageUrl = "${AppConfig.baseurl}register/";
      onUploadImage(imageUrl, image, username, email, password).then((value) {
        log("${value.statusCode}");
        if (value.statusCode == 200 || value.statusCode == 201) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
      String username, String email, String password) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
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
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;

    request.headers.addAll(headers);
    log("request : " + request.toString());
    var res = await request.send();
    return await http.Response.fromStream(res);
  }
}
