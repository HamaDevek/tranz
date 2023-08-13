// To parse this JSON data, do
//
//     final blogsModel = blogsModelFromJson(jsonString);

import 'dart:convert';
import 'package:tranzhouse/Models/services_model.dart';

class BlogsModel {
  String? id;
  String? language;
  String? status;
  LanguagesModel? title;
  LanguagesModel? description;
  List<String>? images;
  List<String>? links;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  BlogsModel({
    this.id,
    this.language,
    this.status,
    this.title,
    this.description,
    this.images,
    this.links,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory BlogsModel.fromRawJson(String str) =>
      BlogsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
        id: json["_id"],
        language: json["language"],
        status: json["status"],
        title: json["title"] == null
            ? null
            : LanguagesModel.fromJson(json["title"]),
        description: json["description"] == null
            ? null
            : LanguagesModel.fromJson(json["description"]),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        links: json["links"] == null
            ? []
            : List<String>.from(json["links"]!.map((x) => x)),
        v: json["__v"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "language": language,
        "status": status,
        "title": title?.toJson(),
        "description": description?.toJson(),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
