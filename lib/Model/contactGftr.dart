import 'dart:convert';

ContactGftr contactGftrFromJson(String str) => ContactGftr.fromJson(json.decode(str));

String contactGftrToJson(ContactGftr data) => json.encode(data.toJson());

class ContactGftr {
  ContactGftr({
    this.status,
    this.code,
    this.message,
    this.data,
  });
  bool? status;
  int? code;
  String? message;
  Data? data;

  factory ContactGftr.fromJson(Map<String, dynamic> json) => ContactGftr(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data();
  factory Data.fromJson(Map<String, dynamic> json) => Data();
  Map<String, dynamic> toJson() => {};
}
