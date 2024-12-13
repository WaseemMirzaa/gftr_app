// To parse this JSON data, do
//
//     final addForm = addFormFromJson(jsonString);

import 'dart:convert';

AddForm addFormFromJson(String str) => AddForm.fromJson(json.decode(str));

String addFormToJson(AddForm data) => json.encode(data.toJson());

class AddForm {
  AddForm({
    this.status,
    this.message,
    this.addToData,
  });

  bool? status;
  String? message;
  AddToData? addToData;

  factory AddForm.fromJson(Map<String, dynamic> json) => AddForm(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    addToData: json["addToData"] == null ? null : AddToData.fromJson(json["addToData"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "addToData": addToData == null ? null : addToData!.toJson(),
  };
}

class AddToData {
  AddToData({
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
  List<Formdatum>? formdata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AddToData.fromJson(Map<String, dynamic> json) => AddToData(
    id: json["_id"] == null ? null : json["_id"],
    folderName: json["folder_name"] == null ? null : json["folder_name"],
    isPublic: json["isPublic"] == null ? null : json["isPublic"],
    formdata: json["formdata"] == null ? null : List<Formdatum>.from(json["formdata"].map((x) => Formdatum.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "folder_name": folderName == null ? null : folderName,
    "isPublic": isPublic == null ? null : isPublic,
    "formdata": formdata == null ? null : List<dynamic>.from(formdata!.map((x) => x.toJson())),
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
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
    title: json["title"] == null ? null : json["title"],
    price: json["price"] == null ? null : json["price"],
    notes: json["notes"] == null ? null : json["notes"],
    image: json["image"] == null ? null : json["image"],
    id: json["_id"] == null ? null : json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "price": price == null ? null : price,
    "notes": notes == null ? null : notes,
    "image": image == null ? null : image,
    "_id": id == null ? null : id,
  };
}
