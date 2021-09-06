import 'dart:convert';

import '../../app/models/city_model.dart';

class ShopModel {
  ShopModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.branch,
    required this.info,
  });

  final String name;
  final String phone;
  final String address;
  final CityModel city;
  final String branch;
  final Map info;

  Map<String, String> toMap() => {
        "name": name,
        "phone": phone,
        "address": address,
        "city": city.toJson(),
        "branch": branch,
        "info": jsonEncode(info),
      };
}
