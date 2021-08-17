import 'dart:convert';

class CategoryModel {
  CategoryModel({
    this.parent,
    this.id,
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
  String? showInGrid;
  DateTime? createdAt;
  String? createdBy;
  int? v;
  DateTime? updatedAt;
  String? updatedBy;

  factory CategoryModel.fromJson(str) => CategoryModel.fromMap(str);

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        parent: json["parent"] == null ? null : json["parent"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        showInGrid: json["showInGrid"] == null ? null : json["showInGrid"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        v: json["__v"] == null ? null : json["__v"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
      );

  Map<String, dynamic> toMap() => {
        "parent": parent == null ? null : parent,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "showInGrid": showInGrid == null ? null : showInGrid,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "createdBy": createdBy == null ? null : createdBy,
        "__v": v == null ? null : v,
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "updatedBy": updatedBy == null ? null : updatedBy,
      };
}
