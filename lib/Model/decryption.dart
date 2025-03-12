import 'dart:convert';

Decryption decryptionFromJson(String str) => Decryption.fromJson(json.decode(str));

String decryptionToJson(Decryption data) => json.encode(data.toJson());

class Decryption {
  Decryption({
    this.data,
  });

  String? data;
  factory Decryption.fromJson(Map<String, dynamic> json) => Decryption(
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data,
  };
}
