// To parse this JSON data, do
//
//     final resendModal = resendModalFromJson(jsonString);

import 'dart:convert';

ResendModal? resendModalFromJson(String str) =>
    ResendModal.fromJson(json.decode(str));

String resendModalToJson(ResendModal? data) => json.encode(data!.toJson());

class ResendModal {
  ResendModal({
    this.status,
    this.code,
    this.message,
  });

  bool? status;
  int? code;
  String? message;

  factory ResendModal.fromJson(Map<String, dynamic> json) => ResendModal(
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
