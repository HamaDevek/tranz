import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trancehouse/app/models/cart_api_model.dart';
import 'package:trancehouse/utils/config.dart';
import '../../app/models/item_model.dart';
import '../../utils/extentions.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

final client = http.Client();

class CartController extends GetxController {
  List cart = [].obs;
  RxDouble total = (0.0).obs;
  RxInt fee = 0.obs;
  List cartId = [];
  var isLoading = false.obs;

  final _getStorage = GetStorage();
  @override
  void onInit() async {
    super.onInit();
    cartId = [...(_getStorage.read('cart') ?? [])].toSet().toList();
    cartId.forEach((element) {
      cart.add(ItemModel.fromJson(_getStorage.read(element)));
    });
    update();
  }

  void saveCartList(ItemModel item) {
    _getStorage.write(item.id.toString(), item.toMap());
    _getStorage.write('cart', cartId.toSet().toList());
  }

  void deleteCartList(ItemModel item) {
    total(total.value - (item.amount! * item.sellingPrice!));
    cartId.removeWhere((element) => element == item.id);
    cart.removeWhere((element) => element.id == item.id);
    _getStorage.remove((item.id.toString()));
    _getStorage.write('cart', cartId.toSet().toList());
    update();
  }

  void deleteAllCartList() {
    cartId.forEach((item) {
      _getStorage.remove(item);
    });
    cartId.clear();
    cart.clear();
    _getStorage.write('cart', cartId.toSet().toList());
    update();
  }

  void incrementAmount(ItemModel item) {
    total(total.value + item.sellingPrice!);
    cart.firstWhere((element) => element.id == item.id).amount =
        cart.firstWhere((element) => element.id == item.id).amount + 1;
    update();
  }

  void decrementAmount(ItemModel item) {
    if (cart.firstWhere((element) => element.id == item.id).amount > 1) {
      total(total.value - item.sellingPrice!);
      cart.firstWhere((element) => element.id == item.id).amount =
          cart.firstWhere((element) => element.id == item.id).amount - 1;
    }
    update();
  }

  void addItem(ItemModel item, int amount) {
    ItemModel temp =
        cart.firstWhere((element) => element.id == item.id, orElse: () {
      cart.add(item);
      cartId.add(item.id);
      return item;
    });
    temp.amount = amount;
    saveCartList(temp);
    Get.snackbar(
      'success'.tr,
      'success.insert'.trParams({'type': 'cart.added'.tr}),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.green.withOpacity(.6),
      titleText: Container(
        child: Text(
          'success'.tr,
          style: TextStyle(
            fontSize: 24,
          ),
          // textAlign:
        ),
      ),
      messageText: Container(
        child: Text(
          'success.insert'.trParams({'type': 'cart.added'.tr}),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
    update();
  }

  Future<bool> sendOrderRequest(CartApiModel cart) async {
    if (!isLoading()) {
      isLoading(true);
      bool isTrue = await compute(sendCartThread, cart);
      isLoading(false);
      if (isTrue) {
        Get.snackbar(
          'success'.tr,
          'success.insert'.trParams({'type': 'order'.tr}),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green.withOpacity(.6),
          titleText: Container(
            child: Text(
              'success'.tr,
              style: TextStyle(
                fontSize: 24,
              ),
              // textAlign:
            ),
          ),
          messageText: Container(
            child: Text(
              'success.insert'.trParams({'type': 'order'.tr}),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        );
        await Future.delayed(const Duration(seconds: 3));
        Get.offAllNamed('/main');
        return isTrue;
      }
      return isTrue;
    }
    return false;
  }

  ItemModel getItemFromCart(ItemModel item) {
    return cart.firstWhere((element) => element.id == item.id,
        orElse: () => item);
  }

  void getCartInfo() {
    total(0);
    cart.forEach((element) {
      total(total.value + (element.sellingPrice * element.amount));
    });
    update();
  }
}

Future<bool> sendCartThread(CartApiModel service) async {
  try {
    var response = await RetryOptions(maxAttempts: 5).retry(
      () => client.post(
        Uri.parse('${ConfigApp.apiUrl}/v1/invoice/createorder'),
        body: service.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    return response.statusCode == 200;
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
        ),
      ),
      messageText: Container(
        child: Text(
          'error.fetch'.tr,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
    return false;
  }
}
