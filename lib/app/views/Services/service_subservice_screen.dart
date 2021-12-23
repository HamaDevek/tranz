import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../../app/controllers/service_api_controller.dart';
import '../../../app/models/service_model.dart';
import '../../../components/no_glow_component.dart';
import '../../../components/services/service_card_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/config.dart';
import '../../../utils/extentions.dart';

class ServiceSubserviceScreen extends StatefulWidget {
  const ServiceSubserviceScreen({Key? key}) : super(key: key);

  @override
  _ServiceSubserviceScreenState createState() =>
      _ServiceSubserviceScreenState();
}

class _ServiceSubserviceScreenState extends State<ServiceSubserviceScreen> {
  final ServiceApiController _serviceApiController =
      Get.put(ServiceApiController());

  _ServiceSubserviceScreenState();
  ServiceModel? service;
  List<ServiceModel>? subservice;
  @override
  void initState() {
    super.initState();
    service = Get.arguments;
    subservice = _serviceApiController.getchiled(service!.id!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      'language.rtl'.tr.parseBool
                          ? Iconsax.arrow_right_3
                          : Iconsax.arrow_left_2,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${service?.title?["x-lang".tr]}',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    ),
                    textAlign: 'language.rtl'.tr.parseBool
                        ? TextAlign.left
                        : TextAlign.right,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "${service?.picture.isBlank ?? false ? ConfigApp.placeholder : "${ConfigApp.apiUrl}/public/uploads/category/${service?.picture}"}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          // colorFilter:
                          //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: Icon(
                        Iconsax.gallery,
                        size: 50,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Iconsax.gallery_slash,
                      size: 50,
                    ),
                    cacheManager: CacheManager(
                      Config(
                        '${service?.picture.isBlank ?? false ? ConfigApp.placeholder : "${ConfigApp.apiUrl}/public/uploads/category/${service?.picture}"}',
                        stalePeriod: const Duration(days: 15),
                        maxNrOfCacheObjects: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
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
                      'services.types'.tr,
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
                )),
            Expanded(
              child: subservice!.length == 0
                  ? Container()
                  : Obx(
                      () => ScrollConfiguration(
                        behavior: NoGlowComponent(),
                        child: GridView.builder(
                            itemCount: subservice!.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        _serviceApiController
                                                .isVertical.value
                                            ? 2
                                            : 1,
                                    childAspectRatio:
                                        MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery
                                                        .of(context)
                                                    .size
                                                    .height /
                                                1.6),
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    mainAxisExtent: _serviceApiController
                                            .isVertical.value
                                        ? 145
                                        : 185),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            itemBuilder: (context, index) {
                              return ServiceCardComponent(
                                service: subservice![index],
                              );
                            }),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
