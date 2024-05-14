import 'dart:developer';

import 'package:socialmedia/core/utils/app_utils.dart';

import '../../../helper/api_helper.dart';

class PostService {
  static Future<dynamic> createPost(Map<String, dynamic> data) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint: "create-post/",
          body: data,
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
