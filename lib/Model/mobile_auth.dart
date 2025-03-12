// To parse this JSON data, do
//
//     final mobileAuth = mobileAuthFromJson(jsonString);

import 'dart:convert';

MobileAuth mobileAuthFromJson(String str) => MobileAuth.fromJson(json.decode(str));

String mobileAuthToJson(MobileAuth data) => json.encode(data.toJson());

class MobileAuth {
  bool status;
  int code;
  String message;
  Data data;
  String page;

  MobileAuth({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.page,
  });

  factory MobileAuth.fromJson(Map<String, dynamic> json) => MobileAuth(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data.toJson(),
    "page": page,
  };
}

class Data {
  String id;
  String firstname;
  String lastname;
  String email;
  String avatar;
  List<dynamic> child;
  bool isVerified;
  bool status;
  String role;
  int notifychat;
  String source;
  List<dynamic> remindMe;
  DateTime createdAt;
  DateTime updatedAt;
  bool encEmail;

  Data({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.avatar,
    required this.child,
    required this.isVerified,
    required this.status,
    required this.role,
    required this.notifychat,
    required this.source,
    required this.remindMe,
    required this.createdAt,
    required this.updatedAt,
    required this.encEmail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    avatar: json["avatar"],
    child: List<dynamic>.from(json["child"].map((x) => x)),
    isVerified: json["isVerified"],
    status: json["status"],
    role: json["role"],
    notifychat: json["notifychat"],
    source: json["source"],
    remindMe: List<dynamic>.from(json["remindMe"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    encEmail: json["__enc_email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "avatar": avatar,
    "child": List<dynamic>.from(child.map((x) => x)),
    "isVerified": isVerified,
    "status": status,
    "role": role,
    "notifychat": notifychat,
    "source": source,
    "remindMe": List<dynamic>.from(remindMe.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__enc_email": encEmail,
  };
}
