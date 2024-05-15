// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
  int? status;
  Data? data;

  EditProfileModel({
    this.status,
    this.data,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  String? name;
  DateTime? dob;
  String? phoneNumber;
  String? location;

  Data({
    this.name,
    this.dob,
    this.phoneNumber,
    this.location,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    phoneNumber: json["phone_number"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "phone_number": phoneNumber,
    "location": location,
  };
}
