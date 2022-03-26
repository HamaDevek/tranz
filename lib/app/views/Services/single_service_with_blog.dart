import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../app/controllers/service_api_controller.dart';
import '../../../app/models/service_model.dart';
import '../../../components/button_custom_component.dart';
import '../../../components/empty_state_component.dart';
import '../../../components/blog/blog_component.dart';
import '../../../components/blog/blog_loading_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../services/theme_service.dart';
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
    _serviceApiController.isOnScreenBlogService(true);
    // _serviceApiController.blogs.listen((val) {
    //   if (_serviceApiController.isOnScreenBlogService.value) {
    //     if (service!.type != 'noorder') {
    //       Get.offNamed('/service/order', arguments: service);
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    _serviceApiController.isOnScreenBlogService(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            _serviceApiController.isOnScreenBlogService(false);
                            Get.back();
                          },
                          icon: Icon(
                            'language.rtl'.tr.parseBool
                                ? Iconsax.arrow_right_3
                                : Iconsax.arrow_left_2,
                          )),
                      Container(
                        margin: const EdgeInsets.all(16),
                        child: Text(
                          '${service?.title?["x-lang".tr] ?? ''}',
                          textAlign: 'language.rtl'.tr.parseBool
                              ? TextAlign.left
                              : TextAlign.right,
                          style: TextStyle(
                            fontFamily:
                                'language.rtl'.tr.parseBool ? "Rabar" : "",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: !ThemeService().isSavedDarkMode()
                                ? const Color(0xFF1E272E)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Obx(() {
                  if (_serviceApiController.isLoadingBlog.value) {
                    return ScrollConfiguration(
                      behavior: NoGlowComponent(),
                      child: ListView.builder(
                        itemBuilder: (_, __) {
                          return const BlogLoadingComponent();
                        },
                        itemCount: 3,
                      ),
                    );
                  } else {
                    if (_serviceApiController.blogs.isNotEmpty) {
                      return Stack(
                        children: [
                          ScrollConfiguration(
                            behavior: NoGlowComponent(),
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 16),
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
                    } else {
                      _changeScreen();
                      return Stack(
                        children: [
                          ScrollConfiguration(
                            behavior: NoGlowComponent(),
                            child: EmptyStateComponent(
                              icon: Iconsax.book_saved,
                              header: 'blog.empty.head'.tr,
                            ),
                          ),
                        ],
                      );
                    }
                  }
                })),
              ],
            ),
            service!.type == 'noorder'
                ? const SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: ButtonCustomComponent(
                            child: Text(
                              'services.order'.tr,
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color(0xFF1E272E),
                                fontFamily:
                                    'language.rtl'.tr.parseBool ? 'Rabar' : '',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPress: () {
                              if (_serviceApiController.blogs.isNotEmpty) {
                                Get.toNamed('/service/order',
                                    arguments: service);
                              } else {
                                Get.offNamed('/service/order',
                                    arguments: service);
                              }
                            }),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  _changeScreen() async {
    if (_serviceApiController.isOnScreenBlogService.value) {
      if (service!.type != 'noorder') {
        await Future.delayed(const Duration(milliseconds: 100));
        Get.offNamed('/service/order', arguments: service);
      }
    }
  }
}
