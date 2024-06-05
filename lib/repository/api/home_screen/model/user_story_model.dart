// To parse this JSON data, do
//
//     final userStoryModel = userStoryModelFromJson(jsonString);

import 'dart:convert';

UserStoryModel userStoryModelFromJson(String str) => UserStoryModel.fromJson(json.decode(str));

String userStoryModelToJson(UserStoryModel data) => json.encode(data.toJson());

class UserStoryModel {
  int? status;
  List<Story>? story;

  UserStoryModel({
    this.status,
    this.story,
  });

  factory UserStoryModel.fromJson(Map<String, dynamic> json) => UserStoryModel(
    status: json["status"],
    story: json["story"] == null ? [] : List<Story>.from(json["story"]!.map((x) => Story.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "story": story == null ? [] : List<dynamic>.from(story!.map((x) => x.toJson())),
  };
}

class Story {
  int? id;
  Author? author;
  dynamic caption;
  dynamic location;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;

  Story({
    this.id,
    this.author,
    this.caption,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    caption: json["caption"],
    location: json["location"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author?.toJson(),
    "caption": caption,
    "location": location,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image": image,
  };
}

class Author {
  String? username;
  String? image;

  Author({
    this.username,
    this.image,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    username: json["username"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "image": image,
  };
}
