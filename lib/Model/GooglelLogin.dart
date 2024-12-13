// To parse this JSON data, do
//
//     final glogin = gloginFromJson(jsonString);

import 'dart:convert';

Glogin gloginFromJson(String str) => Glogin.fromJson(json.decode(str));

String gloginToJson(Glogin data) => json.encode(data.toJson());

class Glogin {
  bool status;  //true
  int? code;      //200
  String? message; ////scee
  Data? data;

  Glogin({
    required this.status,
     this.code,
     this.message,
     this.data ,
  });

  factory Glogin.fromJson(Map<String, dynamic> json) => Glogin(
    status: json["status"],
    code: json["code"] ==  null ? 0 : json["code"],
    message: json["message"] == null ? '' : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
   // data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code == null? 0 : code,
    "message": message == null ? '' : message,
    "data": data == null ? {} : data!.toJson(),
  };
}

class Data {
  UserData? userData;
  String? token;

  Data({
     this.userData,
     this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: UserData.fromJson(json["userData"] == null ?{ }:json["userData"]),
    token: json["token"] == null ? '' : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "userData": userData == null ? {} :userData!.toJson(),
    "token": token == null ? '' : token,
  };
}

class UserData {
  String? id;
  int? phoneNumber;
  String? email;

  UserData({
     this.id,
     this.phoneNumber,
     this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"] == null ? '' :json["id"],
    phoneNumber: json["phoneNumber"] == null ? 0 :json["phoneNumber"],
    email: json["email"] == null ? '' :json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? '' : id,
    "phoneNumber": phoneNumber == null ? 0 : phoneNumber ,
    "email": email == null ? '' : email,
  };
}
