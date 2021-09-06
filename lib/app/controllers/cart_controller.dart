import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/models/item_model.dart';

class CartController extends GetxController {
  List cart = [].obs;
  RxDouble total = (0.0).obs;
  RxInt fee = 0.obs;
  List cartId = [];
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
