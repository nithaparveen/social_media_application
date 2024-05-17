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
  static Future<dynamic> likedItem(id) async {
    try {
      var decodedData = ApiHelper.postLike(
          endPoint: "like-unlike-post/",
          header: ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> onUnlike(id) async {
    try {
      var decodedData = ApiHelper.delete(
          endPoint: "like-unlike-post/",
          header: ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
