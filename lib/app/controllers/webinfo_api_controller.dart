import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trancehouse/utils/config.dart';
import 'package:retry/retry.dart';
import 'package:trancehouse/utils/extentions.dart';

class WebinfoApiController extends GetxController {
  static final client = http.Client();
  RxMap webInfo = {}.obs;

  Future<Map<String, dynamic>> fetchWebinfo() async {
    try {
      var response = await RetryOptions(maxAttempts: 5).retry(
        () => client
            .get(Uri.parse('${ConfigApp.apiUrl}/v1/cms/webinfo'))
            .timeout(Duration(seconds: 5)),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      if (response.statusCode == 200) {
        webInfo(json.decode(response.body)['data']);
        return json.decode(response.body)['data'];
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
    return {};
  }
}
