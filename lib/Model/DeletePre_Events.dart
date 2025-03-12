// To parse this JSON data, do
//
//     final deleteeventes = deleteeventesFromJson(jsonString);





import 'dart:convert';




Deleteeventes deleteeventesFromJson(String str) => Deleteeventes.fromJson(json.decode(str));




String deleteeventesToJson(Deleteeventes data) => json.encode(data.toJson());




class Deleteeventes {
  bool? status;
  int? code;
  String? message;
  Data? data;




  Deleteeventes({
     this.status,
     this.code,
     this.message,
     this.data,
  });




  factory Deleteeventes.fromJson(Map<String, dynamic> json) => Deleteeventes(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );




  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
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