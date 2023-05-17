import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Client/Products/tabbar_widget.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacer.appBarHeight(),
        const ProductsTopWidget(),
        AppSpacer.p20(),
        TabbarWidget(
          tabTitles: const [
            "All",
            "New",
            "Popular",
            "Trending",
            "Best Seller",
            "Discount",
            "Top Rated",
            "Exclusive",
            "Featured",
          ],
          onTabChanged: (index) {},
        ),
        AppSpacer.p20(),
        const Expanded(child: GridsWidget()),
      ],
    ));
  }
}

class GridsWidget extends StatelessWidget {
  const GridsWidget({
    super.key,
  });

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
      itemCount: 7,
      itemBuilder: (context, index) {
        return ImageGridCardWidget(
          imageUrl: "https://picsum.photos/400/200",
          price: 23000,
          title: "Title Name",
          category: "Category Name",
          onTap: () {
            Get.toNamed(SingleProductPage.routeName);
          },
        );
      },
    );
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
