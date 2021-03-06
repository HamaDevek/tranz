import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app/models/blog_model.dart';
import '../../app/models/service_api_model.dart';
import '../../app/models/service_model.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

final client = http.Client();

class ServiceApiController extends GetxController {
  var service = <ServiceModel>[].obs;
  var length = 0.obs;
  var blogs = <BlogModel>[].obs;
  var isLoading = false.obs;
  var isOnScreenBlogService = false.obs;
  var isLoadingBlog = false.obs;
  var isLoadingSend = false.obs;
  var isVertical = false.obs;
  @override
  void onInit() async {
    isLoading(true);
    service.value = await compute(fetchService, 'ok');
    isLoading(false);
    super.onInit();
  }

  void getBlogByService(String id) async {
    isLoadingBlog(true);
    blogs.value = (await compute(fetchBlogService, id))['data'];
    isLoadingBlog(false);
    update();
  }

  void changeVertical() {
    isVertical(!isVertical.value);
    update();
  }

  Future<bool> sendServiceReuqest(ServiceApiModel service) async {
    if (!isLoadingSend()) {
      isLoadingSend(true);
      bool isTrue = await compute(sendServiceThread, service);
      isLoadingSend(false);
      if (isTrue) {
        Get.offAllNamed('/main');
        Get.snackbar(
          'success'.tr,
          'success.insert'.trParams({'type': 'services'.tr}),
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
            'success.insert'.trParams({'type': 'services'.tr}),
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

  List<ServiceModel>? getParent() {
    return service.where((el) => el.parent == '/').toList();
  }

  List<ServiceModel>? getchiled(String id) {
    // print(service.where((el) => id == el.parent!.toString()).toList());
    return service.where((el) => id == el.parent!.toString()).toList();
  }
}

Future<List<ServiceModel>> fetchService(String _) async {
  try {
    var response = await const RetryOptions(maxAttempts: 5).retry(
      () => client
          .get(Uri.parse(
              '${ConfigApp.apiUrl}/v1/cms/category/${ConfigApp.branchAccess}'))
          .timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    if (response.statusCode == 200) {
      return json
          .decode(response.body)['categories']
          .map<ServiceModel>((json) => ServiceModel.fromJson(json))
          .toList();
    }
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

Future<bool> sendServiceThread(ServiceApiModel service) async {
  try {
    var response = await const RetryOptions(maxAttempts: 5).retry(
      () => client.post(
        Uri.parse('${ConfigApp.apiUrl}/v1/cms/form'),
        body: jsonEncode(service.toMap()),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
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

Future<Map<String, dynamic>> fetchBlogService(String id) async {
  // print("RUN BLOG SERVICE");

  try {
    var response = await const RetryOptions(maxAttempts: 5).retry(
      () => client.post(Uri.parse('${ConfigApp.apiUrl}/v1/cms/blog/section'),
          body: jsonEncode({
            'branch': ConfigApp.branchAccess,
            'query': {
              "category": id,
            },
          }),
          headers: <String, String>{
            'Content-Type': 'application/json',
          }).timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    if (response.statusCode == 200) {
      // print("RUN REQUEST");
      return {
        'total': json.decode(response.body)['total'],
        'data': json
            .decode(json.encode(json.decode(response.body)['sections']))
            .cast<Map<String, dynamic>>()
            .map<BlogModel>((json) => BlogModel.fromJson(json))
            .toList()
      };
    }
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
  return {'length': 0, 'data': []};
}
