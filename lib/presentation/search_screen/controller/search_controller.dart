import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/search_screen/model/search_model.dart';
import '../../../repository/api/search_screen/service/search_service.dart';

class SearchController extends ChangeNotifier {
  SearchModel searchModel = SearchModel();
  bool isLoading = false;

  Future<void> fetchData(username, context) async {
    isLoading = true;
    isLoading = true;
    notifyListeners();
    log("SearchController -> fetchData()");
    SearchService.fetchSearchData(username).then((value) {
      if (value["status"] == 1) {
        searchModel = SearchModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("error",
            context: context, bgColor: Colors.red);
      }
      notifyListeners();
    });
  }
}
