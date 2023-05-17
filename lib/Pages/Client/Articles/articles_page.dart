import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Pages/Client/Articles/single_article_page.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacer.appBarHeight(),
        const ArticlesTopWidget(),
        AppSpacer.p20(),
        const Expanded(
          child: GridsWidget(),
        ),
      ],
    ));
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
        childAspectRatio: .8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
      itemCount: 7,
      itemBuilder: (context, index) {
        return ImageGridCardWidget(
          isForArticle: true,
          imageUrl: "https://picsum.photos/400/200",
          price: 10000,
          date: DateTime.parse("2022-10-17T09:29:12.000000Z"),
          title: "New product unlocked: Blush",
          category: "Category Name",
          onTap: () {
            Get.toNamed(SingleArticlePage.routeName);
          },
          
        );
      },
    );
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
            "Articles",
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
            child: const Icon(
              CupertinoIcons.bookmark,
              size: 15,
            ),
          ),
          AppSpacer.p8(),
        ],
      ),
    );
  }
}