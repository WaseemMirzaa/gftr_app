// To parse this JSON data, do
//
//     final inviteEmail = inviteEmailFromJson(jsonString);

import 'dart:convert';

InviteEmail inviteEmailFromJson(String str) => InviteEmail.fromJson(json.decode(str));

String inviteEmailToJson(InviteEmail data) => json.encode(data.toJson());

class InviteEmail {
  InviteEmail({
    this.status,
    this.code,
    this.message,
  });

  bool? status;
  int? code;
  String? message;

  factory InviteEmail.fromJson(Map<String, dynamic> json) => InviteEmail(
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
