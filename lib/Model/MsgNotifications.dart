// To parse this JSON data, do
//
//final notifications = notificationsFromJson(jsonString);





import 'dart:convert';




Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));




String notificationsToJson(Notifications data) => json.encode(data.toJson());




class Notifications {
  bool? status;
  int? code;
  String? message;
  int? data;




  Notifications({
   this.status,
   this.code,
   this.message,
   this.data,
  });




  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
  status: json["status"],
  code: json["code"],
  message: json["message"],
  data: json["data"],
  );




  Map<String, dynamic> toJson() => {
  "status": status,
  "code": code,
  "message": message,
  "data": data,
  };
}