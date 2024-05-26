import 'dart:developer';

import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/helper/api_helper.dart';

class EditProfileService {
  static Future<dynamic> update(Map<String, dynamic> data) async {
    log("EditProfileService -> update() ");
    try {
      var decodedData = await ApiHelper.patchData(
          endPoint: "updatebio/",
          body: data,
          header:
              apiHeader(access: await AppUtils.getAccessKey()));
    return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Map<String, String> apiHeader({String? access, String? dbName}) {
    if (access != null) {
      return {'Accept': '*/*', 'Authorization': 'Bearer $access'};
    } else if (dbName != null) {
      return {'Content-Type': 'application/json', 'dbName': dbName};
    } else {
      return {
        'Content-Type': 'application/json',
      };
    }
  }

}
