// To parse this JSON data, do
//
//     final addFolderModal = addFolderModalFromJson(jsonString);

import 'dart:convert';

AddFolderModal addFolderModalFromJson(String str) =>
    AddFolderModal.fromJson(json.decode(str));

String addFolderModalToJson(AddFolderModal data) => json.encode(data.toJson());

class AddFolderModal {
  AddFolderModal({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  Data? data;

  factory AddFolderModal.fromJson(Map<String, dynamic> json) => AddFolderModal(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
