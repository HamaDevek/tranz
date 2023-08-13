import 'package:get/get.dart';
import 'package:tranzhouse/Models/product_model.dart';

import '../../Api/api_endpoints.dart';
import '../../Models/response_model.dart';
import '../../Utility/dio_plugin.dart';
import '../../Utility/endpoint.dart';
import '../../Utility/prints.dart';

class ProductsController extends GetxController {
  static ProductsController get to =>
      Get.find<ProductsController>(tag: "products-controller");

  @override
  void onInit() {
    super.onInit();
    getProductCategories();
  }

  /////GET PRODUCTS//////
  ///
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool productsLoading = false.obs;

  Future<void> fetchProducts() async {
    if (products.isEmpty) {
      productsLoading.value = true;
    }
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().client.products,
      ),
    );

    if (res.isSuccess) {
      products.addAll(
        (res.data['products'] as List)
            .map<ProductModel>(
              (product) => ProductModel.fromJson(product),
            )
            .toList(),
      );
      prints(products, tag: "success");
      productsLoading.value = false;
    } else {
      prints(res.data, tag: "error");
      productsLoading.value = false;
    }
  }
  /////////////////////////////////
  ///FILTER PRODUCTS BY CATEGORY///

  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  void filterProductsByCategory(String categoryId) {
    if (categoryId == "0") {
      filteredProducts.value = List.from(products);
    } else {
      filteredProducts.clear();
      for (var product in products) {
        if (product.category?.id == categoryId) {
          filteredProducts.add(product);
        }
      }
      // filteredProducts.value = List.from(products
      //     .where(
      //       (product) => product.category?.id == categoryId,
      //     )
      //     .toList());
    }
  }

  /////GET PRODUCTS CATEGORIES//////
  ///
  RxList<ProductCategory> productsCategories = <ProductCategory>[].obs;

  Future<void> getProductCategories() async {
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().client.productCategories,
      ),
    );

    if (res.isSuccess) {
      productsCategories.value = (res.data['prCategories'] as List)
          .map<ProductCategory>(
            (category) => ProductCategory.fromJson(category),
          )
          .toList();
      productsCategories.insert(
          0,
          ProductCategory(
            id: "0",
            nameEn: "All",
            nameAr: "الكل",
            nameKu: "هەموو",
            updatedAt: DateTime.now(),
            v: 0,
          ));

      prints(productsCategories, tag: "success");
    } else {
      prints(res.data, tag: "error");
    }
  }
}
