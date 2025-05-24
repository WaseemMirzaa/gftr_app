// To parse this JSON data, do
//
//     final signUp = signUpFromJson(jsonString);

import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
  SignUp(
      {this.status,
      this.code,
      this.message,
      this.data,
      this.page,
      this.fcmToken});

  bool? status;
  int? code;
  String? message;
  Data? data;
  String? page;
  String? fcmToken;

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
      status: json["status"],
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      page: json["page"],
      fcmToken: json["fcmToken"] ?? "null");

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data?.toJson(),
        "page": page,
        "fcmToken": fcmToken ?? "null"
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
