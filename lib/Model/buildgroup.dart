// To parse this JSON data, do
//
//     final buildGroup = buildGroupFromJson(jsonString);

import 'dart:convert';

BuildGroup buildGroupFromJson(String str) => BuildGroup.fromJson(json.decode(str));

String buildGroupToJson(BuildGroup data) => json.encode(data.toJson());

class BuildGroup {
  BuildGroup({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  Data? data;

  factory BuildGroup.fromJson(Map<String, dynamic> json) => BuildGroup(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
