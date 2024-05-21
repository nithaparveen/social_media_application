import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/repository/api/edit_profile_screen/model/edit_profile_model.dart';
import 'package:socialmedia/repository/api/edit_profile_screen/service/edit_profile_service.dart';

import '../../../core/utils/app_utils.dart';

class EditProfileController extends ChangeNotifier {
  bool isLoading = false;
  EditProfileModel editProfileModel = EditProfileModel();

  update(String name, String dob, String phoneNumber, String location, BuildContext context) async {
    // Format the dob to yyyy-MM-dd
    DateTime parsedDob = DateTime.parse(dob);
    String formattedDob = "${parsedDob.year.toString().padLeft(4, '0')}-${parsedDob.month.toString().padLeft(2, '0')}-${parsedDob.day.toString().padLeft(2, '0')}";

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
}
