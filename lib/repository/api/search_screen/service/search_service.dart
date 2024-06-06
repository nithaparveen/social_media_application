import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class SearchService {
  static Future<dynamic> fetchSearchData(username) async {
    log("SearchService -> fetchSearchData()");
    try {
      var decodedData = await ApiHelper.getDataWOStatus(
        endPoint: "searchview/?username=$username",
        header: ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
