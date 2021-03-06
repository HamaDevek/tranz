import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import '../models/feedback_api_model.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

final client = http.Client();

class CmsApiController extends GetxController {
  var isLoading = false.obs;
  Future<bool> sendFeedback(FeedbackApiModel feedback) async {
    if (!isLoading()) {
      isLoading(true);
      bool isTrue = await compute(sendFeedbackThread, feedback);
      isLoading(false);
      if (isTrue) {
        Get.snackbar(
          'success'.tr,
          'success.insert'.trParams({'type': 'feedback'.tr}),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green.withOpacity(.6),
          titleText: Text(
            'success'.tr,
            style: const TextStyle(
              fontSize: 24,
            ),
            // textAlign:
          ),
          messageText: Text(
            'success.insert'.trParams({'type': 'feedback'.tr}),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        );
        return isTrue;
      }
      return isTrue;
    }
    return false;
  }
}

Future<bool> sendFeedbackThread(FeedbackApiModel feedback) async {
  try {
    var response = await const RetryOptions(maxAttempts: 5).retry(
      () => client.post(
        Uri.parse('${ConfigApp.apiUrl}/v1/cms/form'),
        body: feedback.toMap(),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      ).timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    return response.statusCode == 201;
  } catch (e) {
    Get.snackbar(
      'error'.tr,
      'error.fetch'.tr,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red.withOpacity(.6),
      titleText: Text(
        'error'.tr,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
        ),
      ),
      messageText: Text(
        'error.fetch'.tr,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
    return false;
  }
}
