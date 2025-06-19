// To parse this JSON data, do
//
//     final groups = groupsFromJson(jsonString);

import 'dart:convert';

Groups groupsFromJson(String str) => Groups.fromJson(json.decode(str));

String groupsToJson(Groups data) => json.encode(data.toJson());

class Groups {
  bool? status;
  int? code;
  String? message;
  String? loggedUser;
  List<GroupDetail>? groupDetails;
  List<UserNotAcceptedRequest>? userNotAcceptedRequest;

  Groups({
    this.status,
    this.code,
    this.message,
    this.loggedUser,
    this.groupDetails,
    this.userNotAcceptedRequest,
  });

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        loggedUser: json["loggedUser"],
        groupDetails: json["groupDetails"] != null
            ? List<GroupDetail>.from(
                json["groupDetails"].map((x) => GroupDetail.fromJson(x)))
            : null,
        userNotAcceptedRequest: List<UserNotAcceptedRequest>.from(
            json["userNotAcceptedRequest"]
                .map((x) => UserNotAcceptedRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "loggedUser": loggedUser,
        "groupDetails": groupDetails != null
            ? List<dynamic>.from(groupDetails!.map((x) => x.toJson()))
            : null,
        "userNotAcceptedRequest": userNotAcceptedRequest != null
            ? List<dynamic>.from(userNotAcceptedRequest!.map((x) => x.toJson()))
            : null
      };
}

class UserNotAcceptedRequest {
  String id;
  int phoneNumber;
  String avatar;
  String name;
  String groupId;

  UserNotAcceptedRequest({
    required this.id,
    required this.phoneNumber,
    required this.avatar,
    required this.name,
    required this.groupId,
  });

  factory UserNotAcceptedRequest.fromJson(Map<String, dynamic> json) =>
      UserNotAcceptedRequest(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        avatar: json["avatar"],
        name: json["name"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "avatar": avatar,
        "name": name,
        "groupId": groupId,
      };
}

class GroupDetail {
  String id;
  int phoneNumber;
  String avatar;
  String name;
  DateTime birthday;
  String birthdayIsIn;
  List<dynamic> gifts;
  List<Myidea> myideas;
  List<Myidea> publicDatas;
  Address address;

  GroupDetail({
    required this.id,
    required this.phoneNumber,
    required this.avatar,
    required this.name,
    required this.birthday,
    required this.birthdayIsIn,
    required this.gifts,
    required this.myideas,
    required this.publicDatas,
    required this.address,
  });
  factory GroupDetail.fromJson(Map<String, dynamic> json) => GroupDetail(
        id: json["id"] ?? "",
        phoneNumber: json["phoneNumber"] ?? 0,
        avatar: json["avatar"] ?? "",
        name: json["name"] ?? "",
        birthday:
            DateTime.tryParse(json["birthday"] ?? "") ?? DateTime(1970, 1, 1),
        birthdayIsIn: json["birthdayIsIn"] ?? "",
        gifts: json["gifts"] != null
            ? List<dynamic>.from(json["gifts"].map((x) => x))
            : [],
        myideas: json["myideas"] != null
            ? List<Myidea>.from(json["myideas"].map((x) => Myidea.fromJson(x)))
            : [],
        publicDatas: json["publicDatas"] != null
            ? List<Myidea>.from(
                json["publicDatas"].map((x) => Myidea.fromJson(x)))
            : [],
        address: json["address"] != null
            ? Address.fromJson(json["address"])
            : Address(
                city: "",
                street: "",
                unit: "",
                zipcore: "",
                state: "",
                country: ""),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phoneNumber": phoneNumber,
        "avatar": avatar,
        "name": name,
        "birthday": birthday.toIso8601String(),
        "birthdayIsIn": birthdayIsIn,
        "gifts": List<dynamic>.from(gifts.map((x) => x)),
        "myideas": List<dynamic>.from(myideas.map((x) => x.toJson())),
        "publicDatas": List<dynamic>.from(publicDatas.map((x) => x.toJson())),
        "address": address.toJson(),
      };
}

class Address {
  String city;
  String street;
  String unit;
  String zipcore;
  String state;
  String country;

