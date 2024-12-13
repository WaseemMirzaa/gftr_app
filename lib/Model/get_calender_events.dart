// To parse this JSON data, do
//
//     final calenderGet = calenderGetFromJson(jsonString);

import 'dart:convert';

CalenderGet calenderGetFromJson(String str) => CalenderGet.fromJson(json.decode(str));

String calenderGetToJson(CalenderGet data) => json.encode(data.toJson());

class CalenderGet {
  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  CalenderGet({
     this.status,
     this.code,
     this.message,
     this.data,
  });

  factory CalenderGet.fromJson(Map<String, dynamic> json) => CalenderGet(
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
  String date;
  String title;
  String id;

  Datum({
    required this.date,
    required this.title,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"],
    title: json["title"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "title": title,
    "_id": id,
  };
}