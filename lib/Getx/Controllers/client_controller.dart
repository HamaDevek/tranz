import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tranzhouse/Models/metadata_model.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Pages/Client/Cart/products_cart_page.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/prints.dart';

import '../../Api/api_endpoints.dart';
import '../../Models/product_model.dart';
import '../../Models/response_model.dart';
import '../../Utility/dio_plugin.dart';
import '../../Utility/endpoint.dart';

class ClientController extends GetxController {
  static ClientController get to =>
      Get.find<ClientController>(tag: 'client-controller');

  final cartItems = GetStorage();

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
      // prints("META DATA: ${res.data}", tag: 'success');
      metadata.value = MetaDataModel.fromJson(res.data['metadata']);
    } else {
      prints("META DATA: ${res.data}", tag: 'error');
    }
  }
  //ORDER PRODUCT
  //ORDER PRODUCT
  //ORDER PRODUCT

  Future<ResponseModel> orderProduct({
    required List<Map<String, dynamic>> pruduct,
  }) async {
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().client.orderProduct,
      ),
      headers: {
        'Accept': '*/*',
        "Content-Type": "application/json",
      },
      object: jsonEncode({
        "products": pruduct,
      }),
      method: RequestType.POST,
    );

    if (res.isSuccess) {
      prints("ORDER PRODUCT: ${res.data}", tag: 'success');
      Get.snackbar(
        "Success",
        "Order sent successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorPalette.green,
        colorText: ColorPalette.primary,
      );
    } else {
      prints("ORDER PRODUCT: ${res.data}", tag: 'error');
      Get.snackbar(
        "Error",
        res.data['error'].toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorPalette.red,
        colorText: ColorPalette.whiteColor,
      );
    }
    return res;
  }

  Future<ResponseModel> orderService({
    required List<Map<String, dynamic>> service,
  }) async {
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().client.orderService,
      ),
      headers: {
        'Accept': '*/*',
        "Content-Type": "application/json",
      },
      object: jsonEncode({
        "services": service,
      }),
      method: RequestType.POST,
    );

    if (res.isSuccess) {
      prints("ORDER SERVICE: ${res.data}", tag: 'success');
      Get.snackbar(
        "Success",
        "Order sent successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorPalette.green,
        colorText: ColorPalette.primary,
      );
    } else {
      prints("ORDER PRODUCT: ${res.data}", tag: 'error');
      Get.snackbar(
        "Error",
        res.data['error'].toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorPalette.red,
        colorText: ColorPalette.whiteColor,
      );
    }
    return res;
  }
  //////////////////////////
  ////////////////////
  // GET LOCAL CART PRODUCTS
  // GET LOCAL CART PRODUCTS
  // GET LOCAL CART PRODUCTS

  RxList<ProductModel> cartProducts = <ProductModel>[].obs;
  RxList<Service> cartServices = <Service>[].obs;

  // ADD PRODUCT TO CART
  void addItemToCart(
    dynamic item, {
    required CartType cartType,
  }) {
    if (cartType == CartType.product) {
      cartProducts.insert(0, item);
      saveItemsToLocalCart(cartType: CartType.product);
      getLocalCartItems(cartType: CartType.product);
    } else if (cartType == CartType.service) {
      cartServices.insert(0, item);
      saveItemsToLocalCart(cartType: CartType.service);
      getLocalCartItems(cartType: CartType.service);
    }
  }

  // REMOVE PRODUCT FROM CART
  void removeItemFromCart(
    int index, {
    required CartType cartType,
  }) {
    if (cartType == CartType.product) {
      cartProducts.removeAt(index);
      saveItemsToLocalCart(cartType: CartType.product);
    } else if (cartType == CartType.service) {
      cartServices.removeAt(index);
      saveItemsToLocalCart(cartType: CartType.service);
    }
  }

  void updateItemInCart(
    int index, {
    required CartType cartType,
    required dynamic item,
  }) {
    if (cartType == CartType.product) {
      cartProducts[index] = item;
      saveItemsToLocalCart(cartType: CartType.product);
    } else if (cartType == CartType.service) {
      cartServices[index] = item;
      saveItemsToLocalCart(cartType: CartType.service);
    }
  }

  void clearCart({
    required CartType cartType,
  }) {
    if (cartType == CartType.product) {
      cartProducts.clear();
      saveItemsToLocalCart(cartType: CartType.product);
      getLocalCartItems(cartType: CartType.product);
    } else if (cartType == CartType.service) {
      cartServices.clear();
      saveItemsToLocalCart(cartType: CartType.service);
      getLocalCartItems(cartType: CartType.service);
    }
  }

  ////////// SAVE PRODUCTS TO LOCAL CART
  Future<void> saveItemsToLocalCart({
    required CartType cartType,
  }) async {
    if (cartType == CartType.product) {
      await cartItems.write('products', cartProducts);
    } else if (cartType == CartType.service) {
      await cartItems.write('services', cartServices);
    }
  }

  //////////
  /////// GET PRODUCTS FROM LOCAL CART
  Future<void> getLocalCartItems({
    required CartType cartType,
  }) async {
    if (cartType == CartType.product) {
      List<ProductModel> products = [];
      var items = cartItems.read('products') ?? [];

      // print("ITEMS: $items");
      // print("ITEMS: ${items.runtimeType}");

      if (items.isNotEmpty) {
        for (var item in items) {
          print("LOCAL ITEM: ${item.runtimeType}");
          if (item != null) {
            if (item is Map<String, dynamic>) {
              products.add(ProductModel.fromJson(item));
            } else if (item is ProductModel) {
              products.add(item);
            }
            // products.add(ProductModel.fromJson(item));
          } else {
            print("ITEM IS NULL");
          }
        }
      }

      // print("PRODUCTS: ${products.length}");

      cartProducts.value = products;
    } else if (cartType == CartType.service) {
      List<Service> services = [];
      var items = cartItems.read('services') ?? [];
      if (items.isNotEmpty) {
        for (var item in items) {
          print("LOCAL ITEM: ${item.runtimeType}");
          if (item != null) {
            if (item is Map<String, dynamic>) {
              services.add(Service.fromJson(item));
            } else if (item is Service) {
              services.add(item);
            }
            // products.add(ProductModel.fromJson(item));
          } else {
            print("ITEM IS NULL");
          }
        }
      }

      // print("PRODUCTS: ${products.length}");

      cartServices.value = services;
    }
  }

  //////
  /////// CHECK IF PRODUCT IS IN CART
  bool isProductInCart(String productId) {
    bool isProductInCart = false;
    for (var product in cartProducts) {
      if (product.id == productId) {
        isProductInCart = true;
        break;
      }
    }
    return isProductInCart;
  }

  bool isServicenCart(String serviceId) {
    bool isServiceInCart = false;
    for (var service in cartServices) {
      if (service.id == serviceId) {
        isServiceInCart = true;
        break;
      }
    }
    return isServiceInCart;
  }
}
