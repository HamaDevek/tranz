import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tranzhouse/Getx/Controllers/admin_controller.dart';
import 'package:tranzhouse/Getx/Controllers/user_controller.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Pages/Admin/Detail/admin_detail_page.dart';
import 'package:tranzhouse/Utility/constants.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';

import '../../../Theme/theme.dart';
import '../../../Utility/utility.dart';
import '../../../Widgets/Containers/horizantaltile_widget.dart';
import '../../../Widgets/Text/text_widget.dart';
import '../Settings/admin_settings.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});
  static const String routeName = "/admin-main";

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  String tempStatus = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AdminController.to.getAllOrders();
      AdminController.to.filterOrdersByStatus("All");
    });
  }

  void refreshPage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await AdminController.to.getAllOrders();
      AdminController.to.filterOrdersByStatus("All");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            AppSpacer.appBarHeight(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TopCardWidget(
                name: UserController.to.user?.value.user?.name ?? '',
              ),
            ),
            AppSpacer.p16(),
            if (AdminController.to.isLoading.value)
              const SizedBox()
            else
              CategoriesWidget(
                onTap: (status) {
                  print(status);
                  tempStatus = status;
                  AdminController.to.filterOrdersByStatus(status);
                },
              ),
            AppSpacer.p16(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: ColorPalette.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacer.p32(),
                    if (AdminController.to.isLoading.value)
                      const AdminOrdersLoadingWidget()
                    else ...[
                      TextWidget(
                        "Orders",
                        style: TextWidget.textStyleCurrent.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.whiteColor,
                        ),
                      ),
                      AppSpacer.p8(),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            refreshPage();
                          },
                          strokeWidth: 2,
                          child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.only(top: 8, bottom: 40),
                            itemCount: AdminController.to.filteredOrders.length,
                            separatorBuilder: (context, index) =>
                                AppSpacer.p16(),
                            itemBuilder: (context, index) {
                              final order =
                                  AdminController.to.filteredOrders[index];
                              return HorizantalTileWidget(
                                onTap: () {
                                  Get.toNamed(AmdinOrderDetailPage.routeName,
                                      arguments: {
                                        'order': order,
                                        'status': tempStatus,
                                      });
                                },
                                status: status(order.status ?? ""),
                                title: order.owner?.name ?? "",
                                subtitle: getText(order.service?.title ??
                                    LanguagesModel(
                                      en: "",
                                      ar: "",
                                      ku: "",
                                    )),
                                date: order.createdAt.toString(),
                              );
                            },
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  OrderStatus status(String status) {
    switch (status) {
      case "pending":
        return OrderStatus.pending;
      case "accept":
        return OrderStatus.accepted;
      case "rejected":
        return OrderStatus.rejected;
      default:
        return OrderStatus.pending;
    }
  }
}

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({
    super.key,
    required this.onTap,
  });
  final Function(String status) onTap;

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final List<GlobalKey> keys = <GlobalKey>[];

  @override
  void initState() {
    super.initState();
    getKeys();
  }

  @override
  void dispose() {
    keys.clear();
    super.dispose();
  }

  void getKeys() {
    for (int i = 0; i < orderStatus.length; i++) {
      keys.add(GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          4,
          (index) {
            return GestureDetector(
              key: keys[index],
              onTap: () {
                widget.onTap(orderStatus[index]);
                scrollToSelectedContent(
                  expansionTileKey: keys[index],
                  alignment: 0.4,
                );

                // Get.toNamed(AmdinOrderDetailPage.routeName);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsetsDirectional.only(end: index == 4 ? 0 : 16),
                height: screenWidth(context) * 0.32,
                width: screenWidth(context) * 0.3,
                decoration: BoxDecoration(
                  color: _getButtonColors(index),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/lines.png",
                      height: screenWidth(context) * 0.32,
                      width: screenWidth(context) * 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/file.svg",
                              colorFilter: ColorFilter.mode(
                                index == 4
                                    ? ColorPalette.whiteColor
                                    : ColorPalette.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const Spacer(),
                            TextWidget(
                              AdminController.to.quantities!.isNotEmpty
                                  ? AdminController.to.quantities![index]
                                      .toString()
                                  : "0",
                              style: TextWidget.textStyleCurrent.copyWith(
                                fontWeight: FontWeight.w600,
                                color: index == 4
                                    ? ColorPalette.whiteColor
                                    : ColorPalette.primary,
                              ),
                            ),
                            FittedBox(
                              child: TextWidget(
                                orderStatus[index],
                                style: TextWidget.textStyleCurrent.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: index == 4
                                      ? ColorPalette.greyText
                                      : ColorPalette.primaryLight,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getButtonColors(int index) {
    switch (index) {
      case 0:
        return ColorPalette.whiteColor;
      case 1:
        return ColorPalette.yellow;
      case 2:
        return ColorPalette.green;

      case 3:
        return ColorPalette.red;

      default:
        return ColorPalette.primary;
    }
  }
}

class TopCardWidget extends StatelessWidget {
  const TopCardWidget({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ColorPalette.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      dense: true,
      horizontalTitleGap: 16,
      leading: const FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.person,
              color: ColorPalette.greyText,
            ),
          ],
        ),
      ),
      title: TextWidget(
        name,
      ),
      trailing: Wrap(
        children: [
          // TextButton(
          //   style: TextButton.styleFrom(
          //     backgroundColor: ColorPalette.whiteColor,
          //     foregroundColor: ColorPalette.primary,
          //     shape: const CircleBorder(),
          //     minimumSize: const Size(35, 35),
          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   ),
          //   onPressed: () {
          //     Get.toNamed(AdminNotificationsPAge.routeName);
          //   },
          //   child: const Icon(
          //     CupertinoIcons.bell,
          //     size: 18,
          //   ),
          // ),
          // AppSpacer.p4(),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorPalette.whiteColor,
              foregroundColor: ColorPalette.primary,
              shape: const CircleBorder(),
              minimumSize: const Size(35, 35),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Get.toNamed(AdminSettingsPage.routeName);
            },
            child: SvgPicture.asset(
              "assets/icons/settings.svg",
              colorFilter: const ColorFilter.mode(
                ColorPalette.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminOrdersLoadingWidget extends StatelessWidget {
  const AdminOrdersLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        enabled: true,
        // enabled: true,
        effect: ShimmerEffect.raw(
          colors: [
            ColorPalette.primary.withOpacity(1),
            ColorPalette.greyText,
            ColorPalette.whiteColor,
          ],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.only(top: 8, bottom: 40),
          itemCount: fakeAdminOrders.length,
          separatorBuilder: (context, index) => AppSpacer.p16(),
          itemBuilder: (context, index) {
            final order = fakeAdminOrders[index];
            return HorizantalTileWidget(
              cardColor: ColorPalette.primaryLight,
              onTap: () {
                Get.toNamed(AmdinOrderDetailPage.routeName);
              },
              status: OrderStatus.values[index % 3],
              title: order.owner?.name ?? "",
              subtitle: getText(order.service?.title ??
                  LanguagesModel(
                    en: "",
                    ar: "",
                    ku: "",
                  )),
              date: order.createdAt.toString(),
            );
          },
        ),
      ),
    );
  }
}
