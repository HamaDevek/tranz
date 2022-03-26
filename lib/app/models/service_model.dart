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
        parent: json["parent"],
        id: json["_id"],
        name: json["name"],
        title: json["title"],
        type: json["type"],
        picture: json["picture"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        branch: json["branch"],
        createdBy: json["createdBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "parent": parent,
        "_id": id,
        "name": name,
        "title": title,
        "type": type,
        "picture": picture,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "branch": branch,
        "createdBy": createdBy,
        "__v": v,
      };
}
