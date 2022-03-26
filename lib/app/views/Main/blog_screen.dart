import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/blog_api_controller.dart';
import '../../../components/blog/blog_component.dart';
import '../../../components/blog/blog_loading_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

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
    // _blogsController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Container(
            margin: const EdgeInsets.all(16),
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
                    ? const Color(0xFF1E272E)
                    : Colors.white,
              ),
            ),
          ),
          Expanded(child: Obx(() {
            if (_blogsController.isLoading.value) {
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
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  // ------------------ Check Is More ------------------ //
                  if ((scrollInfo.metrics.maxScrollExtent -
                              scrollInfo.metrics.pixels) ==
                          (scrollInfo.metrics.maxScrollExtent / 2) ||
                      scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          !_blogsController.isLoadingMore() &&
                          _blogsController.blogs.length <
                              _blogsController.length.value) {
                    _blogsController.getMore(_blogsController.blogs.length + 1,
                        _blogsController.blogs.length + 10);
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async => _blogsController.onInit(),
                      child: ScrollConfiguration(
                        behavior: NoGlowComponent(),
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                              bottom: _blogsController.isLoadingMore.value
                                  ? 100
                                  : 16),
                          itemBuilder: (context, index) {
                            return BlogComponent(
                              blog: _blogsController.blogs[index],
                            );
                          },
                          itemCount: _blogsController.blogs.length,
                        ),
                      ),
                    ),
                    _blogsController.isLoadingMore.value
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            }
          })),
        ],
      ),
    );
  }
}
