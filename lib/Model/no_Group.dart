import 'dart:convert';

NoGroupData noGroupDataFromJson(String str) => NoGroupData.fromJson(json.decode(str));

String noGroupDataToJson(NoGroupData data) => json.encode(data.toJson());

class NoGroupData {
  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  NoGroupData({
     this.status,
     this.code,
     this.message,
     this.data,
  });

  factory NoGroupData.fromJson(Map<String, dynamic> json) => NoGroupData(
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
  String title;
  String price;
  String notes;
  String image;
  bool starredGift;
  dynamic userIdView;
  String webViewLink;
  String markGift;
  String id;

  Datum({
    required this.title,
    required this.price,
    required this.notes,
    required this.image,
    required this.starredGift,
    this.userIdView,
    required this.webViewLink,
    required this.markGift,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    price: json["price"],
    notes: json["notes"],
    image: json["image"],
    starredGift: json["starredGift"],
    userIdView: json["userIdView"],
    webViewLink: json["webViewLink"],
    markGift: json["markGift"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "price": price,
    "notes": notes,
    "image": image,
    "starredGift": starredGift,
    "userIdView": userIdView,
    "webViewLink": webViewLink,
    "markGift": markGift,
    "_id": id,
  };
}