import 'dart:convert';

class CartApiModel {
  CartApiModel({
    required this.name,
    required this.phone,
    required this.info,
    required this.message,
    required this.branch,
    required this.type,
  });

  final String name;
  final String phone;
  final Map info;
  final String message;
  final String branch;
  final String type;

  Map<String, String> toMap() => {
        "name": name,
        "phone": phone,
        "info": jsonEncode(info),
        "message": message,
        "branch": branch,
        "type": jsonEncode(type),
      };
}
