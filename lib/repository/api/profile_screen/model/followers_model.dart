// To parse this JSON data, do
//
//     final followersModel = followersModelFromJson(jsonString);

import 'dart:convert';

FollowersModel followersModelFromJson(String str) => FollowersModel.fromJson(json.decode(str));

String followersModelToJson(FollowersModel data) => json.encode(data.toJson());

class FollowersModel {
  int? status;
  List<Datum>? data;

  FollowersModel({
    this.status,
    this.data,
  });

  factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
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
  String? email;
  String? image;
  int? followerCount;
  int? followingCount;
  String? name;
  DateTime? dob;
  String? location;
  String? phoneNumber;

  Datum({
    this.id,
    this.username,
    this.email,
    this.image,
    this.followerCount,
    this.followingCount,
    this.name,
    this.dob,
    this.location,
    this.phoneNumber,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    image: json["image"],
    followerCount: json["follower_count"],
    followingCount: json["following_count"],
    name: json["name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    location: json["location"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "image": image,
    "follower_count": followerCount,
    "following_count": followingCount,
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "location": location,
    "phone_number": phoneNumber,
  };
}
