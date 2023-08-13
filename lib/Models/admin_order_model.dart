// To parse this JSON data, do
//
//     final adminOrderModel = adminOrderModelFromJson(jsonString);

import 'dart:convert';

import 'services_model.dart';

class AdminOrderModel {
  String? id;
  Service? service;
  Owner? owner;
  String? status;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AdminOrderModel({
    this.id,
    this.service,
    this.owner,
    this.status,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  AdminOrderModel copyWith({
    String? id,
    Service? service,
    Owner? owner,
    String? status,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      AdminOrderModel(
        id: id ?? this.id,
        service: service ?? this.service,
        owner: owner ?? this.owner,
        status: status ?? this.status,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory AdminOrderModel.fromRawJson(String str) =>
      AdminOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminOrderModel.fromJson(Map<String, dynamic> json) =>
      AdminOrderModel(
        id: json["_id"],
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        status: json["status"],
        note: json["note"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "service": service?.toJson(),
        "owner": owner?.toJson(),
        "status": status,
        "note": note,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Owner {
  String? id;
  String? name;
  String? phone;
  bool? isVerified;
  int? v;
  String? address;
  String? picture;
  DateTime? updatedAt;

  Owner({
    this.id,
    this.name,
    this.phone,
    this.isVerified,
    this.v,
    this.address,
    this.picture,
    this.updatedAt,
  });

  Owner copyWith({
    String? id,
    String? name,
    String? phone,
    bool? isVerified,
    int? v,
    String? address,
    String? picture,
    DateTime? updatedAt,
  }) =>
      Owner(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        isVerified: isVerified ?? this.isVerified,
        v: v ?? this.v,
        address: address ?? this.address,
        picture: picture ?? this.picture,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        isVerified: json["isVerified"],
        v: json["__v"],
        address: json["address"],
        picture: json["picture"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "isVerified": isVerified,
        "__v": v,
        "address": address,
        "picture": picture,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}


