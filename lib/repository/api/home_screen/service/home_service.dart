import 'dart:developer';

import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/helper/api_helper.dart';

class HomeService {
  static Future<dynamic> fetchFeed() async {
    try {
      var decodedData = ApiHelper.getData(
          endPoint: "feed/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> likedItem(Map<String, dynamic> body) async {
    try {
      log("HomeService -> likedItem");
      var decodedData = ApiHelper.postLike(
          endPoint: "like-unlike-post/",
          body: body,
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> onUnlike(id) async {
    try {
      var decodedData = ApiHelper.delete(
          endPoint: "like-unlike-post/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchComments(postId) async {
    try {
      var decodedData = ApiHelper.getData(
          endPoint: "list-comments-of-post/$postId/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> postComment(Map<String, String> body) async {
    try {
      var decodedData = ApiHelper.postComment(
          endPoint: "comments-create/",
          body: body,
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> deleteComment(commentId) async {
    try {
      var decodedData = ApiHelper.delete(
          endPoint: "comment-delete/$commentId/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> followTapped(id) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint: "CreateFollower/$id/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> postStory(id) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint: "stories/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchStory(id) async {
    try {
      var decodedData = await ApiHelper.getData(
          endPoint: "stories/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchUserStory(id) async {
    try {
      var decodedData = await ApiHelper.getData(
          endPoint: "userstoryview/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      print(decodedData);
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
