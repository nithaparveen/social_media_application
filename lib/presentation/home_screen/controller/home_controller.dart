import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/api/home_screen/model/comments_model.dart';
import 'package:socialmedia/repository/api/home_screen/model/home_model.dart';
import 'package:socialmedia/repository/api/home_screen/service/home_service.dart';

import '../../../app_config/app_config.dart';
import '../../bottom_navigation_screen/view/bottom_navigation_screen.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingComments = true;
  HomeModel homeModel = HomeModel();
  CommentsModel commentsModel = CommentsModel();

  Future<void> fetchData(BuildContext context) async {
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

  Future<dynamic> fetchComments(context, postId) async {
    isLoadingComments = true;
    notifyListeners();
    log("HomeController -> fetchComments()");
    HomeService.fetchComments(postId).then((value) {
      if (value["status"] == 1) {
        commentsModel = CommentsModel.fromJson(value);
        isLoadingComments = false;
      } else {
        AppUtils.oneTimeSnackBar("unable to fetch comments",
            context: context, bgColor: ColorTheme.red);
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
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }

  followTapped(id, context) {
    log("HomeController -> followTapped");
    HomeService.followTapped(id).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
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
            context: context,
            bgColor: ColorTheme.red,
            textStyle: TextStyle(color: ColorTheme.white));
      }
      notifyListeners();
    });
  }

  deleteComment(context, commentId) {
    log("HomeController -> deleteComment()");
    HomeService.deleteComment(commentId).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
        Navigator.pop(context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      }
      notifyListeners();
    });
  }
  /// story post
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

  Future<void> onCreateStory(
    BuildContext context,
    File? image,
  ) async {
    try {
      String? accessToken = await getAccessToken();
      var imageUrl = "${AppConfig.baseurl}stories/";
      onUploadImage(imageUrl, image, accessToken).then((value) {
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
      String? accessToken) async {
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
    request.headers.addAll(headers);
    log("request : " + request.toString());
    var res = await request.send();
    return await http.Response.fromStream(res);
  }
}
