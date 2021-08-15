import 'package:flutter/material.dart';
import 'package:trancehouse/app/controllers/blog_api_controller.dart';
import 'package:trancehouse/components/blog/blog_component.dart';
import 'package:trancehouse/components/blog/blog_loading_component.dart';
import 'package:trancehouse/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:trancehouse/utils/extentions.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final BlogApiController _blogsController = Get.put(BlogApiController());
  @override
  void initState() {
    super.initState();
    _blogsController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async => _blogsController.onInit(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: Text(
                  'blog'.tr,
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Colors.white,
                  ),
                ),
              ),
              Obx(() {
                if (_blogsController.isLoading.value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlogLoadingComponent(),
                      BlogLoadingComponent(),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _blogsController.blogs
                        .map((blog) => BlogComponent(
                              blog: blog,
                            ))
                        .toList(),
                  );
                }
              }),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
