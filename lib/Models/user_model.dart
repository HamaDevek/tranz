import 'dart:convert';

import '../Enum/enums.dart';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.user,
    this.token,
    this.userType,
  });

  User? user;
  final String? token;
  String? userType;

  UserModel copyWith({
    User? user,
    String? token,
  }) =>
      UserModel(
        user: user ?? this.user,
        token: token ?? token,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: json["driver"] != null
            ? User.fromJson(json["driver"])
            : json["client"] != null
                ? User.fromJson(json["client"])
                : json["user"] != null
                    ? User.fromJson(json["user"])
                    : null,
        token: json["token"],
        userType: json["driver"] != null
            ? UserType.driver.toString()
            : json["client"] != null
                ? UserType.client.toString()
                : json["user"] != null
                    ? json["userType"]
                    : null,
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
        "userType": userType,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.description,
    this.image,
    this.userName,
    this.userPhone,
    this.balance,
    this.location,
    this.branch,
  });

  int? id;
  String? name;
  dynamic description;
  String? image;
  String? userName;
  int? userPhone;
  int? balance;
  Location? location;
  Branch? branch;

  User copyWith({
    int? id,
    String? name,
    dynamic description,
    String? image,
    String? userName,
    int? userPhone,
    int? balance,
    Location? location,
    Branch? branch,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        userName: userName ?? this.userName,
        userPhone: userPhone ?? this.userPhone,
        balance: balance ?? this.balance,
        location: location ?? this.location,
        branch: branch ?? this.branch,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        userName: json["user_name"] is String
            ? json["user_name"]
            : json["user_name"].toString(),
        userPhone: json["user_phone"],
        balance: json["balance"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "user_name": userName,
        "user_phone": userPhone,
        "balance": balance,
        "location": location?.toJson(),
        "branch": branch?.toJson(),
      };
}

class Branch {
  Branch({
    this.id,
    this.description,
    this.name,
    this.location,
  });

  int? id;
  dynamic description;
  String? name;
  Location? location;

  Branch copyWith({
    int? id,
    dynamic description,
    String? name,
    Location? location,
  }) =>
      Branch(
        id: id ?? this.id,
        description: description ?? this.description,
        name: name ?? this.name,
        location: location ?? this.location,
      );

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        description: json["description"],
        name: json["name"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "name": name,
        "location": location?.toJson(),
      };
}

class Location {
  Location({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  Location copyWith({
    int? id,
    String? name,
  }) =>
      Location(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
