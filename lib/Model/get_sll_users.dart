

import 'dart:convert';

ViewAllUsers viewAllUsersFromJson(String str) => ViewAllUsers.fromJson(json.decode(str));

String viewAllUsersToJson(ViewAllUsers data) => json.encode(data.toJson());

class ViewAllUsers {
  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  ViewAllUsers({
     this.status,
     this.code,
     this.message,
     this.data,
  });

  factory ViewAllUsers.fromJson(Map<String, dynamic> json) => ViewAllUsers(
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
  String avatar;
  String id;
  String firstname;
  String lastname;
  String email;
  String password;
  List<dynamic> child;
  String otpCheck;
  int phoneNumber;
  bool isVerified;
  bool status;
  String role;
  List<dynamic> remindMe;
  DateTime createdAt;
  DateTime updatedAt;
  bool encEmail;
  String? address;
  DateTime? birthday;
  bool? isPrivate;
  int notifychat;

  Datum({
    required this.avatar,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.child,
    required this.otpCheck,
    required this.phoneNumber,
    required this.isVerified,
    required this.status,
    required this.role,
    required this.remindMe,
    required this.createdAt,
    required this.updatedAt,
    required this.encEmail,
    this.address,
    this.birthday,
    this.isPrivate,
    required this.notifychat,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    avatar: json["avatar"],
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    password: json["password"],
    child: List<dynamic>.from(json["child"].map((x) => x)),
    otpCheck: json["otpCheck"],
    phoneNumber: json["phoneNumber"],
    isVerified: json["isVerified"],
    status: json["status"],
    role: json["role"],
    remindMe: List<dynamic>.from(json["remindMe"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    encEmail: json["__enc_email"],
    address: json["address"],
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    isPrivate: json["isPrivate"],
    notifychat: json["notifychat"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password": password,
    "child": List<dynamic>.from(child.map((x) => x)),
    "otpCheck": otpCheck,
    "phoneNumber": phoneNumber,
    "isVerified": isVerified,
    "status": status,
    "role": role,
    "remindMe": List<dynamic>.from(remindMe.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__enc_email": encEmail,
    "address": address,
    "birthday": birthday?.toIso8601String(),
    "isPrivate": isPrivate,
    "notifychat": notifychat,
  };
}
