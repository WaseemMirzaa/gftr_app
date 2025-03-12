// To parse this JSON data, do
//
//     final folderDelete = folderDeleteFromJson(jsonString);

import 'dart:convert';

FolderDelete? folderDeleteFromJson(String str) => FolderDelete.fromJson(json.decode(str));

String folderDeleteToJson(FolderDelete? data) => json.encode(data!.toJson());

class FolderDelete {
  FolderDelete({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory FolderDelete.fromJson(Map<String, dynamic> json) => FolderDelete(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}

class Data {
  Data({
    this.id,
    this.folderName,
    this.isPublic,
    this.formdata,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? folderName;
  bool? isPublic;
  List<Formdatum?>? formdata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    folderName: json["folder_name"],
    isPublic: json["isPublic"],
    formdata: json["formdata"] == null ? [] : json["formdata"] == null ? [] : List<Formdatum?>.from(json["formdata"]!.map((x) => Formdatum.fromJson(x))),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "folder_name": folderName,
    "isPublic": isPublic,
    "formdata": formdata == null ? [] : formdata == null ? [] : List<dynamic>.from(formdata!.map((x) => x!.toJson())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class Formdatum {
  Formdatum({
    this.title,
    this.price,
    this.notes,
    this.image,
    this.id,
  });

  String? title;
  String? price;
  String? notes;
  String? image;
  String? id;

  factory Formdatum.fromJson(Map<String, dynamic> json) => Formdatum(
    title: json["title"],
    price: json["price"],
    notes: json["notes"],
    image: json["image"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "price": price,
    "notes": notes,
    "image": image,
    "_id": id,
  };
}
