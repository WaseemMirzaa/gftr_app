import 'dart:convert';

GftrStories gftrStoriesFromJson(String str) => GftrStories.fromJson(json.decode(str));

String gftrStoriesToJson(GftrStories data) => json.encode(data.toJson());

class GftrStories {
  GftrStories({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  GftrData? data;

  factory GftrStories.fromJson(Map<String, dynamic> json) => GftrStories(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : GftrData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "data": data == null ? null : data!.toJson(),
  };
}

class GftrData {
  GftrData({
    this.post,
  });

  List<Post>? post;

  factory GftrData.fromJson(Map<String, dynamic> json) => GftrData(
    post: json["post"] == null ? null : List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "post": post == null ? null : List<dynamic>.from(post!.map((x) => x.toJson())),
  };
}

class Post {
  Post({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  String? id;
  String? title;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
    content: json["content"] == null ? null : json["content"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
    "content": content == null ? null : content,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "image": image == null ? null : image,
  };
}
