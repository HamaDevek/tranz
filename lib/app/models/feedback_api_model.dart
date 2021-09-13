import 'dart:convert';

class FeedbackApiModel {
  FeedbackApiModel({
    required this.name,
    required this.phone,
    required this.info,
    required this.message,
    required this.branch,
    required this.type,
    required this.imei,
  });

  final String name;
  final String phone;
  final Map info;
  final String message;
  final String branch;
  final String type;
  final String imei;

  Map<String, String> toMap() => {
        "name": name,
        "phone": phone,
        "info": jsonEncode(info),
        "message": message,
        "branch": branch,
        "type": jsonEncode(type),
        "imei": imei,
      };
}
