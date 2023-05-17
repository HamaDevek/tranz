import 'package:flutter/material.dart';

import '../../../Theme/theme.dart';
import '../../../Widgets/Text/text_widget.dart';

class TabbarWidget extends StatefulWidget {
  const TabbarWidget({
    super.key,
    required this.onTabChanged,
    required this.tabTitles,
  });
  final Function(int index) onTabChanged;
  final List<String> tabTitles;

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabTitles.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
        widget.onTabChanged(value);
      },
      isScrollable: true,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // color: ColorPalette.red,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      labelColor: ColorPalette.black,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      unselectedLabelColor: ColorPalette.whiteColor,
      tabs: List.generate(_tabController.length, (index) {
        return Tab(
          child: AnimatedContainer(
            margin: const EdgeInsetsDirectional.only(end: 8),
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: _selectedIndex == index ? ColorPalette.yellow : null,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: _selectedIndex == index
                    ? ColorPalette.yellow
                    : ColorPalette.whiteColor,
                width: 1,
              ),
            ),
            child: TextWidget(
              widget.tabTitles[index],
              style: TextWidget.textStyleCurrent.copyWith(
                fontSize: 14,
                color: _selectedIndex == index
                    ? ColorPalette.black
                    : ColorPalette.whiteColor,
              ),
            ),
          ),
        );
      }),
    );
  }
}
