// To parse this JSON data, do
//
//     final messageSendersModel = messageSendersModelFromJson(jsonString);

import 'dart:convert';

MessageSendersModel messageSendersModelFromJson(String str) => MessageSendersModel.fromJson(json.decode(str));

String messageSendersModelToJson(MessageSendersModel data) => json.encode(data.toJson());

class MessageSendersModel {
  int? status;
  List<Datum>? data;

  MessageSendersModel({
    this.status,
    this.data,
  });

  factory MessageSendersModel.fromJson(Map<String, dynamic> json) => MessageSendersModel(
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

  Datum({
    this.id,
    this.username,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
  };
}
