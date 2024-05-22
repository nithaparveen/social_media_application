import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/api/profile_screen/model/post_list_model.dart';
import 'package:socialmedia/repository/api/profile_screen/model/profile_model.dart';
import 'package:socialmedia/repository/api/profile_screen/service/profile_service.dart';

class ProfileController extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  PostListModel postListModel = PostListModel();
  bool isLoading = false;
  bool isPostLoading = false;

  Future<void> fetchData(BuildContext context) async {
    isLoading = true;
    isPostLoading = true;
    notifyListeners();
    log("ProfileController -> fetchData()");
    ProfileService.fetchData().then((value) {
      if (value["status"] == 1) {
        profileModel = ProfileModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("error",
            context: context, bgColor: Colors.red);
      }
      notifyListeners();
    });
    ProfileService.fetchPost().then((resData) {
      if (resData["status"] == 1) {
        postListModel = PostListModel.fromJson(resData);
        isPostLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Failed",
            context: context, bgColor: Colors.red);
      }
      notifyListeners();
    });
  }

  Future<void> postDeleted(postId, context) async {
    log("ProfileController -> postDeleted");

    ProfileService.deletePost(postId).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar("Post Deleted Successfully", context: context);
        // Refresh data after deletion
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
      notifyListeners();
    });
  }
}
