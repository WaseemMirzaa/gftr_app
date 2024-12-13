// To parse this JSON data, do
//
//     final groupRequestReply = groupRequestReplyFromJson(jsonString);

import 'dart:convert';

GroupRequestReplyNotification groupRequestReplyFromJson(String str) => GroupRequestReplyNotification.fromJson(json.decode(str));

String groupRequestReplyToJson(GroupRequestReplyNotification data) => json.encode(data.toJson());

class GroupRequestReplyNotification {
  GroupRequestReplyNotification({
    this.status,
    this.code,
    this.message,
    this.groupRequestReply,
  });

  bool? status;
  int? code;
  String? message;
  List<GroupRequestReplyElement>? groupRequestReply;

  factory GroupRequestReplyNotification.fromJson(Map<String, dynamic> json) => GroupRequestReplyNotification(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    groupRequestReply: json["groupRequestReply"] == null ? [] : List<GroupRequestReplyElement>.from(json["groupRequestReply"]!.map((x) => GroupRequestReplyElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "groupRequestReply": groupRequestReply == null ? [] : List<dynamic>.from(groupRequestReply!.map((x) => x.toJson())),
  };
}

class GroupRequestReplyElement {
  GroupRequestReplyElement({
    this.name,
    this.phoneNumber,
    this.avatar,
    this.restime,
    this.text,
  });

  String? name;
  String? avatar;
  String? restime;
  int? phoneNumber;
  String? text;

  factory GroupRequestReplyElement.fromJson(Map<String, dynamic> json) => GroupRequestReplyElement(
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    avatar: json["avatar"],
    restime: json["restime"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "avatar": avatar,
    "restime": restime,
    "phoneNumber": phoneNumber,
    "text": text,
  };
}
