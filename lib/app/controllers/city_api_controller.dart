import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app/models/city_model.dart';
import '../../utils/config.dart';
import 'package:retry/retry.dart';
import '../../utils/extentions.dart';

final client = http.Client();

class CityApiController extends GetxController {
  var cities = <CityModel>[].obs;
  var isLoading = false.obs;
  void getCity() async {
    isLoading(true);
    cities.value = await compute(fetchCity, 'ok');
    isLoading(false);
  }
}

Future<List<CityModel>> fetchCity(String _) async {
  try {
    var response = await RetryOptions(maxAttempts: 5).retry(
      () => client
          .get(Uri.parse(
              '${ConfigApp.apiUrl}/v1/city/${ConfigApp.branchAccess}'))
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    if (response.statusCode == 200) {
      return json
          .decode(json.encode(json.decode(response.body)['cities']))
          .cast<Map<String, dynamic>>()
          .map<CityModel>((json) => CityModel.fromJson(json))
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
