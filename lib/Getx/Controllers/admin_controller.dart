import 'dart:convert';

import 'package:get/get.dart';
import 'package:tranzhouse/Api/api_endpoints.dart';
import 'package:tranzhouse/Models/admin_order_model.dart';
import 'package:tranzhouse/Models/response_model.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/constants.dart';
import 'package:tranzhouse/Utility/dio_plugin.dart';
import 'package:tranzhouse/Utility/endpoint.dart';
import 'package:tranzhouse/Utility/prints.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

class AdminController extends GetxController {
  static AdminController get to =>
      Get.find<AdminController>(tag: "admin-controller");
////////////////////////////// GET ALL ORDERS //////////////////////////////
  ///    This function is used to get all orders from the server.
  RxList<AdminOrderModel> allOrders = <AdminOrderModel>[].obs;
  RxBool isLoading = false.obs;
  Future<void> getAllOrders() async {
    isLoading.value = true;
    final res = await DioPlugin().requestWithDio(
      url: getUrl(key: ApiEndpoint().admin.allOrders),
    );
    if (res.isSuccess) {
      // prints("ALL ORDERS: ${res.data}", tag: "success");
      allOrders.value = (res.data['orders'] as List)
          .map<AdminOrderModel>((e) => AdminOrderModel.fromJson(e))
          .toList();
      quantities?.clear();
      getquantities();
      isLoading.value = false;
      print("RX ALL ORDERS: $allOrders");
    } else {
      prints("ALL ORDERS: ${res.data}", tag: "error");
    }
  }
  /////////////////////////
  ///FILTER ORDERS BY STATUS

  RxList<AdminOrderModel> filteredOrders = <AdminOrderModel>[].obs;
  void filterOrdersByStatus(String status) {
    if (status == "All") {
      filteredOrders.value = List.from(allOrders);
      filteredOrders.value = filteredOrders.reversed.toList();
    } else {
      filteredOrders.value = List.from(
        allOrders
            .where((element) =>
                element.status?.toLowerCase() == status.toLowerCase())
            .toList(),
      );
      // reverse filteredOrders list to show latest orders first
      filteredOrders.value = filteredOrders.reversed.toList();
    }
  }

  /////////////////////////
  ///GET QUANTITY OF ORDERS BY STATUS FOR ALL STATUSES
  ///This function is used to get the quantity of orders by status for all statuses.

  RxList<RxInt>? quantities = <RxInt>[].obs;

  void getquantities() {
    RxList<AdminOrderModel> tempList = <AdminOrderModel>[].obs;

    for (var i = 0; i < orderStatus.length; i++) {
      if (i == 0) {
        tempList.value = List.from(allOrders);
      } else {
        tempList.value = List.from(
          allOrders
              .where((element) =>
                  element.status?.toLowerCase() == orderStatus[i].toLowerCase())
              .toList(),
        );
      }

      quantities?.add(tempList.length.obs);
    }
  }

  /////////////////////////
  ///ADMIN ACCEPT OR REJECT ORDER
  ///This function is used to accept or reject order.

  Future<ResponseModel> acceptOrRejectOrder({
    required String orderId,
    required String status,
    required String note,
  }) async {
    final res = await DioPlugin().requestWithDio(
      url: getUrl(key: ApiEndpoint().admin.acceptDeclineOrder),
      headers: {
        'Accept': '*/*',
        "Content-Type": "application/json",
      },
      // data: mapToFormMap(
      //   {
      //     "orderId": orderId,
      //     "note": note,
      //     "status": status,
      //   },
      // ),
      object: jsonEncode(
        {
          "orderId": orderId,
          "note": note,
          "status": status,
        },
      ),
      method: RequestType.POST,
    );
    if (res.isSuccess) {
      prints("ACCEPT OR REJECT ORDER: ${res.data}", tag: "success");
      getAllOrders();
      Get.showSnackbar(
        const GetSnackBar(
          titleText: TextWidget("Success"),
          messageText: TextWidget("Order updated successfully!"),
          backgroundColor: ColorPalette.green,
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3),
          borderRadius: 10,
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          titleText: TextWidget("Error"),
          messageText: TextWidget("Something went wrong!"),
          backgroundColor: ColorPalette.red,
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING,
          borderRadius: 10,
          duration: Duration(seconds: 3),
        ),
      );

      prints("ACCEPT OR REJECT ORDER: ${res.data}", tag: "error");
    }
    return res;
  }
}
