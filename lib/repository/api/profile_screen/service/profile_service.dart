import 'dart:developer';

import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/helper/api_helper.dart';

class ProfileService {
  static Future<dynamic> fetchData() async {
    log("ProfileService -> fetchData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "user-profile/",
        header: ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchPost() async {
    try {
      var decodedData = await ApiHelper.getData(
          endPoint: "list_posts_of_authenticatedUser/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> deletePost(post_id) async {
    try {
      var decodedData = await ApiHelper.delete(
          endPoint: "post-delete/$post_id/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("Error in ProfileService -> postDelete: $e");
    }
  }

  static Future<dynamic> fetchFollowing() async {
    try {
      var decodedData = await ApiHelper.getData(
          endPoint: "followingslist/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchFollower() async {
    try {
      var decodedData = await ApiHelper.getData(
          endPoint: "followerslist/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
