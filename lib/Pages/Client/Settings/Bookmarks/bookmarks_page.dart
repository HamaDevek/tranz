import 'package:flutter/material.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../../../Widgets/Containers/image_grid_card_widget.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});
  static const String routeName = "/bookmarks";

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Bookmarks",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacer.p20(),
            const GridsWidget(),
          ],
        ),
      ),
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
        childAspectRatio: .8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
      physics: const NeverScrollableScrollPhysics(),
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
            
          },
        );
      },
    );
  }
}
