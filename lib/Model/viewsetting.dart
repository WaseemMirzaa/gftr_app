// To parse this JSON data, do
//
//     final viewSetting = viewSettingFromJson(jsonString);

import 'dart:convert';

ViewSetting viewSettingFromJson(String str) =>
    ViewSetting.fromJson(json.decode(str));

String viewSettingToJson(ViewSetting data) => json.encode(data.toJson());

class ViewSetting {
  bool? status;
  int? code;
  String? message;
  Data? data;

  ViewSetting({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ViewSetting.fromJson(Map<String, dynamic> json) => ViewSetting(
        status: json["status"],
        code: json["code"] is int
            ? json["code"]
            : int.tryParse(json["code"].toString()),
        message: json["message"] ?? "",
        data: Data.fromJson(json["data"] ?? ""),
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
  List<RemindMe> remindMe;
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
    required this.id, //Done
    required this.firstname, //Done
    required this.lastname, //Done
    required this.email, //Done
    required this.password, //Done
    required this.avatar, //Done
    required this.child, //done
    required this.otpCheck, //Done
    required this.phoneNumber, //Done
    required this.isVerified, //Done
    required this.status, //Done
    required this.role, //Done
    required this.notifychat, //Done
    required this.remindMe, //Done
    required this.createdAt, //Done
    required this.updatedAt, //Done
    required this.encEmail, //Done
    required this.birthday, //Done
    required this.city, //Done
    required this.country, //Done
    required this.isPrivate, //Done
    required this.state, //Done
    required this.street, //Done
    required this.unit, //Done
    required this.zipcode, //Done
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['_id']?.toString() ?? '',
        firstname: json['firstname']?.toString() ?? '',
        lastname: json['lastname']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        password: json['password']?.toString() ?? '',
        avatar: json['avatar']?.toString() ?? '',
        child: (json['child'] as List?)?.map((x) => x).toList() ?? [],
        otpCheck: json['otpCheck']?.toString() ?? '',
        phoneNumber: json['phoneNumber'] is int
            ? json['phoneNumber']
            : int.tryParse(json['phoneNumber']?.toString() ?? '') ?? 0,
        isVerified: json['isVerified'] is bool
            ? json['isVerified']
            : json['isVerified']?.toString().toLowerCase() == 'true',
        status: json['status'] is bool
            ? json['status']
            : json['status']?.toString().toLowerCase() == 'true',
        role: json['role']?.toString() ?? '',
        notifychat: json['notifychat'] is int
            ? json['notifychat']
            : int.tryParse(json['notifychat']?.toString() ?? '') ?? 0,
        remindMe: (json['remindMe'] as List?)
                ?.map((x) => RemindMe.fromJson(x))
                .toList() ??
            [],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now(),
        encEmail: json['__enc_email'] is bool
            ? json['__enc_email']
            : json['__enc_email']?.toString().toLowerCase() == 'true',
        birthday: json['birthday'] != null
            ? DateTime.parse(json['birthday'])
            : DateTime.now(),
        city: json['city']?.toString() ?? '',
        country: json['country']?.toString() ?? '',
        isPrivate: json['isPrivate'] is bool
            ? json['isPrivate']
            : json['isPrivate']?.toString().toLowerCase() == 'true',
        state: json['state']?.toString() ?? '',
        street: json['street']?.toString() ?? '',
        unit: json['unit']?.toString() ?? '',
        zipcode: json['zipcode']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password ?? '',
        "avatar": avatar,
        "child": List<dynamic>.from(child.map((x) => x)),
        "otpCheck": otpCheck,
        "phoneNumber": phoneNumber,
        "isVerified": isVerified,
        "status": status,
        "role": role,
        "notifychat": notifychat,
        "remindMe": List<dynamic>.from(remindMe.map((x) => x.toJson())),
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

class RemindMe {
  String dayName;
  DateTime dayDate;
  String id;

  RemindMe({
    required this.dayName,
    required this.dayDate,
    required this.id,
  });

  factory RemindMe.fromJson(Map<String, dynamic> json) => RemindMe(
        dayName: json["dayName"],
        dayDate: DateTime.parse(json["dayDate"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "dayName": dayName,
        "dayDate": dayDate.toIso8601String(),
        "_id": id,
      };
}
