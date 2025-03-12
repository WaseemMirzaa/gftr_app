// To parse this JSON data, do
//
//     final myNotifications = myNotificationsFromJson(jsonString);

import 'dart:convert';

MyNotifications myNotificationsFromJson(String str) => MyNotifications.fromJson(json.decode(str));

String myNotificationsToJson(MyNotifications data) => json.encode(data.toJson());

class MyNotifications {
  MyNotifications({
    this.status,
    this.code,
    this.message,
    this.receivedRequestBy,
    this.sentGroupRequestTo,
    this.groupRequestReply,
  });

  bool? status;
  int? code;
  String? message;
  List<GroupRequestReply>? receivedRequestBy;
  List<SentGroupRequestTo>? sentGroupRequestTo;
  List<GroupRequestReply>? groupRequestReply;

  factory MyNotifications.fromJson(Map<String, dynamic> json) => MyNotifications(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    receivedRequestBy: json["receivedRequestBy"] == null ? [] : List<GroupRequestReply>.from(json["receivedRequestBy"]!.map((x) => GroupRequestReply.fromJson(x))),
    sentGroupRequestTo: json["sentGroupRequestTo"] == null ? [] : List<SentGroupRequestTo>.from(json["sentGroupRequestTo"]!.map((x) => SentGroupRequestTo.fromJson(x))),
    groupRequestReply: json["groupRequestReply"] == null ? [] : List<GroupRequestReply>.from(json["groupRequestReply"]!.map((x) => GroupRequestReply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "receivedRequestBy": receivedRequestBy == null ? [] : List<dynamic>.from(receivedRequestBy!.map((x) => x.toJson())),
    "sentGroupRequestTo": sentGroupRequestTo == null ? [] : List<dynamic>.from(sentGroupRequestTo!.map((x) => x.toJson())),
    "groupRequestReply": groupRequestReply == null ? [] : List<dynamic>.from(groupRequestReply!.map((x) => x.toJson())),
  };
}

class GroupRequestReply {
  GroupRequestReply({
    this.name,
    this.phoneNumber,
    this.avatar,
    this.rektime,
    this.text,
    this.groupId,
  });

  String? name;
  int? phoneNumber;
  String? text;
  String? avatar;
  String? rektime;
  String? groupId;

  factory GroupRequestReply.fromJson(Map<String, dynamic> json) => GroupRequestReply(
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    text: json["text"],
    avatar: json["avatar"],
    rektime: json["rektime"],
    groupId: json["group_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "text": text,
    "avatar": avatar,
    "rektime": rektime,
    "group_id": groupId,
  };
}

class SentGroupRequestTo {
  SentGroupRequestTo({
    this.phoneNumber,
  });

  int? phoneNumber;

  factory SentGroupRequestTo.fromJson(Map<String, dynamic> json) => SentGroupRequestTo(
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
  };
}
