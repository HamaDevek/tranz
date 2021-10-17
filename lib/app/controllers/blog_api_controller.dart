import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app/models/blog_model.dart';
import '../../utils/config.dart';
import 'package:retry/retry.dart';
import '../../utils/extentions.dart';

final client = http.Client();

class BlogApiController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var length = 0.obs;
  var blogs = <BlogModel>[].obs;

  @override
  void onInit() async {
    if (!isLoading()) {
      isLoading(true);
      var tempVar = await compute(fetchBlog, {'from': 0, 'to': 10});
      blogs.value = tempVar['data'];
      length(tempVar['total']);
      isLoading(false);
    }
    super.onInit();
  }

  Future<void> getMore(int from, int to) async {
    isLoadingMore(true);
    var tempList = await compute(fetchBlog, {'from': from, 'to': to});
    blogs.value = [...tempList['data']];
    isLoadingMore(false);
  }
}

Future<Map<String, dynamic>> fetchBlog(Map limit) async {
  print("RUN BLOG");
  try {
    var request = http.Request(
        'POST', Uri.parse('${ConfigApp.apiUrl}/v1/cms/blog/section'));
    request.body = json.encode({
      "branch": ConfigApp.branchAccess,
      'skip': '${limit['form']}',
      'docsLimit': '${limit['to']}',
      "query": {"section": "blog"}
    });
    request.headers.addAll(
        {'Accept': 'application/json', 'Content-Type': 'application/json'});

    http.StreamedResponse responseStream =
        await RetryOptions(maxAttempts: 5).retry(
      () => request.send().timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (responseStream.statusCode == 200) {
      var response = await responseStream.stream.bytesToString();
      print("RUN REQUEST");
      return {
        'total': json.decode(response)['total'],
        'data': json
            .decode(json.encode(json.decode(response)['sections']))
            .cast<Map<String, dynamic>>()
            .map<BlogModel>((json) => BlogModel.fromJson(json))
            .toList()
      };
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
  return {'length': 0, 'data': []};
}

Future<List<BlogModel>> convertToModel(String json) async {
  return jsonDecode(jsonEncode(jsonDecode(json)['sections']))
      .cast<Map<String, dynamic>>()
      .map<BlogModel>((json) => BlogModel.fromJson(json))
      .toList();
}
