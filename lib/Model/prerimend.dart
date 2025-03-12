// To parse this JSON data, do
//
//     final preRimend = preRimendFromJson(jsonString);

import 'dart:convert';

PreRimend preRimendFromJson(String str) => PreRimend.fromJson(json.decode(str));

String preRimendToJson(PreRimend data) => json.encode(data.toJson());

class PreRimend {
  PreRimend({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  factory PreRimend.fromJson(Map<String, dynamic> json) => PreRimend(
    status: json["status"],
    code: json[" code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    " code": code,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.dayName,
    this.dayDate,
  });

  String? dayName;
  DateTime? dayDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    dayName: json["dayName"],
    dayDate: json["dayDate"] == null ? null : DateTime.parse(json["dayDate"]),
  );

  Map<String, dynamic> toJson() => {
    "dayName": dayName,
    "dayDate": dayDate?.toIso8601String(),
  };
}
