import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import '../../app/models/category_model.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

final client = http.Client();

class CategoryApiController extends GetxController {
  var category = <CategoryModel>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() async {
    isLoading(true);
    category.value = await compute(fetchCategory, 'ok');
    isLoading(false);
    super.onInit();
  }
}

Future<List<CategoryModel>> fetchCategory(String _) async {
  try {
    var response = await const RetryOptions(maxAttempts: 5).retry(
      () => client
          .get(Uri.parse('${ConfigApp.apiUrl}/v1/item/category'))
          .timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    // print(response.body);
    if (response.statusCode == 200) {
      return json
          .decode(response.body)['categories']
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    }
  } catch (e) {
    Get.snackbar(
      'error'.tr,
      'error.fetch'.tr,
      duration:const Duration(seconds: 5),
      backgroundColor: Colors.red.withOpacity(.6),
      titleText: Text(
        'error'.tr,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
        ),
        textAlign:
            'language.rtl'.tr.parseBool ? TextAlign.right : TextAlign.left,
      ),
      messageText: Text(
        'error.fetch'.tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
        ),
        textAlign:
            'language.rtl'.tr.parseBool ? TextAlign.right : TextAlign.left,
      ),
    );
  }
  return [];
}
// Future<List<BlogModel>> convertToModel(String json) async {
//   return jsonDecode(jsonEncode(jsonDecode(json)['sections']))
//       .cast<Map<String, dynamic>>()
//       .map<BlogModel>((json) => BlogModel.fromJson(json))
//       .toList();
// }

