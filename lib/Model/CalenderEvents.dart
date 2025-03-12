// To parse this JSON data, do
//
//     final calenderPost = calenderPostFromJson(jsonString);

import 'dart:convert';

CalenderPost calenderPostFromJson(String str) => CalenderPost.fromJson(json.decode(str));

String calenderPostToJson(CalenderPost data) => json.encode(data.toJson());

class CalenderPost {
  bool? status;
  int? code;
  String? message;
  Data? data;

  CalenderPost({
     this.status,
     this.code,
     this.message,
     this.data,
  });

  factory CalenderPost.fromJson(Map<String, dynamic> json) => CalenderPost(
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
  List<Userdatum> userdata;

  Data({
    required this.userdata,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userdata: List<Userdatum>.from(json["userdata"].map((x) => Userdatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userdata": List<dynamic>.from(userdata.map((x) => x.toJson())),
  };
}

class Userdatum {
  String date;
  String title;

  Userdatum({
    required this.date,
    required this.title,
  });

  factory Userdatum.fromJson(Map<String, dynamic> json) => Userdatum(
    date: json["date"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "title": title,
  };
}