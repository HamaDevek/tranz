// To parse this JSON data, do
//
//     final ServiceModel = ServiceModelFromMap(jsonString);

import 'dart:convert';

class ServiceModel {
  ServiceModel({
    this.parent,
    this.id,
    this.name,
    this.title,
    this.type,
    this.picture,
    this.createdAt,
    this.branch,
    this.createdBy,
    this.v,
  });

  final String? parent;
  final String? id;
  final String? name;
  final Map? title;
  final String? type;
  final String? picture;
  final DateTime? createdAt;
  final String? branch;
  final String? createdBy;
  final int? v;

  factory ServiceModel.fromJson(str) => ServiceModel.fromMap(str);

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromMap(Map<String, dynamic> json) => ServiceModel(
        parent: json["parent"] == null ? null : json["parent"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        picture: json["picture"] == null ? null : json["picture"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        branch: json["branch"] == null ? null : json["branch"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "parent": parent == null ? null : parent,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "title": title == null ? null : title,
        "type": type == null ? null : type,
        "picture": picture == null ? null : picture,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "branch": branch == null ? null : branch,
        "createdBy": createdBy == null ? null : createdBy,
        "__v": v == null ? null : v,
      };
}
