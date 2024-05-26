// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  int? status;
  List<Datum>? data;

  SearchModel({
    this.status,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? username;
  String? name;
  String? image;

  Datum({
    this.username,
    this.name,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
