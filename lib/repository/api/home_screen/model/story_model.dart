// To parse this JSON data, do
//
//     final storyModel = storyModelFromJson(jsonString);

import 'dart:convert';

StoryModel storyModelFromJson(String str) => StoryModel.fromJson(json.decode(str));

String storyModelToJson(StoryModel data) => json.encode(data.toJson());

class StoryModel {
  int? status;
  List<Story>? stories;

  StoryModel({
    this.status,
    this.stories,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    status: json["status"],
    stories: json["stories"] == null ? [] : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "stories": stories == null ? [] : List<dynamic>.from(stories!.map((x) => x.toJson())),
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
  dynamic image;

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
