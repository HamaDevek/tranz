import 'dart:convert';

class CategoryModel {
  CategoryModel({
    this.parent,
    this.id,
    this.title,
    this.name,
    this.showInGrid,
    this.createdAt,
    this.createdBy,
    this.v,
    this.updatedAt,
    this.updatedBy,
  });

  String? parent;
  String? id;
  String? name;
  Map? title;
  String? showInGrid;
  DateTime? createdAt;
  String? createdBy;
  int? v;
  DateTime? updatedAt;
  String? updatedBy;

  factory CategoryModel.fromJson(str) => CategoryModel.fromMap(str);

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        parent: json["parent"],
        id: json["_id"],
        name: json["name"],
        title: json["title"],
        showInGrid: json["showInGrid"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toMap() => {
        "parent": parent,
        "_id": id,
        "name": name,
        "title": title,
        "showInGrid": showInGrid,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "createdBy": createdBy,
        "__v": v,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "updatedBy": updatedBy,
      };
}
