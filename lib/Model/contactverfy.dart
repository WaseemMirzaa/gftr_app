// To parse this JSON data, do
//
//     final contactVerfy = contactVerfyFromJson(jsonString);

import 'dart:convert';

ContactVerfy contactVerfyFromJson(String str) => ContactVerfy.fromJson(json.decode(str));

String contactVerfyToJson(ContactVerfy data) => json.encode(data.toJson());

class ContactVerfy {
  ContactVerfy({
    this.status,
    this.code,
    this.message,
    this.id,
    this.registered,
  });

  bool? status;
  int? code;
  String? message;
  String? id;
  List<Registered>? registered;

  factory ContactVerfy.fromJson(Map<String, dynamic> json) => ContactVerfy(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    id: json["id"],
    registered: json["registered"] == null ? [] : List<Registered>.from(json["registered"]!.map((x) => Registered.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "id": id,
    "registered": registered == null ? [] : List<dynamic>.from(registered!.map((x) => x.toJson())),
  };
}

class Registered {
  Registered({
    this.phoneNumber,
    this.userName,
    this.isVerified,
    this.isGroup,
  });

  String? phoneNumber;
  String? userName;
  bool? isVerified;
  bool? isGroup;

  factory Registered.fromJson(Map<String, dynamic> json) => Registered(
    phoneNumber: json["phoneNumber"],
    userName: json["userName"],
    isVerified: json["isVerified"],
    isGroup: json["isGroup"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "userName": userName,
    "isVerified": isVerified,
    "isGroup": isGroup,
  };
}
