import 'dart:convert';
import 'package:trancehouse/app/models/blog_model.dart';


Future<List<BlogModel>> convertToModel(String json) async {
  return jsonDecode(jsonEncode(jsonDecode(json)['sections']))
      .cast<Map<String, dynamic>>()
      .map<BlogModel>((json) => BlogModel.fromJson(json))
      .toList();
}
