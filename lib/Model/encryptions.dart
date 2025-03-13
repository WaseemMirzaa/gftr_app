import 'dart:convert';

Encryption encryptionFromJson(String str) => Encryption.fromJson(json.decode(str));

String encryptionToJson(Encryption data) => json.encode(data.toJson());
class Encryption {

  Encryption({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  String? data;

  factory Encryption.fromJson(Map<String, dynamic> json) => Encryption(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data,
  };

}
