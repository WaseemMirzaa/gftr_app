import 'dart:convert';

SignIn signInFromJson(String str) => SignIn.fromJson(json.decode(str));

String signInToJson(SignIn data) => json.encode(data.toJson());

class SignIn {
  SignIn({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  SignInData? data;

  factory SignIn.fromJson(Map<String, dynamic> json) => SignIn(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : SignInData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class SignInData {
  SignInData({
    this.userData,
    this.token,
  });

  UserData? userData;
  String? token;

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
    userData: json["userData"] == null ? null : UserData.fromJson(json["userData"]),
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "userData": userData == null ? null : userData!.toJson(),
    "token": token == null ? null : token,
  };
}

class UserData {
  UserData({
    this.id,
    this.username,
    this.email,
  });

  String? id;
  String? username;
  String? email;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
  };
}
