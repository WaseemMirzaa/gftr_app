// To parse this JSON data, do
//
//     final removeEvent = removeEventFromJson(jsonString);

import 'dart:convert';

RemoveEvent removeEventFromJson(String str) => RemoveEvent.fromJson(json.decode(str));

String removeEventToJson(RemoveEvent data) => json.encode(data.toJson());

class RemoveEvent {
  bool? status;
  int? code;
  String? message;
  Data? data;

  RemoveEvent({
     this.status,
     this.code,
     this.message,
     this.data,
  });

  factory RemoveEvent.fromJson(Map<String, dynamic> json) => RemoveEvent(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
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
