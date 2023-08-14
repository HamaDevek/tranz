import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tranzhouse/Getx/Controllers/serivices_controller.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Pages/Client/Articles/single_article_page.dart';
import 'package:tranzhouse/Utility/constants.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';

import '../../../Theme/theme.dart';
import '../../../Widgets/Containers/image_grid_card_widget.dart';
import '../../../Widgets/Other/app_spacer.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ServicesController.to.getBlogs();
    });
  }

  void refreshPage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ServicesController.to.getBlogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        refreshPage();
      },
      edgeOffset: 100,
      // backgroundColor: ColorPalette.whiteColor,
      // color: ColorPalette.primary,
      strokeWidth: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacer.appBarHeight(),
          const ArticlesTopWidget(),
          AppSpacer.p20(),
          const Expanded(
            child: GridsWidget(),
          ),
        ],
      ),
    ));
  }
}

class GridsWidget extends StatelessWidget {
  const GridsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if (ServicesController.to.blogsLoading.value) {
      //   return const Center(
      //     child: CupertinoActivityIndicator(),
      //   );
      // }
      return Skeletonizer(
        enabled: ServicesController.to.blogsLoading.value,
        // enabled: true,
        effect: ShimmerEffect.raw(
          colors: [
            ColorPalette.primary.withOpacity(1),
            ColorPalette.greyText,
            ColorPalette.whiteColor,
          ],
        ),
        child: ServicesController.to.blogsLoading.value
            ? const BlogsLoadingWidget()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding:
                    const EdgeInsets.only(bottom: 100, left: 16, right: 16),
                itemCount: ServicesController.to.blogs.length,
                itemBuilder: (context, index) {
                  final blog = ServicesController.to.blogs[index];
                  return ImageGridCardWidget(
                    isForArticle: true,
                    imageUrl: blog.images?[0] ?? "",
                    price: 10000,
                    // date: DateTime.parse("2022-10-17T09:29:12.000000Z"),
                    date: blog.updatedAt ?? DateTime.now(),
                    title: getText(blog.title ??
                        LanguagesModel(
                          en: "",
                          ar: "",
                          ku: "",
                        )),
                    // category: "Category Name",
                    onTap: () {
                      Get.toNamed(
                        SingleArticlePage.routeName,
                        arguments: blog,
                      );
                    },
                  );
                },
              ),
      );
    });
  }
}

class ArticlesTopWidget extends StatelessWidget {
  const ArticlesTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          TextWidget(
            "Blogs",
            style: TextWidget.textStyleCurrent.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          // const Spacer(),
          // TextButton(
          //   style: TextButton.styleFrom(
          //     backgroundColor: ColorPalette.whiteColor,
          //     foregroundColor: ColorPalette.primary,
          //     shape: const CircleBorder(),
          //     minimumSize: const Size(35, 35),
          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   ),
          //   onPressed: () {},
          //   child: const Icon(
          //     CupertinoIcons.bookmark,
          //     size: 15,
          //   ),
          // ),
          // AppSpacer.p8(),
        ],
      ),
    );
  }
}

class BlogsLoadingWidget extends StatelessWidget {
  const BlogsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
      itemCount: fakeBlogs.length,
      itemBuilder: (context, index) {
        final blog = fakeBlogs[index];
        return ImageGridCardWidget(
          isForArticle: true,
          imageUrl: blog.images?[0] ?? "",
          price: 10000,
          // date: DateTime.parse("2022-10-17T09:29:12.000000Z"),
          date: blog.updatedAt ?? DateTime.now(),
          title: getText(blog.title ??
              LanguagesModel(
                en: "",
                ar: "",
                ku: "",
              )),
          // category: "Category Name",
          onTap: () {
            Get.toNamed(
              SingleArticlePage.routeName,
              arguments: blog,
            );
          },
        );
      },
    );
  }
}
