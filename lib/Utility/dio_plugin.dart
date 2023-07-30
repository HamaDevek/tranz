import 'package:dio/dio.dart' as dios;
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tranzhouse/Utility/prints.dart';

import '../Getx/Controllers/user_controller.dart';
import '../Models/response_model.dart';
import '../Models/user_model.dart';
import '../Provider/network_provider.dart';

dios.FormData mapToFormMap(Map<String, dynamic> map) {
  dios.FormData formData = dios.FormData.fromMap(map);
  return formData;
}

// ignore: constant_identifier_names
enum RequestType { GET, POST }

class DioPlugin {
  final NetworkProviderController _networkController =
      NetworkProviderController.to;
  final authStorage = GetStorage();

  Future<ResponseModel> requestWithDio({
    required Uri url,
    Map<String, String>? headers,
    Map<String, dynamic>? param,
    dios.FormData? data,
    Object? object,
    String? scope,
    RequestType? method = RequestType.GET,
  }) async {
    final headers0 = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'x-lang': 'x-lang'.tr,
      'A': 'a',
      ...headers ?? {},
    };
    if (dotenv.env['USER_TOKEN'] != null) {
      headers0['Authorization'] = 'Bearer ${dotenv.env['USER_TOKEN']}';
    }
    if (UserController.to.user?.value.token != null) {
      headers0['Authorization'] =
          'Bearer ${UserController.to.user?.value.token}';
    }
    if (_networkController.connectionType.value == 0) {
      // sprints('Connection lost', tag: 'error');
    }
    final dio = dios.Dio();
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: (message) => prints(message, tag: 'error'),
      retries: 3,
      retryDelays: const [
        Duration(milliseconds: 1000),
        Duration(milliseconds: 3000),
        Duration(milliseconds: 5000),
      ],
    ));
    // dio.interceptors.add(dios.LogInterceptor());
    prints(url.toString(), tag: 'api');
    int total = 0;
    int received = 0;
    try {
      if (method == RequestType.GET) {
        final res = await dio.get(
          url.toString(),
          queryParameters: {
            ...param ?? {},
          },
          options: dios.Options(
            followRedirects: false,
            headers: headers0,
          ),
          onReceiveProgress: (receivedServer, totalServer) {
            total = totalServer;
            received = receivedServer;
          },
        );
        return ResponseModel(
          message: res.statusMessage,
          responseCode: res.statusCode,
          data: res.data,
          isSuccess: true,
          received: received,
          total: total,
        );
      } else if (method == RequestType.POST) {
        final res = await dio.post(
          url.toString(),
          queryParameters: {
            ...param ?? {},
          },
          options: dios.Options(
            followRedirects: false,
            headers: headers0,
          ),
          onReceiveProgress: (receivedServer, totalServer) {
            total = totalServer;
            received = receivedServer;
          },
          data: object ?? data ?? {},
        );

        return ResponseModel(
          message: res.statusMessage,
          responseCode: res.statusCode,
          data: res.data,
          isSuccess: true,
          received: received,
          total: total,
        );
      } else {
        return ResponseModel(
          message: "UNSUPPORTED METHOD :$method",
          isSuccess: false,
        );
      }
    } on dios.DioError catch (e) {
      String? message;
      switch (e.response?.statusCode) {
        case 423:
          message = 'error.blocked'.tr;
          break;
        case 401:
          await authStorage.remove('auth');
          UserController.to.user!(UserModel());
          message = 'error.unauthorized'.tr;
          break;
        case 403:
          await authStorage.remove('auth');
          UserController.to.user!(UserModel());
          message = 'error.unauthorized'.tr;
          break;
      }
      // prints(
      //     "Message:${e.response?.statusMessage}\nCode:${e.response?.statusCode}\nData:${e.response?.data}",
      //     tag: 'error');

      return ResponseModel(
        message: e.response?.statusCode == null
            ? 'error.connection.lost'.tr
            : (message ?? e.response?.statusMessage),
        responseCode: e.response?.statusCode ?? 0,
        data: e.response?.data ?? {},
        isSuccess: false,
        received: received,
        total: total,
      );
    }
  }
}
