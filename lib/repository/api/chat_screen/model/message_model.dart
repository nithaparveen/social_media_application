// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  int? status;
  List<Datum>? data;

  ChatModel({
    this.status,
    this.data,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? senderUsername;
  String? receiverUsername;
  DateTime? timestamp;
  String? message;
  dynamic image;

  Datum({
    this.senderUsername,
    this.receiverUsername,
    this.timestamp,
    this.message,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    senderUsername: json["sender_username"],
    receiverUsername: json["receiver_username"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    message: json["message"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "sender_username": senderUsername,
    "receiver_username": receiverUsername,
    "timestamp": timestamp?.toIso8601String(),
    "message": message,
    "image": image,
  };
}
