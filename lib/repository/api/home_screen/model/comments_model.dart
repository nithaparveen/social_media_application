// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) => CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  int? status;
  List<Datum>? data;

  CommentsModel({
    this.status,
    this.data,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
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
  User? user;
  String? content;
  DateTime? createdAt;
  bool? deletable;

  Datum({
    this.id,
    this.user,
    this.content,
    this.createdAt,
    this.deletable,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    content: json["content"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    deletable: json["deletable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "content": content,
    "created_at": createdAt?.toIso8601String(),
    "deletable": deletable,
  };
}

class User {
  int? userId;
  String? userName;
  String? profileImage;

  User({
    this.userId,
    this.userName,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    userName: json["user_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "profile_image": profileImage,
  };
}
