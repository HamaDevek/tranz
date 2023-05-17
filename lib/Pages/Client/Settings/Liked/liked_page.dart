import 'package:flutter/material.dart';
import 'package:tranzhouse/Pages/Client/Products/tabbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../../../Widgets/Containers/image_grid_card_widget.dart';

class LikedksPage extends StatefulWidget {
  const LikedksPage({super.key});
  static const String routeName = "/liked";

  @override
  State<LikedksPage> createState() => _LikedksPageState();
}

class _LikedksPageState extends State<LikedksPage> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Liked",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacer.p20(),
          TabbarWidget(
            onTabChanged: (index) {
              _tabIndex.value = index;
            },
            tabTitles: const [
              "Services",
              "Products",
            ],
          ),
          AppSpacer.p16(),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _tabIndex,
              builder: (context, value, child) {
                return _getTabs();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTabs() {
    switch (_tabIndex.value) {
      case 0:
        return const ServicesGridsWidget();
      case 1:
        return const PruductsGridsWidget();
      default:
        return const ServicesGridsWidget();
    }
  }
}

class ServicesGridsWidget extends StatelessWidget {
  const ServicesGridsWidget({
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

      // physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) {
        return ImageGridCardWidget(
          isForArticle: false,
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

class PruductsGridsWidget extends StatelessWidget {
  const PruductsGridsWidget({
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

      // physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) {
        return ImageGridCardWidget(
          isForArticle: false,
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
