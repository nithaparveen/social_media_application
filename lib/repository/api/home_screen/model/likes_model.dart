// To parse this JSON data, do
//
//     final likesModel = likesModelFromJson(jsonString);

import 'dart:convert';

LikesModel likesModelFromJson(String str) => LikesModel.fromJson(json.decode(str));

String likesModelToJson(LikesModel data) => json.encode(data.toJson());

class LikesModel {
  int? status;
  List<Datum>? data;

  LikesModel({
    this.status,
    this.data,
  });

  factory LikesModel.fromJson(Map<String, dynamic> json) => LikesModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? username;
  String? image;

  Datum({
    this.id,
    this.username,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    username: json["username"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "image": image,
  };
}
