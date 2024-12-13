// To parse this JSON data, do
//
//     final mutulfriendd = mutulfrienddFromJson(jsonString);

import 'dart:convert';

Mutulfriendd mutulfrienddFromJson(String str) => Mutulfriendd.fromJson(json.decode(str));

String mutulfrienddToJson(Mutulfriendd data) => json.encode(data.toJson());

class Mutulfriendd {
  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  Mutulfriendd({
     this.status,
     this.code,
     this.message,
     this.data,
  });

  factory Mutulfriendd.fromJson(Map<String, dynamic> json) => Mutulfriendd(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  List<Mutualby> mutualby;
  Frd frd;

  Datum({
    required this.mutualby,
    required this.frd,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    mutualby: List<Mutualby>.from(json["mutualby"].map((x) => Mutualby.fromJson(x))),
    frd: Frd.fromJson(json["frd"]),
  );

  Map<String, dynamic> toJson() => {
    "mutualby": List<dynamic>.from(mutualby.map((x) => x.toJson())),
    "frd": frd.toJson(),
  };
}

class Frd {
  String id;
  String firstname;
  String lastname;
  String email;
  String password;
  String avatar;
  List<dynamic> child;
  String otpCheck;
  int phoneNumber;
  bool isVerified;
  bool status;
  String role;
  int notifychat;
  List<dynamic> remindMe;
  DateTime createdAt;
  DateTime updatedAt;
  bool encEmail;
  DateTime birthday;
  String? address;
  bool? isPrivate;

  Frd({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.avatar,
    required this.child,
    required this.otpCheck,
    required this.phoneNumber,
    required this.isVerified,
    required this.status,
    required this.role,
    required this.notifychat,
    required this.remindMe,
    required this.createdAt,
    required this.updatedAt,
    required this.encEmail,
    required this.birthday,
    this.address,
    this.isPrivate,
  });

  factory Frd.fromJson(Map<String, dynamic> json) => Frd(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    password: json["password"],
    avatar: json["avatar"],
    child: List<dynamic>.from(json["child"].map((x) => x)),
    otpCheck: json["otpCheck"],
    phoneNumber: json["phoneNumber"],
    isVerified: json["isVerified"],
    status: json["status"],
    role: json["role"],
    notifychat: json["notifychat"],
    remindMe: List<dynamic>.from(json["remindMe"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    encEmail: json["__enc_email"],
    birthday: DateTime.parse(json["birthday"]),
    address: json["address"],
    isPrivate: json["isPrivate"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password": password,
    "avatar": avatar,
    "child": List<dynamic>.from(child.map((x) => x)),
    "otpCheck": otpCheck,
    "phoneNumber": phoneNumber,
    "isVerified": isVerified,
    "status": status,
    "role": role,
    "notifychat": notifychat,
    "remindMe": List<dynamic>.from(remindMe.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__enc_email": encEmail,
    "birthday": birthday.toIso8601String(),
    "address": address,
    "isPrivate": isPrivate,
  };
}

class Mutualby {
  String name;
  String avatar;

  Mutualby({
    required this.name,
    required this.avatar,
  });

  factory Mutualby.fromJson(Map<String, dynamic> json) => Mutualby(
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "avatar": avatar,
  };
}