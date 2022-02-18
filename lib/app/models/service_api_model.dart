import 'dart:convert';

class ServiceApiModel {
  ServiceApiModel({
    required this.name,
    required this.phone,
    required this.info,
    required this.message,
    required this.branch,
    required this.type,
    required this.subType,
    required this.address,
    required this.imei,
  });

  final String name;
  final String phone;
  final String subType;
  final Map info;
  final String message;
  final String branch;
  final String type;
  final String address;
  final String imei;

  Map<String, String> toMap() => {
        "name": name,
        "phone": phone,
        "info": jsonEncode(info),
        "message": message,
        "subType": subType,
        "branch": branch,
        "type": jsonEncode(type),
        "address": address,
        "imei": imei,
      };
}
