import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/core/utils/app_utils.dart';
import 'package:socialmedia/repository/api/message_screen/model/messeage_senders_model.dart';
import 'package:socialmedia/repository/api/message_screen/service/message_screen_service.dart';

class MessageScreenController extends ChangeNotifier {
  bool isLoading = false;
  MessageSendersModel messageSendersModel = MessageSendersModel();

  fetchMessage(context) {
    isLoading = true;
    notifyListeners();
    log("MessageScreenController -> fetchMessage()");
    MessageScreenService.fetchMessage().then((onValue) {
      if (onValue["status"] == 1) {
        messageSendersModel = MessageSendersModel.fromJson(onValue);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("cant Fetch data", context: context);
      }
      notifyListeners();
    });
  }
}
