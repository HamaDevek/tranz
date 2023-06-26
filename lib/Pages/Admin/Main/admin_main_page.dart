import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Admin/Detail/admin_detail_page.dart';
import 'package:tranzhouse/Utility/constants.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';

import '../../../Theme/theme.dart';
import '../../../Utility/utility.dart';
import '../../../Widgets/Containers/horizantaltile_widget.dart';
import '../../../Widgets/Other/image_widget.dart';
import '../../../Widgets/Text/text_widget.dart';
import '../Notifications/admin_notifications_page.dart';
import '../Settings/admin_settings.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});
  static const String routeName = "/admin-main";

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppSpacer.appBarHeight(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ProfileCardWidget(
              profileUrl: "https://picsum.photos/400/200",
              name: "Jaza Yahya",
            ),
          ),
          AppSpacer.p16(),
          const CategoriesWidget(),
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
                  TextWidget(
                    "Orders",
                    style: TextWidget.textStyleCurrent.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.whiteColor,
                    ),
                  ),
                  AppSpacer.p8(),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(top: 8, bottom: 40),
                      itemCount: 10,
                      separatorBuilder: (context, index) => AppSpacer.p16(),
                      itemBuilder: (context, index) {
                        return HorizantalTileWidget(
                          onTap: () {
                            Get.toNamed(AmdinOrderDetailPage.routeName);
                          },
                          status: OrderStatus.values[index % 3],
                          title: "Order #${index + 1}",
                          subtitle: "Category Name",
                          date: DateTime.parse("2022-10-17T09:29:12.000000Z")
                              .toString(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<GlobalKey> keys = <GlobalKey>[];
    for (int i = 0; i < categoris.length; i++) {
      keys.add(GlobalKey());
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          categoris.length,
          (index) {
            return GestureDetector(
              key: keys[index],
              onTap: () {
                scrollToSelectedContent(
                  expansionTileKey: keys[index],
                  alignment: 0.4,
                );
                Get.toNamed(AmdinOrderDetailPage.routeName);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsetsDirectional.only(end: index == 3 ? 0 : 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/file.svg",
                            colorFilter: ColorFilter.mode(
                              index == 3
                                  ? ColorPalette.whiteColor
                                  : ColorPalette.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Spacer(),
                          TextWidget(
                            "8",
                            style: TextWidget.textStyleCurrent.copyWith(
                              fontWeight: FontWeight.w600,
                              color: index == 3
                                  ? ColorPalette.whiteColor
                                  : ColorPalette.primary,
                            ),
                          ),
                          FittedBox(
                            child: TextWidget(
                              categoris[index],
                              style: TextWidget.textStyleCurrent.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: index == 3
                                    ? ColorPalette.greyText
                                    : ColorPalette.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
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

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.profileUrl,
    required this.name,
  });
  final String profileUrl;
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
      leading: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
              isCircle: true,
              height: screenWidth(context) * 0.10,
              width: screenWidth(context) * 0.10,
              imageUrl: profileUrl,
            ),
          ],
        ),
      ),
      title: TextWidget(
        name,
      ),
      trailing: Wrap(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorPalette.whiteColor,
              foregroundColor: ColorPalette.primary,
              shape: const CircleBorder(),
              minimumSize: const Size(35, 35),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Get.toNamed(AdminNotificationsPAge.routeName);
            },
            child: const Icon(
              CupertinoIcons.bell,
              size: 18,
            ),
          ),
          AppSpacer.p4(),
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
