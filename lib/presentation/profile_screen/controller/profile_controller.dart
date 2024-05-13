import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/api/profile_screen/model/profile_model.dart';
import 'package:socialmedia/repository/api/profile_screen/service/profile_service.dart';

class ProfileController extends ChangeNotifier{
  ProfileModel profileModel = ProfileModel();
  bool isLoading = false;

  fetchData (context){
    isLoading = true;
    notifyListeners();
    log("ProfileController -> fetchData()");
    ProfileService.fetchData().then((value) {
      if(value["status"]==1){
        profileModel = ProfileModel.fromJson(value);
        isLoading = false;
      }else{
        AppUtils.oneTimeSnackBar("error", context: context);
      }
      notifyListeners();
    });
  }
}