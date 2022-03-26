import 'package:meta/meta.dart';
import 'dart:convert';

class CityModel {
  CityModel({
    @required this.id,
    @required this.name,
    @required this.deliveryPrice,
  });

  final String? id;
  final String? name;
  final int? deliveryPrice;

  factory CityModel.fromJson(str) => CityModel.fromMap(str);

  String toJson() => json.encode(toMap());

  factory CityModel.fromMap(Map<String, dynamic> json) => CityModel(
        id: json["_id"],
        name: json["name"],
        deliveryPrice:
            json["deliveryPrice"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "deliveryPrice": deliveryPrice ?? 0,
      };
}
