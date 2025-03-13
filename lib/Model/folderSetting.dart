// To parse this JSON data, do
//
//     final folderSetting = folderSettingFromJson(jsonString);

import 'dart:convert';

FolderSetting folderSettingFromJson(String str) => FolderSetting.fromJson(json.decode(str));

String folderSettingToJson(FolderSetting data) => json.encode(data.toJson());

class FolderSetting {
  FolderSetting({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  Data? data;

  factory FolderSetting.fromJson(Map<String, dynamic> json) => FolderSetting(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.userid,
    this.folderName,
    this.isPublic,
    this.formdata,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? userid;
  String? folderName;
  bool? isPublic;
  List<dynamic>? formdata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userid: json["userid"],
    folderName: json["folder_name"],
    isPublic: json["isPublic"],
    formdata: json["formdata"] == null ? [] : List<dynamic>.from(json["formdata"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userid": userid,
    "folder_name": folderName,
    "isPublic": isPublic,
    "formdata": formdata == null ? [] : List<dynamic>.from(formdata!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
