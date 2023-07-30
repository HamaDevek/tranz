import 'dart:convert';

import 'package:get/get.dart';
import 'package:tranzhouse/Models/metadata_model.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/prints.dart';

import '../../Api/api_endpoints.dart';
import '../../Models/response_model.dart';
import '../../Utility/dio_plugin.dart';
import '../../Utility/endpoint.dart';

class ClientController extends GetxController {
  static ClientController get to =>
      Get.find<ClientController>(tag: 'client-controller');

  Future<ResponseModel> feedBack({
    required String title,
    required String description,
    required String email,
  }) async {
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().client.feedback,
      ),
      headers: {
        'Accept': '*/*',
        "Content-Type": "application/json",
      },
      object: jsonEncode(
        {
          "title": title,
          "description": description,
          "email": email,
        },
      ),
      method: RequestType.POST,
    );

    if (res.isSuccess) {
      prints("FEEDBACK: ${res.data}", tag: 'success');
      Get.snackbar(
        "Success",
        "Feedback sent successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorPalette.green,
        colorText: ColorPalette.primary,
      );
    } else {
      prints("FEEDBACK: ${res.data}", tag: 'error');
      Get.snackbar(
        "Error",
        res.data['message'].toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorPalette.red,
        colorText: ColorPalette.whiteColor,
      );
    }
    return res;
  }

// GET META DATA
// GET META DATA
// GET META DATA
  Rx<MetaDataModel> metadata = MetaDataModel().obs;
  Future<void> metaData() async {
    final res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().client.metadata,
      ),
      // headers: {
      //   'Accept': '*/*',
      //   "Content-Type": "application/json",
      // },
      method: RequestType.GET,
    );

    if (res.isSuccess) {
      prints("META DATA: ${res.data}", tag: 'success');
      metadata.value = MetaDataModel.fromJson(res.data['metadata']);
    } else {
      prints("META DATA: ${res.data}", tag: 'error');
    }
  }
}
