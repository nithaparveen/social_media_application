import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/utils/app_utils.dart';
import '../../../repository/api/search_screen/model/search_model.dart';
import '../../../repository/api/search_screen/service/search_service.dart';

class SearchScreenController extends ChangeNotifier {
  SearchModel? searchModel;
  bool showData = false;

  fetchData(username, context) async {
    log("SearchController -> fetchData()");
    SearchService.fetchSearchData(username).then((value) {
      if (value["status"] == 1) {
        searchModel = SearchModel.fromJson(value);
        showData = true;
      } else {
        AppUtils.oneTimeSnackBar("error",
            context: context, bgColor: Colors.red);
      }
      notifyListeners();
    });
  }
}
