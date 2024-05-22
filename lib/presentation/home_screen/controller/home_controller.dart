import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/api/home_screen/model/comments_model.dart';
import 'package:socialmedia/repository/api/home_screen/model/home_model.dart';
import 'package:socialmedia/repository/api/home_screen/service/home_service.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingComments = true;
  HomeModel homeModel = HomeModel();
  CommentsModel commentsModel = CommentsModel();

  fetchData(BuildContext context) {
    isLoading = true;
    notifyListeners();
    log("HomeController=>started");
    HomeService.fetchFeed().then((resData) {
      if (resData["status"] == 1) {
        homeModel = HomeModel.fromJson(resData);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Failed to Fetch Data", context: context, bgColor: Colors.red);
      }
      notifyListeners();
    });
  }

  Future<dynamic> fetchComments(context, postId) async {
    isLoadingComments = true;
    notifyListeners();
    log("HomeController -> fetchComments()");
    HomeService.fetchComments(postId).then((value) {
      if (value["status"] == 1) {
        commentsModel = CommentsModel.fromJson(value);
        isLoadingComments = false;
      } else {
        AppUtils.oneTimeSnackBar("unable to fetch comments", context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }

  likeTapped(id, context) {
    var body = {"post": "$id"};
    log("HomeController -> likeTapped");
    HomeService.likedItem(body).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"], context: context, bgColor: Colors.redAccent);
      }
    });
  }

  postComment(postId, content, context) {
    log("HomeController -> postComments()");
    var body = {"post": "$postId", "content": "$content"};
    HomeService.postComment(body).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: ColorTheme.red, textStyle: TextStyle(color: ColorTheme.white));
      }
      notifyListeners();
    });
  }
}
