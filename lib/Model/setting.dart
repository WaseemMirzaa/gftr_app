// To parse this JSON data, do
//
//     final setting = settingFromJson(jsonString);

import 'dart:convert';

Setting settingFromJson(String str) => Setting.fromJson(json.decode(str));

String settingToJson(Setting data) => json.encode(data.toJson());

class Setting {
  Setting({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  Data? data;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    status: json["status"],
    code: json[" code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    " code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.userData,
  });

  UserData? userData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: json["userData"] == null ? null : UserData.fromJson(json["userData"]),
  );

  Map<String, dynamic> toJson() => {
    "userData": userData?.toJson(),
  };
}

class UserData {
  UserData({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.child,
    this.otpCheck,
    this.phoneNumber,
    this.isVerified,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.encEmail,
    this.address,
    this.birthday,
    this.isPrivate,
    this.remindMe,
    this.birthdayRemind,
    this.holidayRemind,
    this.preferThrough,
  });

  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  List<dynamic>? child;
  String? otpCheck;
  int? phoneNumber;
  bool? isVerified;
  bool? status;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? encEmail;
  String? address;
  DateTime? birthday;
  bool? isPrivate;
  List<RemindMe>? remindMe;
  String? birthdayRemind;
  String? holidayRemind;
  String? preferThrough;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    password: json["password"],
    child: json["child"] == null ? [] : List<dynamic>.from(json["child"]!.map((x) => x)),
    otpCheck: json["otpCheck"],
    phoneNumber: json["phoneNumber"],
    isVerified: json["isVerified"],
    status: json["status"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    encEmail: json["__enc_email"],
    address: json["address"],
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    isPrivate: json["isPrivate"],
    remindMe: json["remindMe"] == null ? [] : List<RemindMe>.from(json["remindMe"]!.map((x) => RemindMe.fromJson(x))),
    birthdayRemind: json["birthdayRemind"],
    holidayRemind: json["holidayRemind"],
    preferThrough: json["preferThrough"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password": password,
    "child": child == null ? [] : List<dynamic>.from(child!.map((x) => x)),
    "otpCheck": otpCheck,
    "phoneNumber": phoneNumber,
    "isVerified": isVerified,
    "status": status,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__enc_email": encEmail,
    "address": address,
    "birthday": birthday?.toIso8601String(),
    "isPrivate": isPrivate,
    "remindMe": remindMe == null ? [] : List<dynamic>.from(remindMe!.map((x) => x.toJson())),
    "birthdayRemind": birthdayRemind,
    "holidayRemind": holidayRemind,
    "preferThrough": preferThrough,
  };
}

class RemindMe {
  RemindMe({
    this.dayName,
    this.dayDate,
    this.id,
  });

  String? dayName;
  DateTime? dayDate;
  String? id;

  factory RemindMe.fromJson(Map<String, dynamic> json) => RemindMe(
    dayName: json["dayName"],
    dayDate: json["dayDate"] == null ? null : DateTime.parse(json["dayDate"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "dayName": dayName,
    "dayDate": dayDate?.toIso8601String(),
    "_id": id,
  };
}
