import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../app_config/app_config.dart';

class ApiHelper {
  //for get
  static getData({
    required String endPoint,
    Map<String, String>? header,
  }) async {
    log("ApiHelper>getData");
    final url = Uri.parse(AppConfig.baseurl + endPoint);
    try {
      var response = await http.get(url);
      log("Api Called => status code=${response.statusCode}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        log("$decodedData");
        return decodedData;
      } else {
        log("Else Condition >> Api failed");
      }
    } catch (e) {
      log("$e");
    }
  }


  //for post
  static postData({
    required String endPoint,
     Map <String , String>? header,
    required Map <String , dynamic> body,
  }) async {
    log("input $body");
    final url = Uri.parse(AppConfig.baseurl+endPoint);
    try{
      var response = await http.post(url,body: body,headers: header);
      log("Api PostMethod Called -> statusCode = ${response.statusCode}");
      if(response.statusCode == 200 || response.statusCode == 201){
        var data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      }else{
        log("Api Failed");
        var data =response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      }
    }catch(e){
      log("$e");
    }
  }

  static Map<String, String> getApiHeader({String? access, String? dbName}) {
    if (access != null) {
      return {
        'Content-Type': 'application/json',
        'Authorization': 'Token $access'
      };
    } else if (dbName != null) {
      return {
        'Content-Type': 'application/json',
        'dbName': dbName
      };
    } else {
      return {
        'Content-Type': 'application/json',
      };
    }
  }
}