// To parse this JSON data, do
//
//     final messagePreView = messagePreViewFromJson(jsonString);

import 'dart:convert';

MessagePreView messagePreViewFromJson(String str) => MessagePreView.fromJson(json.decode(str));

String messagePreViewToJson(MessagePreView data) => json.encode(data.toJson());

class MessagePreView {
  MessagePreView({
    this.id,
    this.to,
    this.from,
    this.roomid,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? to;
  String? from;
  String? roomid;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MessagePreView.fromJson(Map<String, dynamic> json) => MessagePreView(
    id: json["_id"],
    to: json["to"],
    from: json["from"],
    roomid: json["roomid"],
    message: json["message"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "to": to,
    "from": from,
    "roomid": roomid,
    "message": message,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
