// To parse this JSON data, do
//
//     final getGifting = getGiftingFromJson(jsonString);

import 'dart:convert';

GetGifting getGiftingFromJson(String str) => GetGifting.fromJson(json.decode(str));

String getGiftingToJson(GetGifting data) => json.encode(data.toJson());

class GetGifting {
  bool? status;
  int? code;
  String? message;
  Data? data;

  GetGifting({
     this.status,
     this.code,
     this.message,
     this.data,
  });

  factory GetGifting.fromJson(Map<String, dynamic> json) => GetGifting(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
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
  String city;
  String country;
  bool isPrivate;
  String state;
  String street;
  String unit;
  String zipcode;

  Data({
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
    required this.city,
    required this.country,
    required this.isPrivate,
    required this.state,
    required this.street,
    required this.unit,
    required this.zipcode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    password: json["password"] ?? '',
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
    city: json["city"],
    country: json["country"],
    isPrivate: json["isPrivate"],
    state: json["state"],
    street: json["street"],
    unit: json["unit"],
    zipcode: json["zipcode"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password": password ??'',
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
    "city": city,
    "country": country,
    "isPrivate": isPrivate,
    "state": state,
    "street": street,
    "unit": unit,
    "zipcode": zipcode,
  };
}
