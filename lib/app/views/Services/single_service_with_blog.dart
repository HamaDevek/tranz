import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trancehouse/app/controllers/service_api_controller.dart';
import 'package:trancehouse/app/models/service_model.dart';
import 'package:trancehouse/components/button_custom_component.dart';
import '../../../components/blog/blog_component.dart';
import '../../../components/blog/blog_loading_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../services/theme_service.dart';
import 'package:get/get.dart';
import '../../../utils/extentions.dart';

class SingleServiceWithBlog extends StatefulWidget {
  const SingleServiceWithBlog({Key? key}) : super(key: key);

  @override
  _SingleServiceWithBlogState createState() => _SingleServiceWithBlogState();
}

class _SingleServiceWithBlogState extends State<SingleServiceWithBlog> {
  final ServiceApiController _serviceApiController =
      Get.put(ServiceApiController());
  ServiceModel? service;

  @override
  void initState() {
    super.initState();
    service = Get.arguments;
    _serviceApiController.getBlogByService(service!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Text(
                          '${service?.name}',
                          textAlign: 'language.rtl'.tr.parseBool
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontFamily:
                                'language.rtl'.tr.parseBool ? "Rabar" : "",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: !ThemeService().isSavedDarkMode()
                                ? Color(0xFF1E272E)
                                : Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            'language.rtl'.tr.parseBool
                                ? Iconsax.arrow_left_2
                                : Iconsax.arrow_right_3,
                          ))
                    ],
                  ),
                ),
                Expanded(child: Obx(() {
                  if (_serviceApiController.isLoadingBlog.value) {
                    return ScrollConfiguration(
                      behavior: NoGlowComponent(),
                      child: ListView.builder(
                        itemBuilder: (_, __) {
                          return BlogLoadingComponent();
                        },
                        itemCount: 3,
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        ScrollConfiguration(
                          behavior: NoGlowComponent(),
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 16),
                            itemBuilder: (context, index) {
                              return BlogComponent(
                                blog: _serviceApiController.blogs[index],
                              );
                            },
                            itemCount: _serviceApiController.blogs.length,
                          ),
                        ),
                      ],
                    );
                  }
                })),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: ButtonCustomComponent(
                      child: Text(
                        'services.order'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF1E272E),
                          fontFamily:
                              'language.rtl'.tr.parseBool ? 'Rabar' : '',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPress: () {
                        Get.toNamed('/service/order', arguments: service);
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
