import 'dart:convert';

ForgotPassword forgotPasswordFromJson(String str) => ForgotPassword.fromJson(json.decode(str));

String forgotPasswordToJson(ForgotPassword data) => json.encode(data.toJson());

class ForgotPassword {
  ForgotPassword({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  ForgotPassData? data;

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : ForgotPassData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class ForgotPassData {
  ForgotPassData({
    this.id,
    this.username,
    this.email,
    this.password,
    this.child,
    this.otpCheck,
    this.isVerified,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.encUsername,
    this.encEmail,
  });

  String? id;
  String? username;
  String? email;
  String? password;
  List<dynamic>? child;
  int? otpCheck;
  bool? isVerified;
  String? status;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? encUsername;
  bool? encEmail;

  factory ForgotPassData.fromJson(Map<String, dynamic> json) => ForgotPassData(
    id: json["_id"] == null ? null : json["_id"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    child: json["child"] == null ? null : List<dynamic>.from(json["child"].map((x) => x)),
    otpCheck: json["otpCheck"] == null ? null : json["otpCheck"],
    isVerified: json["isVerified"] == null ? null : json["isVerified"],
    status: json["status"] == null ? null : json["status"],
    role: json["role"] == null ? null : json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    encUsername: json["__enc_username"] == null ? null : json["__enc_username"],
    encEmail: json["__enc_email"] == null ? null : json["__enc_email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "child": child == null ? null : List<dynamic>.from(child!.map((x) => x)),
    "otpCheck": otpCheck == null ? null : otpCheck,
    "isVerified": isVerified == null ? null : isVerified,
    "status": status == null ? null : status,
    "role": role == null ? null : role,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "__enc_username": encUsername == null ? null : encUsername,
    "__enc_email": encEmail == null ? null : encEmail,
  };
}
