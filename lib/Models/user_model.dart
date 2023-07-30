// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  String? message;
  String? token;
  User? user;

  UserModel({
    this.message,
    this.token,
    this.user,
  });

  UserModel copyWith({
    String? message,
    String? token,
    User? user,
  }) =>
      UserModel(
        message: message ?? this.message,
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? name;
  String? phone;
  String? image;
  String? address;
  bool? isVerified;

  int? v;

  User({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.address,
    this.isVerified,
    this.v,
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
        image: json["image"],
        address: json["address"],
        isVerified: json["isVerified"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "image": image,
        "address": address,
        "isVerified": isVerified,
        "__v": v,
      };
}
