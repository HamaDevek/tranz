import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../app/controllers/service_api_controller.dart';
import '../../../components/no_glow_component.dart';
import '../../../components/services/service_card_component.dart';
import '../../../components/services/service_loading_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final ServiceApiController _serviceApiController =
      Get.put(ServiceApiController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 18,
          ),
          Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    _serviceApiController.changeVertical();
                  },
                  icon: Obx(() {
                    return Icon(_serviceApiController.isVertical.value
                        ? Iconsax.row_horizontal
                        : Iconsax.row_vertical);
                  }),
                ),
                Text(
                  'services'.tr,
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.left
                      : TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Obx(() {
            if (_serviceApiController.isLoading.value) {
              return ScrollConfiguration(
                behavior: NoGlowComponent(),
                child: GridView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            _serviceApiController.isVertical.value ? 2 : 1,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.6),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent:
                            _serviceApiController.isVertical.value ? 145 : 185),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemBuilder: (context, index) {
                      return ServiceLoadingComponent();
                    }),
              );
            } else {
              // return ScrollConfiguration(
              //   behavior: NoGlowComponent(),
              //   child: GridView.builder(
              //       itemCount: 6,
              //       shrinkWrap: true,
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount:
              //               _serviceApiController.isVertical.value ? 2 : 1,
              //           childAspectRatio: MediaQuery.of(context).size.width /
              //               (MediaQuery.of(context).size.height / 1.6),
              //           crossAxisSpacing: 16,
              //           mainAxisSpacing: 16,
              //           mainAxisExtent:
              //               _serviceApiController.isVertical.value ? 145 : 185),
              //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              //       itemBuilder: (context, index) {
              //         return ServiceLoadingComponent();
              //       }),
              // );
              return ScrollConfiguration(
                behavior: NoGlowComponent(),
                child: RefreshIndicator(
                  onRefresh: () async => _serviceApiController.onInit(),
                  child: GridView.builder(
                      itemCount: _serviceApiController.getParent()!.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              _serviceApiController.isVertical.value ? 2 : 1,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.6),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: _serviceApiController.isVertical.value
                              ? 145
                              : 185),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      itemBuilder: (context, index) {
                        return ServiceCardComponent(
                          service: _serviceApiController.getParent()![index],
                        );
                      }),
                ),
              );
            }
          })),
        ],
      ),
    );
  }
}
