import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../../repository/api/news_screen/model/news_model.dart';

class NewsController with ChangeNotifier {
  List<String> categoryList = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Sports",
    "Technology",
  ];
  String catagory = "business";

  onTap({required int index}) {
    catagory = categoryList[index].toLowerCase();
    fethchData();
    // print("$catagory is selected");
    notifyListeners();
  }

  NewsDataModel newsDataModel = NewsDataModel();

  bool isLoading = false;

  fethchData() async {
    isLoading = true;
    notifyListeners();
    // print("$catagory is selected");
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=$catagory&apiKey=233c06f8ee1b4faf9aba34353b5e73c7");

    final response = await http.get(url);
    print(response.statusCode);
    Map<String, dynamic> decodedData = {};
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
    } else {
      print("api failed");
    }
    newsDataModel = NewsDataModel.fromJson(decodedData);
    isLoading = false;
    notifyListeners();
  }

  // Function to launch a URL
  Future<void> launchURL(String url) async {
    final Uri url1 = Uri.parse(url);
    try {
      if (!await launchUrl(url1, mode: LaunchMode.inAppWebView)) {
        await launchUrl(url1, mode: LaunchMode.inAppWebView);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
    notifyListeners();
  }

  void share({String toShare = ""}) {
    try {
      Share.share(toShare);
    } catch (e) {
      print("Error sharing $e");
    }
  }
}
