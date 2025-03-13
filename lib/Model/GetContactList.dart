// To parse this JSON data, do
//
//     final getContactList = getContactListFromJson(jsonString);

import 'dart:convert';

GetContactList getContactListFromJson(String str) => GetContactList.fromJson(json.decode(str));

String getContactListToJson(GetContactList data) => json.encode(data.toJson());

class GetContactList {
  GetContactList({
    this.status,
    this.code,
    this.message,
    this.registered,
  });

  bool? status;
  int? code;
  String? message;
  List<Registered>? registered;

  factory GetContactList.fromJson(Map<String, dynamic> json) => GetContactList(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    registered: json["registered"] == null ? [] : List<Registered>.from(json["registered"]!.map((x) => Registered.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "registered": registered == null ? [] : List<dynamic>.from(registered!.map((x) => x.toJson())),
  };
}

class Registered {
  Registered({
    this.email,
    this.phoneNumber,
    this.userName,
    this.isVerified,
    this.isGroup,
    this.id,
  });

  String? email;
  String? phoneNumber;
  String? userName;
  bool? isVerified;
  bool? isGroup;
  String? id;

  factory Registered.fromJson(Map<String, dynamic> json) => Registered(
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    userName: json["userName"],
    isVerified: json["isVerified"],
    isGroup: json["isGroup"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phoneNumber": phoneNumber,
    "userName": userName,
    "isVerified": isVerified,
    "isGroup": isGroup,
    "_id": id,
  };
}
