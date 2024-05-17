// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    int? status;
    List<Datum>? data;

    HomeModel({
        this.status,
        this.data,
    });

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? postId;
    Author? author;
    String? caption;
    String? location;
    DateTime? createdAt;
    String? image;
    int? likeCount;
    bool? isLiked;
    int? commentsCount;

    Datum({
        this.postId,
        this.author,
        this.caption,
        this.location,
        this.createdAt,
        this.image,
        this.likeCount,
        this.isLiked,
        this.commentsCount,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        postId: json["post_id"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        caption: json["caption"],
        location: json["location"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        image: json["image"],
        likeCount: json["like_count"],
        isLiked: json["is_liked"],
        commentsCount: json["comments_count"],
    );

    Map<String, dynamic> toJson() => {
        "post_id": postId,
        "author": author?.toJson(),
        "caption": caption,
        "location": location,
        "created_at": createdAt?.toIso8601String(),
        "image": image,
        "like_count": likeCount,
        "is_liked": isLiked,
        "comments_count": commentsCount,
    };
}

class Author {
    int? authorId;
    String? authorName;
    String? profileImage;

    Author({
        this.authorId,
        this.authorName,
        this.profileImage,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        authorId: json["author_id"],
        authorName: json["author_name"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "author_id": authorId,
        "author_name": authorName,
        "profile_image": profileImage,
    };
}
