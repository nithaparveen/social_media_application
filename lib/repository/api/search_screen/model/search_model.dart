// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  String? username;
  String? name;
  String? image;

  SearchModel({
    this.username,
    this.name,
    this.image,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    username: json["username"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "image": image,
  };
}
