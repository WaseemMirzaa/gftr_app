// To parse this JSON data, do
//
//     final viewGiftDelete = viewGiftDeleteFromJson(jsonString);

import 'dart:convert';

ViewGiftDelete viewGiftDeleteFromJson(String str) => ViewGiftDelete.fromJson(json.decode(str));

String viewGiftDeleteToJson(ViewGiftDelete data) => json.encode(data.toJson());

class ViewGiftDelete {
  ViewGiftDelete({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  Data? data;

  factory ViewGiftDelete.fromJson(Map<String, dynamic> json) => ViewGiftDelete(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.folderName,
    this.isPublic,
    this.formdata,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? folderName;
  bool? isPublic;
  List<dynamic>? formdata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"] == null ? null : json["_id"],
    folderName: json["folder_name"] == null ? null : json["folder_name"],
    isPublic: json["isPublic"] == null ? null : json["isPublic"],
    formdata: json["formdata"] == null ? null : List<dynamic>.from(json["formdata"].map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "folder_name": folderName == null ? null : folderName,
    "isPublic": isPublic == null ? null : isPublic,
    "formdata": formdata == null ? null : List<dynamic>.from(formdata!.map((x) => x)),
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
