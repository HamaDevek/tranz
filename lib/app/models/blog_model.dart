import 'dart:convert';

import 'package:trancehouse/utils/config.dart';

class BlogModel {
  BlogModel({
    this.picture,
    this.state,
    this.type,
    this.id,
    this.title,
    this.description,
    this.html,
    this.priority,
    this.section,
    this.author,
    this.category,
    this.link,
    this.branch,
    this.createdAt,
    this.createdBy,
    this.v,
    this.buttonLabel,
    this.updatedAt,
    this.updatedBy,
  });

  List<String>? picture;
  String? state;
  String? type;
  String? id;
  Map? title;
  Map? description;
  String? html;
  int? priority;
  int? section;
  String? author;
  String? category;
  String? link;
  String? branch;
  DateTime? createdAt;
  String? createdBy;
  int? v;
  Map? buttonLabel;
  DateTime? updatedAt;
  String? updatedBy;

  BlogModel copyWith({
    List<String>? picture,
    String? state,
    String? type,
    String? id,
    Map? title,
    Map? description,
    String? html,
    int? priority,
    int? section,
    String? author,
    String? category,
    String? link,
    String? branch,
    DateTime? createdAt,
    String? createdBy,
    int? v,
    Map? buttonLabel,
    DateTime? updatedAt,
    String? updatedBy,
  }) =>
      BlogModel(
        picture: picture ?? this.picture,
        state: state ?? this.state,
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        description: description ?? this.description,
        html: html ?? this.html,
        priority: priority ?? this.priority,
        section: section ?? this.section,
        author: author ?? this.author,
        category: category ?? this.category,
        link: link ?? this.link,
        branch: branch ?? this.branch,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        v: v ?? this.v,
        buttonLabel: buttonLabel ?? this.buttonLabel,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory BlogModel.fromJson(str) => BlogModel.fromMap(str);

  String toJson() => json.encode(toMap());

  factory BlogModel.fromMap(Map<String, dynamic> json) => BlogModel(
        picture: json["picture"] == null
            ? null
            : List<String>.from(
                json["picture"].map((x) => '${ConfigApp.apiUrl}/public/uploads/blog/' + x)),
        state: json["state"] == null ? null : json["state"],
        type: json["type"] == null ? null : json["type"],
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        html: json["html"] == null ? null : json["html"],
        priority: json["priority"] == null ? null : json["priority"],
        section: json["section"] == null ? null : json["section"],
        author: json["author"] == null ? null : json["author"],
        category: json["category"] == null ? null : json["category"],
        link: json["link"] == null ? null : json["link"],
        branch: json["branch"] == null ? null : json["branch"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        v: json["__v"] == null ? null : json["__v"],
        buttonLabel: json["buttonLabel"] == null || json["buttonLabel"] == ""
            ? null
            : json["buttonLabel"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
      );

  Map<String, dynamic> toMap() => {
        "picture":
            picture == null ? null : List<dynamic>.from(picture!.map((x) => x)),
        "state": state == null ? null : state,
        "type": type == null ? null : type,
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "html": html == null ? null : html,
        "priority": priority == null ? null : priority,
        "section": section == null ? null : section,
        "author": author == null ? null : author,
        "category": category == null ? null : category,
        "link": link == null ? null : link,
        "branch": branch == null ? null : branch,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "createdBy": createdBy == null ? null : createdBy,
        "__v": v == null ? null : v,
        "buttonLabel": buttonLabel == null ? null : buttonLabel,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "updatedBy": updatedBy == null ? null : updatedBy,
      };
}
