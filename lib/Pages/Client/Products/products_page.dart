import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Getx/Controllers/product_controller.dart';
import 'package:tranzhouse/Pages/Client/Products/tabbar_widget.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProductsController.to.products.clear();
      ProductsController.to.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacer.appBarHeight(),
        const ProductsTopWidget(),
        AppSpacer.p20(),
        TabbarWidget(
          tabTitles: ProductsController.to.productsCategories
              .mapIndexed((index, element) => getTitles(element)),
          // tabTitles:
          //     ProductsController.to.productsCategories.asMap().entries.map((e) {
          //   print(e.key);
          //   return getTitles(e.value);
          // }).toList(),
          onTabChanged: (index) {},
        ),
        AppSpacer.p20(),
        const Expanded(child: GridsWidget()),
      ],
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
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (ProductsController.to.productsLoading.value) {
          return const SizedBox.shrink();
        }

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
          itemCount: ProductsController.to.products.length,
          itemBuilder: (context, index) {
            final product = ProductsController.to.products[index];
            

            return ImageGridCardWidget(
              imageUrl: product.images?[0] ?? "https://picsum.photos/400/200",
              price: product.price ?? 0,
              title: getTitles(product.title ?? LanguagesModel()),
              category: product.category ?? "Category Name",
              onTap: () {
                Get.toNamed(SingleProductPage.routeName,arguments: product,);
              },
            );
          },
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
              onPressed: () {},
              child: SvgPicture.asset("assets/icons/cart.svg")),
          AppSpacer.p8(),
        ],
      ),
    );
  }
}
