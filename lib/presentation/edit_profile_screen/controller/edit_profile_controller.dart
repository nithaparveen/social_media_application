import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/repository/api/edit_profile_screen/model/edit_profile_model.dart';
import 'package:socialmedia/repository/api/edit_profile_screen/service/edit_profile_service.dart';

import '../../../app_config/app_config.dart';
import '../../../core/utils/app_utils.dart';

class EditProfileController extends ChangeNotifier {
  bool isLoading = false;
  EditProfileModel editProfileModel = EditProfileModel();
  late SharedPreferences sharedPreferences;

  update(String name, String dob, String phoneNumber, String location, BuildContext context) async {
    // Format the dob to yyyy-MM-dd
    DateTime parsedDob = DateTime.parse(dob);
    String formattedDob =
        "${parsedDob.year.toString().padLeft(4, '0')}-${parsedDob.month.toString().padLeft(2, '0')}-${parsedDob.day.toString().padLeft(2, '0')}";

    // Ensure phone number is formatted correctly
    String formattedPhoneNumber = phoneNumber.startsWith("+91") ? phoneNumber : "+91$phoneNumber";

    var data = {
      "name": name,
      "dob": formattedDob,
      "phone_number": formattedPhoneNumber,
      "location": location,
    };
    isLoading = true;
    notifyListeners();
    log("EditProfileController -> update() ");
    EditProfileService.update(data).then((value) {
      log("EditProfileController -> status -> ${value["status"]}");
      if (value["status"] == 1) {
        editProfileModel = EditProfileModel.fromJson(value);
        Navigator.pop(context);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("error", context: context);
      }
      notifyListeners();
    });
  }

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

  Future<void> onCreateCustomer(
    BuildContext context,
    File? selectedImage,
    String name,
    String dob,
    String phoneNumber,
    String location,
  ) async {
    try {
      String? accessToken = await getAccessToken();
      var url = "${AppConfig.baseurl}updatebio/";
      enEditProfile(url, selectedImage, name, dob, phoneNumber, location, accessToken!).then((value) {
        log("onCreateCustomer() -> status code -> ${value.statusCode}");
        if (value.statusCode == 200) {
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          AppUtils.oneTimeSnackBar("error", context: context);
        }
        notifyListeners();
      });
    } catch (e) {
      log("$e");
    }
  }

  Future<http.Response> enEditProfile(
    String url,
    File? selectedImage,
    String name,
    String dob,
    String phoneNumber,
    String location,
    String accessToken,
  ) async {
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $accessToken"
    };

    DateTime parsedDob = DateTime.parse(dob);
    String formattedDob =
        "${parsedDob.year.toString().padLeft(4, '0')}-${parsedDob.month.toString().padLeft(2, '0')}-${parsedDob.day.toString().padLeft(2, '0')}";
    String formattedPhoneNumber = phoneNumber.startsWith("+91") ? phoneNumber : "+91$phoneNumber";
    if (selectedImage != null) {
      log("image size -> ${selectedImage.lengthSync()} B");
      request.files.add(await http.MultipartFile.fromPath('image', selectedImage.path));
    }
    request.fields["name"] = name;
    request.fields["dob"] = formattedDob;
    request.fields["phone_number"] = formattedPhoneNumber;
    request.fields["location"] = location;
    request.headers.addAll(headers);
    log("request: $request");
    var res = await request.send();
    return await http.Response.fromStream(res);
  }

  receiveStoredData(url, selectedImage, name, dob, phoneNumber, location) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var storeData = sharedPreferences.getString(AppConfig.token);
    log("stored data ->  $storeData");
    return storeData.toString();
  }
}
