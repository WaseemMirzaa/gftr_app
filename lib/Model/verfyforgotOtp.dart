import 'dart:convert';

VerifyForgotOtp verifyForgotOtpFromJson(String str) => VerifyForgotOtp.fromJson(json.decode(str));

String verifyForgotOtpToJson(VerifyForgotOtp data) => json.encode(data.toJson());

class VerifyForgotOtp {
  VerifyForgotOtp({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  OtpData? data;

  factory VerifyForgotOtp.fromJson(Map<String, dynamic> json) => VerifyForgotOtp(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : OtpData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class OtpData {
  OtpData({
    this.userData,
  });

  UserData? userData;

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
    userData: json["userData"] == null ? null : UserData.fromJson(json["userData"]),
  );

  Map<String, dynamic> toJson() => {
    "userData": userData == null ? null : userData!.toJson(),
  };
}

class UserData {
  UserData({
    this.id,
    this.username,
    this.email,
    this.token,
  });

  String? id;
  String? username;
  String? email;
  String? token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "token": token == null ? null : token,
  };
}
