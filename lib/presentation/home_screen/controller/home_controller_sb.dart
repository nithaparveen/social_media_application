import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/home_screen/model/comments_model.dart';
import '../../../repository/api/home_screen/model/home_model.dart';
import '../../../repository/api/home_screen/service/home_service.dart';

class HomeControllerSB extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingComments = true;
  HomeModel homeModel = HomeModel();
  CommentsModel commentsModel = CommentsModel();

  // Create a StreamController for comments
  final _commentsController = StreamController<CommentsModel>.broadcast();

  // Expose the stream to the UI
  Stream<CommentsModel> get commentsStream => _commentsController.stream;


  // Modify fetchComments to use the stream controller
  Future<void> fetchComments(context, postId) async{
    isLoadingComments = true;
    notifyListeners();
    log("HomeController -> fetchComments()");
    HomeService.fetchComments(postId).then((value) {
      if (value["status"] == 1) {
        commentsModel = CommentsModel.fromJson(value);
        isLoadingComments = false;
        // Add commentsModel to the stream
        _commentsController.sink.add(commentsModel);
      } else {
        AppUtils.oneTimeSnackBar("unable to fetch comments", context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }

  likeTapped(id, context) {
    var body = {"post": "$id"};
    log("HomeController -> likeTapped");
    HomeService.likedItem(body).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"], context: context, bgColor: Colors.redAccent);
      }
    });
  }

  postComment(postId, content, context) {
    log("HomeController -> postComments()");
    var body = {"post": "$postId", "content": "$content"};
    HomeService.postComment(body).then((value) {
      if (value["status"] == 1) {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: ColorTheme.red, textStyle: TextStyle(color: ColorTheme.white));
      }
      notifyListeners();
    });
  }

  // Dispose the stream controller when no longer needed
  void dispose() {
    _commentsController.close();
    super.dispose();
  }
}
