import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/api/home_screen/model/home_model.dart';
import 'package:socialmedia/repository/api/home_screen/service/home_service.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;
  HomeModel homeModel = HomeModel();
  fetchData(BuildContext context) {
    isLoading = true;
    notifyListeners();
    log("HomeController=>started");
    HomeService.fetchFeed().then((resData) {
      if (resData["status"] == 1) {
        homeModel = HomeModel.fromJson(resData);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Failed to Fetch Data",
            context: context, bgColor: Colors.red);
      }

      notifyListeners();
    });

  }
}
void likeTapped(id, context) {
    HomeService.likedItem(id).then((value) {
      log("================$value");
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"], context: context, bgColor: Colors.redAccent);
      }
    });
  }

  void onUnlike(id, context) {
    HomeService.onUnlike(id).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"], context: context, bgColor: Colors.redAccent);
      }
    });
  }
