import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tranzhouse/Getx/Controllers/serivices_controller.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Pages/Client/Services/services_page.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

import '../../../Getx/Controllers/client_controller.dart';
import '../../../Utility/constants.dart';
import '../../../Widgets/Containers/services_tile_widget.dart';
import '../Cart/products_cart_page.dart';
import '../Cart/services_cart_page.dart';

class ServicesCategoriesPage extends StatefulWidget {
  const ServicesCategoriesPage({super.key});

  @override
  State<ServicesCategoriesPage> createState() => _ServicesCategoriesPageState();
}

class _ServicesCategoriesPageState extends State<ServicesCategoriesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ServicesController.to.serviceCategories.clear();
      ServicesController.to.getServices();
      ClientController.to.getLocalCartItems(cartType: CartType.service);
    });
  }

  void refreshPage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ServicesController.to.serviceCategories.clear();

      ServicesController.to.getServices();
      ClientController.to.getLocalCartItems(cartType: CartType.service);
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
        child: Column(
          children: [
            AppSpacer.appBarHeight(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ServicesTopWidget(),
            ),
            AppSpacer.p20(),
            const Expanded(
              child: ListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if (ServicesController.to.servicesLoading.value) {
      //   return const LoadingWidget();
      // }
      return Skeletonizer(
        enabled: ServicesController.to.servicesLoading.value,
        // enabled: true,
        effect: ShimmerEffect.raw(
          colors: [
            ColorPalette.primary.withOpacity(1),
            ColorPalette.greyText,
            ColorPalette.whiteColor,
          ],
        ),
        child: ServicesController.to.servicesLoading.value
            ? const ServiceCategoryLoadingWidget()
            : ListView.separated(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.only(bottom: 100, left: 16, right: 16),
                itemCount: ServicesController.to.serviceCategories.length,
                separatorBuilder: (context, index) => AppSpacer.p16(),
                itemBuilder: (context, index) {
                  final category =
                      ServicesController.to.serviceCategories[index];

                  return ServicesTileWidget(
                    imageUrl: category.category?.image ??
                        "https://picsum.photos/400/200",
                    title: getTitlesCategory(category.category ?? Category()),
                    description:
                        "Tap Category to see all services in this category",
                    isGrid: false,
                    onTap: () {
                      // print("object");

                      Get.toNamed(ServicesPage.routeName,
                          arguments: category.services);
                    },
                  );
                },
              ),
      );
    });
  }
}

class ServicesTopWidget extends StatefulWidget {
  const ServicesTopWidget({
    super.key,
  });

  @override
  State<ServicesTopWidget> createState() => _ServicesTopWidgetState();
}

class _ServicesTopWidgetState extends State<ServicesTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWidget(
          "Service Categories",
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
            Get.toNamed(ServicesCartPage.routeName);
          },
          child: SvgPicture.asset("assets/icons/cart.svg"),
        ),
      ],
    );
  }
}

class ServiceCategoryLoadingWidget extends StatelessWidget {
  const ServiceCategoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
      itemCount: 3,
      separatorBuilder: (context, index) => AppSpacer.p16(),
      itemBuilder: (context, index) {
        final category = fakeServiceCategories[index];

        return ServicesTileWidget(
          imageUrl: category.category?.image ?? "https://picsum.photos/400/200",
          title: category.category?.nameEn ?? "Tittle",
          description: "Tap Category to see all services in this category",
          isGrid: false,
          onTap: () {
            // print("object");

            Get.toNamed(ServicesPage.routeName, arguments: category.services);
          },
        );
      },
    );
  }
}
