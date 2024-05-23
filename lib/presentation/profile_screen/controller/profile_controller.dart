import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/api/profile_screen/model/following_model.dart';
import 'package:socialmedia/repository/api/profile_screen/model/post_list_model.dart';
import 'package:socialmedia/repository/api/profile_screen/model/profile_model.dart';
import 'package:socialmedia/repository/api/profile_screen/service/profile_service.dart';

import '../../../repository/api/profile_screen/model/followers_model.dart';

class ProfileController extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  PostListModel postListModel = PostListModel();
  FollowingModel followingModel = FollowingModel();
  FollowersModel followersModel = FollowersModel();
  bool isLoading = false;
  bool isPostLoading = false;
  bool isLoadingFollowing = false;
  bool isLoadingFollower = false;

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
        AppUtils.oneTimeSnackBar("error", context: context, bgColor: Colors.red);
      }
      notifyListeners();
    });
    ProfileService.fetchPost().then((resData) {
      if (resData["status"] == 1) {
        postListModel = PostListModel.fromJson(resData);
        isPostLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Failed", context: context, bgColor: Colors.red);
      }
      notifyListeners();
    });
  }

  Future<void> postDeleted(postId, context) async {
    log("ProfileController -> postDeleted()");

    ProfileService.deletePost(postId).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar("Post Deleted Successfully", context: context);
        // Refresh data after deletion
      } else {
        AppUtils.oneTimeSnackBar(value["message"], context: context, bgColor: Colors.redAccent);
      }
      notifyListeners();
    });
  }

  fetchFollowing(context) async {
    isLoadingFollowing = true;
    notifyListeners();
    log("ProfileController -> fetchFollowing()");
    ProfileService.fetchFollowing().then((value) {
      if (value["status"] == 1) {
        followingModel = FollowingModel.fromJson(value);
        isLoadingFollowing = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data", context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }

  fetchFollower(context) async {
    isLoadingFollower= true;
    notifyListeners();
    log("ProfileController -> fetchFollower()");
    ProfileService.fetchFollower().then((value) {
      if (value["status"] == 1) {
        followersModel = FollowersModel.fromJson(value);
        isLoadingFollower = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data", context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }
}
