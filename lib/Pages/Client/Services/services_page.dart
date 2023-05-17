import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

import '../../../Widgets/Containers/services_tile_widget.dart';
import 'single_service_page.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final ValueNotifier<bool> _isGrid = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppSpacer.appBarHeight(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ServicesTopWidget(
              onGridChanged: (isGrid) {
                _isGrid.value = isGrid;
              },
            ),
          ),
          AppSpacer.p20(),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _isGrid,
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
    switch (_isGrid.value) {
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
      itemCount: 7,
      separatorBuilder: (context, index) => AppSpacer.p16(),
      itemBuilder: (context, index) {
        return ServicesTileWidget(
          imageUrl: "https://picsum.photos/300/300",
          title: "Title Name",
          description:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint...",
          isGrid: false,
          onTap: () {
            print("object");
            Get.toNamed(SingleServicePage.routeName);
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
      itemCount: 7,
      itemBuilder: (context, index) {
        return ServicesTileWidget(
          imageUrl: "https://picsum.photos/300/300",
          title: "Title Name",
          description:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint...",
          isGrid: true,
          onTap: () {
            Get.toNamed(SingleServicePage.routeName);
          },
        );
      },
    );
  }
}

class ServicesTopWidget extends StatefulWidget {
  const ServicesTopWidget({
    super.key,
    required this.onGridChanged,
  });
  final Function(bool isGrid) onGridChanged;

  @override
  State<ServicesTopWidget> createState() => _ServicesTopWidgetState();
}

class _ServicesTopWidgetState extends State<ServicesTopWidget> {
  ValueNotifier<bool> isGrid = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWidget(
          "Services",
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
            widget.onGridChanged(isGrid.value);
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
      ],
    );
  }
}
