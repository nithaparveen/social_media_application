import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class MessageScreenService {
  static Future<dynamic> fetchMessage() async {
    try {
      var decodedData = await ApiHelper.getDataWOStatus(
          endPoint: "message-senders/",
          header: ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }


}
