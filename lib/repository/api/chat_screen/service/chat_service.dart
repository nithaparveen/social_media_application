import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class ChatService {
  static Future<dynamic> fetchChat(id) async {
    try {
      var decodedData = await ApiHelper.getDataWOStatus(
          endPoint: "listmessages/$id/",
          header: ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> sendMessage(data, id) async {
    try {
      var decodedData = await ApiHelper.postMessage(
          endPoint: "messages/$id/",
          body: data,
          header: ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
