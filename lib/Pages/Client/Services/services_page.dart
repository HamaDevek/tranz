import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../../Widgets/Containers/services_tile_widget.dart';
import 'single_service_page.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});
  static const String routeName = "/services";
  static List<Service> services = [];

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final ValueNotifier<bool> isGrid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    ServicesPage.services = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        pageTitle: "Services",
        actions: [
          // TextButton(
          //     style: TextButton.styleFrom(
          //       backgroundColor: ColorPalette.whiteColor,
          //       foregroundColor: ColorPalette.primary,
          //       shape: const CircleBorder(),
          //       minimumSize: const Size(35, 35),
          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //     ),
          //     onPressed: () {},
          //     child: SvgPicture.asset("assets/icons/cart.svg")),
          // AppSpacer.p8(),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorPalette.whiteColor,
              foregroundColor: ColorPalette.primary,
              shape: const CircleBorder(),
              minimumSize: const Size(35, 35),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              isGrid.value = !isGrid.value;
            },
            child: ValueListenableBuilder(
                valueListenable: isGrid,
                builder: (context, value, child) {
                  return Icon(
                    !value
                        ? CupertinoIcons.rectangle_grid_2x2
                        : CupertinoIcons.rectangle_grid_1x2,
                    size: 20,
                  );
                }),
          ),
          AppSpacer.p16(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacer.p20(),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: isGrid,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return _gridState();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridState() {
    switch (isGrid.value) {
      case true:
        return const GridsWidget();
      case false:
        return const ListWidget();
      default:
        return const ListWidget();
    }
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
      itemCount: ServicesPage.services.length,
      separatorBuilder: (context, index) => AppSpacer.p16(),
      itemBuilder: (context, index) {
        final service = ServicesPage.services[index];
        return ServicesTileWidget(
          imageUrl: service.images?[0] ?? "https://picsum.photos/300/300",
          title: getText(service.title ?? LanguagesModel(en: "",
                  ar: "",
                  ku: "")),
          description: getText(service.description ?? LanguagesModel(en: "",
                  ar: "",
                  ku: "")),
          isGrid: false,
          onTap: () {
            // print("object");
            Get.toNamed(SingleServicePage.routeName, arguments: service);
          },
        );
      },
    );
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
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
      itemCount: ServicesPage.services.length,
      itemBuilder: (context, index) {
        final service = ServicesPage.services[index];

        return ServicesTileWidget(
          imageUrl: service.images?[0] ?? "https://picsum.photos/300/300",
          title: getText(service.title ?? LanguagesModel(en: "",
                  ar: "",
                  ku: "")),
          description: getText(service.description ?? LanguagesModel(en: "",
                  ar: "",
                  ku: "")),
          isGrid: true,
          onTap: () {
            // print("object");
            Get.toNamed(SingleServicePage.routeName, arguments: service);
          },
        );
      },
    );
  }
}
