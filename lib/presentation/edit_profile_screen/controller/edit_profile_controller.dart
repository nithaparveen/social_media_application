import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/repository/api/edit_profile_screen/model/edit_profile_model.dart';
import 'package:socialmedia/repository/api/edit_profile_screen/service/edit_profile_service.dart';

import '../../../core/utils/app_utils.dart';

class EditProfileController extends ChangeNotifier {
  bool isLoading = false;
  EditProfileModel editProfileModel = EditProfileModel();

   update(String name, String dob, String phone_number, String location, BuildContext context) async {
    var data = {
      "name": "$name",
      "dob": "$dob",
      "phone_number": "$phone_number",
      "location": "$location",
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
      }notifyListeners();
    });
  }
}
