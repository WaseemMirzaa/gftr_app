// To parse this JSON data, do
//
//     final rooms = roomsFromJson(jsonString);

import 'dart:convert';

Rooms roomsFromJson(String str) => Rooms.fromJson(json.decode(str));

String roomsToJson(Rooms data) => json.encode(data.toJson());

class Rooms {
  Rooms({
    this.room,
  });

  List<Room>? room;

  factory Rooms.fromJson(Map<String, dynamic> json) => Rooms(
    room: json["room"] == null ? [] : List<Room>.from(json["room"]!.map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "room": room == null ? [] : List<dynamic>.from(room!.map((x) => x.toJson())),
  };
}

class Room {
  Room({
    this.id,
    this.roomid,
    this.user1,
    this.newMessage1,
    this.user2,
    this.newMessage2,
  });

  String? id;
  String? roomid;
  User? user1;
  int? newMessage1;
  User? user2;
  int? newMessage2;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["_id"],
    roomid: json["roomid"],
    user1: json["user1"] == null ? null : User.fromJson(json["user1"]),
    newMessage1: json["newMessage1"],
    user2: json["user2"] == null ? null : User.fromJson(json["user2"]),
    newMessage2: json["newMessage2"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "roomid": roomid,
    "user1": user1?.toJson(),
    "newMessage1": newMessage1,
    "user2": user2?.toJson(),
    "newMessage2": newMessage2,
  };
}

class User {
  User({
    this.id,
  });

  String? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
  };
}
