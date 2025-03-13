import 'dart:convert';

NewPassword newPasswordFromJson(String str) =>
    NewPassword.fromJson(json.decode(str));

String newPasswordToJson(NewPassword data) => json.encode(data.toJson());

class NewPassword {
  NewPassword({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  NewPassData? data;

  factory NewPassword.fromJson(Map<String, dynamic> json) => NewPassword(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : NewPassData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class NewPassData {
  NewPassData();

  factory NewPassData.fromJson(Map<String, dynamic> json) => NewPassData();

  Map<String, dynamic> toJson() => {};
}
