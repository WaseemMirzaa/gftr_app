// To parse this JSON data, do
//
//     final deleteFrd = deleteFrdFromJson(jsonString);

import 'dart:convert';

DeleteFrd deleteFrdFromJson(String str) => DeleteFrd.fromJson(json.decode(str));

String deleteFrdToJson(DeleteFrd data) => json.encode(data.toJson());

class DeleteFrd {
  bool status;
  int code;
  String message;
  Data data;

  DeleteFrd({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory DeleteFrd.fromJson(Map<String, dynamic> json) => DeleteFrd(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}