  Address({
    required this.city,
    required this.street,
    required this.unit,
    required this.zipcore,
    required this.state,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"] ?? "",
        street: json["street"] ?? "",
        unit: json["unit"] ?? "",
        zipcore: json["zipcore"] ?? "",
        state: json["state"] ?? "",
        country: json["country"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "street": street,
        "unit": unit,
        "zipcore": zipcore,
        "state": state,
        "country": country,
      };
}

class Myidea {
  String id;
  String title;
  String price;
  String notes;
  String image;
  bool starredGift;
  String webViewLink;
  String markGift;

  Myidea({
    required this.id,
    required this.title,
    required this.price,
    required this.notes,
    required this.image,
    required this.starredGift,
    required this.webViewLink,
    required this.markGift,
  });

  factory Myidea.fromJson(Map<String, dynamic> json) => Myidea(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        price: json["price"] ?? "",
        notes: json["notes"] ?? "",
        image: json["image"] ?? "",
        starredGift: json["starredGift"] ?? false,
        webViewLink: json["webViewLink"] ?? "",
        markGift: json["markGift"] ?? "",
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "notes": notes,
        "image": image,
        "starredGift": starredGift,
        "webViewLink": webViewLink,
        "markGift": markGift,
      };
}




// // To parse this JSON data, do
// //
// //     final groups = groupsFromJson(jsonString);
//
// import 'dart:convert';
//
// Groups groupsFromJson(String str) => Groups.fromJson(json.decode(str));
//
// String groupsToJson(Groups data) => json.encode(data.toJson());
//
// class Groups {
//   bool? status;
//   int? code;
//   String? message;
//   String? loggedUser;
//   List<GroupDetail>? groupDetails;
//
//   Groups({
//     this.status,
//     this.code,
//     this.message,
//     this.loggedUser,
//     this.groupDetails,
//   });
//
//   factory Groups.fromJson(Map<String, dynamic> json) => Groups(
//     status: json["status"],
//     code: json["code"],
//     message: json["message"],
//     loggedUser: json["loggedUser"],
//     groupDetails: List<GroupDetail>.from(json["groupDetails"].map((x) => GroupDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "code": code,
//     "message": message,
//     "loggedUser": loggedUser,
//     "groupDetails": List<dynamic>.from(groupDetails!.map((x) => x.toJson())),
//   };
// }
//
// class GroupDetail {
//   String id;
//   String avatar;
//   int phoneNumber;
//   String name;
//   DateTime birthday;
//   Address address;
//   String birthdayIsIn;
//   List<Gift> gifts;
//
//   GroupDetail({
//     required this.id,
//     required this.avatar,
//     required this.phoneNumber,
//     required this.name,
//     required this.birthday,
//     required this.address,
//     required this.birthdayIsIn,
//     required this.gifts,
//   });
//
//   factory GroupDetail.fromJson(Map<String, dynamic> json) => GroupDetail(
//     id: json["id"],
//     avatar: json["avatar"],
//     phoneNumber: json["phoneNumber"],
//     name: json["name"],
//     birthday: DateTime.parse(json["birthday"]),
//     address: Address.fromJson(json["address"]),
//     birthdayIsIn: json["birthdayIsIn"],
//     gifts: List<Gift>.from(json["gifts"].map((x) => Gift.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "avatar": avatar,
//     "phoneNumber": phoneNumber,
//     "name": name,
//     "birthday": birthday.toIso8601String(),
//     "address": address.toJson(),
//     "birthdayIsIn": birthdayIsIn,
//     "gifts": List<dynamic>.from(gifts.map((x) => x.toJson())),
//   };
// }
//
// class Address {
//   String city;
//   String street;
//   String unit;
//   String zipcore;
//   String state;
//   String country;
//
//   Address({
//     required this.city,
//     required this.street,
//     required this.unit,
//     required this.zipcore,
//     required this.state,
//     required this.country,
//   });
//
//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//     city: json["city"],
//     street: json["street"],
//     unit: json["unit"],
//     zipcore: json["zipcore"],
//     state: json["state"],
//     country: json["country"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "city": city,
//     "street": street,
//     "unit": unit,
//     "zipcore": zipcore,
//     "state": state,
//     "country": country,
//   };
// }
//
// class Gift {
//   String id;
//   String title;
//   String price;
//   String notes;
//   String image;
//   bool starredGift;
//   String webViewLink;
//   String markGift;
//
//   Gift({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.notes,
//     required this.image,
//     required this.starredGift,
//     required this.webViewLink,
//     required this.markGift,
//   });
//
//   factory Gift.fromJson(Map<String, dynamic> json) => Gift(
//     id: json["id"],
//     title: json["title"],
//     price: json["price"],
//     notes: json["notes"],
//     image: json["image"],
//     starredGift: json["starredGift"],
//     webViewLink: json["webViewLink"],
//     markGift: json["markGift"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "price": price,
//     "notes": notes,
//     "image": image,
//     "starredGift": starredGift,
//     "webViewLink": webViewLink,
//     "markGift": markGift,
//   };
// }
