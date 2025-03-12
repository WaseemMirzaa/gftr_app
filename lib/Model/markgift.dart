// To parse this JSON data, do
//
//     final markGift = markGiftFromJson(jsonString);

import 'dart:convert';

MarkGift markGiftFromJson(String str) => MarkGift.fromJson(json.decode(str));

String markGiftToJson(MarkGift data) => json.encode(data.toJson());

class MarkGift {
  MarkGift({
    this.status,
    this.code,
    this.message,
  });

  bool? status;
  int? code;
  String? message;

  factory MarkGift.fromJson(Map<String, dynamic> json) => MarkGift(
    status: json["status"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
  };
}
