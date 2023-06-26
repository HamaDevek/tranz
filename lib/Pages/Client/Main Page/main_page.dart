import 'package:flutter/material.dart';
import 'package:tranzhouse/Pages/Client/Articles/articles_page.dart';
import 'package:tranzhouse/Pages/Client/Products/products_page.dart';
import 'package:tranzhouse/Pages/Client/Services/services_category_page.dart';
import 'package:tranzhouse/Pages/Client/Settings/settings_page.dart';
import 'package:tranzhouse/Widgets/Other/keep_alive_page.dart';
import 'package:tranzhouse/Widgets/Other/widget_size.dart';

import '../../../Theme/theme.dart';
import '../../../Utility/utility.dart';
import 'nav_button_widget.dart';

class ClientMainPage extends StatefulWidget {
  const ClientMainPage({super.key});
  static String routeName = '/main';
  static double navigationBarHeight = 0;

  @override
  State<ClientMainPage> createState() => _ClientMainPageState();
}

class _ClientMainPageState extends State<ClientMainPage> {
  final bool _isVisible = true;
  final PageController _pageController = PageController();
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int index) {
                _selectedIndex.value = index;
              },
              children: const [
                KeepAlivePage(
                  child: ServicesCategoriesPage(),
                ),
                KeepAlivePage(child: ProductsPage()),
                KeepAlivePage(
                  child: ArticlesPage(),
                ),
                KeepAlivePage(
                  child: SettingsPage(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSwitcher(
              reverseDuration: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeIn,
                    ),
                  ),
                  child: child,
                );
              },
              child: MediaQuery.of(context).viewInsets.bottom > 0 ||
                      _isVisible == false
                  ? const SizedBox()
                  : ValueListenableBuilder(
                      valueListenable: _selectedIndex,
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return MeasureWidgetSize(
                          onChange: (size) {
                            ClientMainPage.navigationBarHeight = size.height;
                          },
                          child: Container(
                            width: screenWidth(context),
                            // padding: const EdgeInsets.symmetric(
                            //   horizontal: 30,
                            // ),
                            decoration: const BoxDecoration(
                              color: ColorPalette.primaryDark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    NavigationBarButton(
                                      name: 'Services',
                                      selectedIcon:
                                          'assets/icons/spanner.selected.svg',
                                      icon: 'assets/icons/spanner.svg',
                                      hasSelected: value == 0,
                                      onTap: () {
                                        _pageController.jumpToPage(0);
                                      },
                                    ),
                                    NavigationBarButton(
                                      name: 'Products',
                                      selectedIcon:
                                          'assets/icons/menu.selected.svg',
                                      icon: 'assets/icons/menu.svg',
                                      hasSelected: value == 1,
                                      onTap: () {
                                        _pageController.jumpToPage(1);
                                      },
                                    ),
                                    NavigationBarButton(
                                      name: 'Articles',
                                      selectedIcon:
                                          'assets/icons/article.selected.svg',
                                      icon: 'assets/icons/article.svg',
                                      hasSelected: value == 2,
                                      onTap: () {
                                        _pageController.jumpToPage(2);
                                      },
                                    ),
                                    NavigationBarButton(
                                      name: 'Settings',
                                      selectedIcon:
                                          'assets/icons/settings.selected.svg',
                                      icon: 'assets/icons/settings.svg',
                                      hasSelected: value == 3,
                                      onTap: () {
                                        _pageController.jumpToPage(3);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).padding.bottom,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
