import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/repository/api/chat_screen/service/chat_service.dart';

import '../../../core/utils/app_utils.dart';
import '../../../repository/api/chat_screen/model/message_model.dart';
import '../../../repository/api/message_screen/service/message_screen_service.dart';

class ChatController extends ChangeNotifier{
  bool isLoading = false;
  ChatModel chatModel = ChatModel();
  fetchChat(context,id){
    isLoading = true;
    notifyListeners();
    log("MessageScreenController -> fetchChat()");
    ChatService.fetchChat(id).then((onValue){
      if(onValue["status"]==1){
        chatModel = ChatModel.fromJson(onValue);
        isLoading=false;
      }else{
        AppUtils.oneTimeSnackBar("cant Fetch data", context: context);
      }
      notifyListeners();
    });
  }
}