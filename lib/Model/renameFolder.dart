// To parse this JSON data, do
//
//     final renameFolder = renameFolderFromJson(jsonString);

import 'dart:convert';

RenameFolder renameFolderFromJson(String str) => RenameFolder.fromJson(json.decode(str));

String renameFolderToJson(RenameFolder data) => json.encode(data.toJson());

class RenameFolder {
  RenameFolder({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory RenameFolder.fromJson(Map<String, dynamic> json) => RenameFolder(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
