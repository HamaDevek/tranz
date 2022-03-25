import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import '../../app/models/item_model.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

final client = http.Client();

class ItemApiController extends GetxController {
  var isLoading = false.obs;
  var items = <ItemModel>[].obs;

  @override
  void onInit() async {
    if (!isLoading()) {
      // print("RUN FIRST");
      isLoading(true);
      items.value = await compute(fetchItem, '');
      isLoading(false);
    }
    update();
    super.onInit();
  }
}

Future<List<ItemModel>> fetchItem(String _) async {
  try {
    var response = await RetryOptions(maxAttempts: 5).retry(
      () => client
          .get(Uri.parse(
              '${ConfigApp.apiUrl}/v1/item/listpublic/${ConfigApp.branchAccess}'))
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    if (response.statusCode == 200) {
      // print("RUN REQUEST");
      return json
          .decode(json.encode(json.decode(response.body)['items']))
          .cast<Map<String, dynamic>>()
          .map<ItemModel>((json) => ItemModel.fromJson(json))
          .toList();
    }
  } catch (e) {
    Get.snackbar(
      'error'.tr,
      'error.fetch'.tr,
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red.withOpacity(.6),
      titleText: Container(
        child: Text(
          'error'.tr,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
          ),
          textAlign:
              'language.rtl'.tr.parseBool ? TextAlign.right : TextAlign.left,
        ),
      ),
      messageText: Container(
        child: Text(
          'error.fetch'.tr,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
          ),
          textAlign:
              'language.rtl'.tr.parseBool ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }
  return [];
}

Future<List<ItemModel>> convertToModel(String json) async {
  return jsonDecode(jsonEncode(jsonDecode(json)['items']))
      .cast<Map<String, dynamic>>()
      .map<ItemModel>((json) => ItemModel.fromJson(json))
      .toList();
}
