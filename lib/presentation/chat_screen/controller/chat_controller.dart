import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/repository/api/chat_screen/service/chat_service.dart';

import '../../../core/utils/app_utils.dart';
import '../../../repository/api/chat_screen/model/message_model.dart';

class ChatController extends ChangeNotifier {
  bool isLoading = false;
  ChatModel chatModel = ChatModel();

  fetchChat(context, id) {
    isLoading = true;
    notifyListeners();
    log("MessageScreenController -> fetchChat()");
    ChatService.fetchChat(id).then((onValue) {
      if (onValue["status"] == 1) {
        chatModel = ChatModel.fromJson(onValue);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("cant Fetch data", context: context);
      }
      notifyListeners();
    });
  }

  sendMessage(context, message, id) {
    log("ChatController -> sendMessage()");
    var data = {"message": "$message", "image": null};
    ChatService.sendMessage(data, id);
  }

  Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? tokenJsonString = sharedPreferences.getString(AppConfig.loginData);
    if (tokenJsonString != null) {
      Map<String, dynamic> tokenData = jsonDecode(tokenJsonString);
      String? accessToken = tokenData['data']['access'];
      return accessToken;
    }
    return null;
  }

  Future<void> onSendMessage(BuildContext context, File? image, String? message, int id) async {
    try {
      String? accessToken = await getAccessToken();
      var url = "${AppConfig.baseurl}messages/$id/";
      onUploadImage(
        url,
        image,
        message,
        accessToken
      ).then((value) {
        log("onSendMessage() -> status code -> ${value.statusCode}");
        if (value.statusCode == 200) {
          AppUtils.oneTimeSnackBar("Message Sent", context: context, bgColor: Colors.green, time: 2);
        } else {
          AppUtils.oneTimeSnackBar("error", context: context);
        }
      });
    } catch (e) {
      log("$e");
    }
  }

  Future<http.Response> onUploadImage(
    String url,
    File? selectedImage,
    String? message,
      String? accessToken
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> headers = {"Content-type": "multipart/form-data","Authorization": "Bearer $accessToken"};
    if (selectedImage != null) {
      log("image size -> ${selectedImage.lengthSync()} B");
      request.files.add(await http.MultipartFile.fromPath('image', selectedImage.path));
    }
    if (message != null) {
      request.fields["message"] = message;
    }

    request.headers.addAll(headers);
    log("request: $request");
    var res = await request.send();
    return await http.Response.fromStream(res);
  }
}
