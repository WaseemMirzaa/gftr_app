import 'dart:convert';

GftrStories gftrStoriesFromJson(String str) =>
    GftrStories.fromJson(json.decode(str));

String gftrStoriesToJson(GftrStories data) => json.encode(data.toJson());

class GftrStories {
  GftrStories({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  GftrData? data;

  factory GftrStories.fromJson(Map<String, dynamic> json) => GftrStories(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["array"] == null
            ? null
            : GftrData.fromJson({"post": json["array"]}),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "array": data == null ? null : data!.toJson()["post"],
      };
}

class GftrData {
  GftrData({
    this.post,
  });

  List<Post>? post;

  factory GftrData.fromJson(Map<String, dynamic> json) => GftrData(
        post: json["post"] == null
            ? null
            : List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "post": post == null
            ? null
            : List<dynamic>.from(post!.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    this.id,
    this.title,
    this.title1,
    this.blogType,
    this.content,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.blogItemArray,
  });

  String? id;
  String? title;
  String? title1;
  String? blogType;
  String? content;
  String? image;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BlogItem>? blogItemArray;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        title1: json["title_1"] == null ? null : json["title_1"],
        blogType: json["blog_type"] == null ? null : json["blog_type"],
        content: json["content"] == null ? null : json["content"],
        image: json["image"] == null ? null : json["image"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        blogItemArray: json["blogItemArray"] == null
            ? null
            : List<BlogItem>.from(
                json["blogItemArray"].map((x) => BlogItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "title_1": title1 == null ? null : title1,
        "blog_type": blogType == null ? null : blogType,
        "content": content == null ? null : content,
        "image": image == null ? null : image,
        "status": status == null ? null : status,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "blogItemArray": blogItemArray == null
            ? null
            : List<dynamic>.from(blogItemArray!.map((x) => x.toJson())),
      };
}

class BlogItem {
  BlogItem({
    this.id,
    this.storyId,
    this.title,
    this.content,
    this.price,
    this.platform,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? storyId;
  String? title;
  String? content;
  String? price;
  String? platform;
  String? image;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BlogItem.fromJson(Map<String, dynamic> json) => BlogItem(
        id: json["_id"] == null ? null : json["_id"],
        storyId: json["storyid"] == null ? null : json["storyid"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        price: json["price"] == null ? null : json["price"],
        platform: json["platform"] == null ? null : json["platform"],
        image: json["image"] == null ? null : json["image"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "storyid": storyId == null ? null : storyId,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "price": price == null ? null : price,
        "platform": platform == null ? null : platform,
        "image": image == null ? null : image,
        "status": status == null ? null : status,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
