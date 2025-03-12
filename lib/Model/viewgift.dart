// To parse this JSON data, do
//
//     final viewGift = viewGiftFromJson(jsonString);

import 'dart:convert';

ViewGift viewGiftFromJson(String str) => ViewGift.fromJson(json.decode(str));

String viewGiftToJson(ViewGift data) => json.encode(data.toJson());

class ViewGift {
  ViewGift({
    this.status,
    this.code,
    this.message,
    this.privateData,
    this.publicData,
    this.allData,
    this.groupsData,
  });

  bool? status;
  int? code;
  String? message;
  List<Datum>? privateData;
  List<Datum>? publicData;
  List<AllDatum>? allData;
  List<GroupsDatum>? groupsData;

  factory ViewGift.fromJson(Map<String, dynamic> json) => ViewGift(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        privateData: json["privateData"] == null
            ? []
            : List<Datum>.from(json["privateData"]!.map((x) => Datum.fromJson(x))),
        publicData: json["publicData"] == null
            ? []
            : List<Datum>.from(
                json["publicData"]!.map((x) => Datum.fromJson(x))),
        allData: json["allData"] == null
            ? []
            : List<AllDatum>.from(
                json["allData"]!.map((x) => AllDatum.fromJson(x))),
        groupsData: json["groupsData"] == null
            ? []
            : List<GroupsDatum>.from(
                json["groupsData"]!.map((x) => GroupsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "privateData": privateData == null
            ? []
            : List<dynamic>.from(privateData!.map((x) => x.toJson())),
        "publicData": publicData == null
            ? []
            : List<dynamic>.from(publicData!.map((x) => x.toJson())),
        "allData": allData == null
            ? []
            : List<dynamic>.from(allData!.map((x) => x.toJson())),
        "groupsData": groupsData == null
            ? []
            : List<dynamic>.from(groupsData!.map((x) => x.toJson())),
      };
}

class AllDatum {
  AllDatum({
    this.id,
    this.folderName,
  });

  String? id;
  String? folderName;

  factory AllDatum.fromJson(Map<String, dynamic> json) => AllDatum(
        id: json["_id"],
        folderName: json["folder_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "folder_name": folderName,
      };
}

class GroupsDatum {
  GroupsDatum({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory GroupsDatum.fromJson(Map<String, dynamic> json) => GroupsDatum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Datum {
  Datum({
    this.id,
    this.userid,
    this.folderName,
    this.isPublic,
    this.formdata,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? userid;
  String? folderName;
  bool? isPublic;
  List<Formdatum>? formdata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userid: json["userid"],
        folderName: json["folder_name"],
        isPublic: json["isPublic"],
        formdata: json["formdata"] == null
            ? []
            : List<Formdatum>.from(
                json["formdata"]!.map((x) => Formdatum.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "folder_name": folderName,
        "isPublic": isPublic,
        "formdata": formdata == null
            ? []
            : List<dynamic>.from(formdata!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Formdatum {
  Formdatum(
      {this.title,
      this.price,
      this.notes,
      this.image,
      this.id,
      this.starredGift,
      this.webViewLink});

  String? title;
  String? price;
  String? notes;
  String? image;
  String? id;
  bool? starredGift;
  String? webViewLink;

  factory Formdatum.fromJson(Map<String, dynamic> json) => Formdatum(
        title: json["title"],
        price: json["price"],
        notes: json["notes"],
        image: json["image"],
        id: json["_id"],
        starredGift: json["starredGift"],
        webViewLink: json["webViewLink"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "notes": notes,
        "image": image,
        "webViewLink": webViewLink,
        "_id": id,
        "starredGift": starredGift,
      };
}
