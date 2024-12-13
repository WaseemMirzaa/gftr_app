// To parse this JSON data, do
//
//     final upadateInvite = upadateInviteFromJson(jsonString);

import 'dart:convert';

UpadateInvite upadateInviteFromJson(String str) => UpadateInvite.fromJson(json.decode(str));

String upadateInviteToJson(UpadateInvite data) => json.encode(data.toJson());

class UpadateInvite {
  UpadateInvite({
    this.status,
    this.code,
    this.message,
  });

  bool? status;
  int? code;
  String? message;

  factory UpadateInvite.fromJson(Map<String, dynamic> json) => UpadateInvite(
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
