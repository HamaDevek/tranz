import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tranzhouse/Getx/Controllers/product_controller.dart';
import 'package:tranzhouse/Pages/Client/Cart/products_cart_page.dart';
import 'package:tranzhouse/Pages/Client/Products/tabbar_widget.dart';
import 'package:tranzhouse/Utility/constants.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

import '../../../Getx/Controllers/client_controller.dart';
import '../../../Models/product_model.dart';
import '../../../Models/services_model.dart';
import '../../../Theme/theme.dart';
import '../../../Widgets/Containers/image_grid_card_widget.dart';
import '../../../Widgets/Other/app_spacer.dart';
import 'single_productPage.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ProductsController.to.products.clear();
      await ProductsController.to.fetchProducts();
      ClientController.to.getLocalCartItems(cartType: CartType.product);
      ProductsController.to.filterProductsByCategory(
        "0",
      );
    });
  }

  void refreshPage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ProductsController.to.products.clear();
      await ProductsController.to.fetchProducts();
      // ProductsController.to.getProductCategories();
      ClientController.to.getLocalCartItems(cartType: CartType.product);
      ProductsController.to.filterProductsByCategory(
        ProductsController.to.productsCategories[selectedIndex].id ?? "0",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        refreshPage();
      },
      edgeOffset: 100,
      // backgroundColor: ColorPalette.whiteColor,
      // color: ColorPalette.primary,
      strokeWidth: 2,
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacer.appBarHeight(),
            const ProductsTopWidget(),
            AppSpacer.p20(),
            if (ProductsController.to.productsCategories.isNotEmpty)
              TabbarWidget(
                tabTitles: ProductsController.to.productsCategories.mapIndexed(
                  (index, element) => getTitles(element),
                ),
                // tabTitles:
                //     ProductsController.to.productsCategories.asMap().entries.map((e) {
                //   print(e.key);
                //   return getTitles(e.value);
                // }).toList(),
                onTabChanged: (index) {
                  selectedIndex = index;
                  ProductsController.to.filterProductsByCategory(
                    ProductsController.to.productsCategories[index].id!,
                  );
                },
              ),
            AppSpacer.p20(),
            Expanded(
              child: GridsWidget(
                selectedIndex: selectedIndex,
              ),
            ),
          ],
        );
      }),
    ));
  }

  String getTitles(ProductCategory category) {
    final String lang = "x-lang".tr;
    switch (lang) {
      case "ku":
        return category.nameKu.toString();
      case "ar":
        return category.nameAr.toString();
      case "en":
        return category.nameEn.toString();
      default:
        return category.nameKu.toString();
    }
  }
}

class GridsWidget extends StatelessWidget {
  const GridsWidget({
    super.key,
    required this.selectedIndex,
  });
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // if (ProductsController.to.productsLoading.value) {
        //   return const SizedBox.shrink();
        // }

        return Skeletonizer(
          enabled: ProductsController.to.productsLoading.value,
          // enabled: true,
          effect: ShimmerEffect.raw(
            colors: [
              ColorPalette.primary.withOpacity(1),
              ColorPalette.greyText,
              ColorPalette.whiteColor,
            ],
          ),

          child: ProductsController.to.productsLoading.value
              ? const ProductsLoadingWidget()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding:
                      const EdgeInsets.only(bottom: 100, left: 16, right: 16),
                  itemCount: ProductsController.to.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product =
                        ProductsController.to.filteredProducts[index];

                    return ImageGridCardWidget(
                      imageUrl:
                          product.images?[0] ?? "",
                      price: product.price ?? 0,
                      title: getTitles(product.title ??
                          LanguagesModel(en: "", ar: "", ku: "")),
                      category: getTitlesProduct(
                          product.category ?? ProductCategory()),
                      onTap: () {
                        Get.toNamed(
                          SingleProductPage.routeName,
                          arguments: product,
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }

  String getTitles(LanguagesModel name) {
    final String lang = "x-lang".tr;
    switch (lang) {
      case "ku":
        return name.ku.toString();
      case "ar":
        return name.ar.toString();
      case "en":
        return name.en.toString();
      default:
        return name.ku.toString();
    }
  }
}

class ProductsTopWidget extends StatelessWidget {
  const ProductsTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          TextWidget(
            "Products",
            style: TextWidget.textStyleCurrent.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorPalette.whiteColor,
                foregroundColor: ColorPalette.primary,
                shape: const CircleBorder(),
                minimumSize: const Size(35, 35),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                Get.toNamed(ProductsCartPage.routeName);
              },
              child: SvgPicture.asset("assets/icons/cart.svg")),
          // AppSpacer.p8(),
        ],
      ),
    );
  }
}

class ProductsLoadingWidget extends StatelessWidget {
  const ProductsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
      itemCount: fakeProducts.length,
      itemBuilder: (context, index) {
        final product = fakeProducts[index];

        return ImageGridCardWidget(
          imageUrl: product.images?[0] ?? "https://picsum.photos/400/200",
          price: product.price ?? 0,
          title:
              getText(product.title ?? LanguagesModel(en: "", ar: "", ku: "")),
          category: getTitlesProduct(product.category ?? ProductCategory()),
          onTap: () {
            Get.toNamed(
              SingleProductPage.routeName,
              arguments: product,
            );
          },
        );
      },
    );
  }
}
