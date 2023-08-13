// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:tranzhouse/Enum/enums.dart';

class UserModel {
  String? message;
  String? token;
  User? user;
  UserType? userType;

  UserModel({
    this.message,
    this.token,
    this.user,
    this.userType,
  });

  UserModel copyWith({
    String? message,
    String? token,
    User? user,
  UserType? userType,


  }) =>
      UserModel(
        message: message ?? this.message,
        token: token ?? this.token,
        user: user ?? this.user,
        userType: userType ?? this.userType,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user?.toJson(),
        "userType": userType?.toString(),
      };
}

class User {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? address;
  bool? isVerified;
  bool?employee;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? ownership;
  List<dynamic>? permissions;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.address,
    this.isVerified,
    this.employee,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.ownership,
    this.permissions,
  });

  User copyWith({
    String? id,
    String? name,
    String? phone,
    String? image,
    String? address,
    bool? isVerified,
    int? v,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        address: address ?? this.address,
        isVerified: isVerified ?? this.isVerified,
        v: v ?? this.v,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        image: json["picture"],
        address: json["address"],
        isVerified: json["isVerified"],
        employee: json["employee"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        ownership: json["ownership"] == null? null: List<String>.from(json["ownership"].map((x) => x)),
        permissions: json["permissions"] == null? null: List<dynamic>.from(json["permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "image": image,
        "address": address,
        "isVerified": isVerified,
        "employee": employee,
        "__v": v,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "ownership": ownership == null? null: List<dynamic>.from(ownership!.map((x) => x)),
        "permissions": permissions == null? null: List<dynamic>.from(permissions!.map((x) => x)),

      };
}
