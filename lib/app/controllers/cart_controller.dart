import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trancehouse/app/models/item_model.dart';

class CartController extends GetxController {
  List cart = [].obs;
  List cartId = [];
  final _getStorage = GetStorage();
  @override
  void onInit() async {
    cartId = [..._getStorage.read('cart') ?? []].toSet().toList();
    cartId.forEach((element) {
      cart.add(ItemModel.fromJson(_getStorage.read(element)));
    });
    update();
    super.onInit();
  }

  void saveCartList(ItemModel item) {
    _getStorage.write(item.id.toString(), item.toMap());
    _getStorage.write('cart', cartId.toSet().toList());
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
          'success.insert'.trParams({'type': 'feedback'.tr}),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
    update();
  }

  ItemModel getItemFromCart(ItemModel item) {
    return cart.firstWhere((element) => element.id == item.id,
        orElse: () => item);
  }
}
