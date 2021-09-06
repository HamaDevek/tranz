import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/button_custom_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../model/pageview_model.dart';
import '../../../services/is_first_service.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _pageViewcontroller = new PageController();

  List<PageviewModel> _pageView = [
    PageviewModel(
      desc: 'welcome.1'.tr,
      image: 'assets/images/welcome/1.png',
      key: '1',
    ),
    PageviewModel(
      desc: 'welcome.2'.tr,
      image: 'assets/images/welcome/2.png',
      key: '2',
    ),
    PageviewModel(
      desc: 'welcome.3'.tr,
      image: 'assets/images/welcome/3.png',
      key: '3',
    ),
    PageviewModel(
      desc: 'welcome.4'.tr,
      image: 'assets/images/welcome/3.png',
      key: '4',
    ),
  ];
  PageviewModel? _selectedPage;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedPage = _pageView.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: NoGlowComponent(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: "language.rtl".tr.parseBool,
                        onPageChanged: (page) {
                          setState(() {
                            _selectedPage = _pageView[page];
                          });
                        },
                        itemBuilder: (_, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('${_pageView[index].image}'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                        itemCount: _pageView.length,
                        controller: _pageViewcontroller,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ..."language.rtl".tr.parseBool
                                ? _pageViewPointer(context).reversed
                                : _pageViewPointer(context)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        child: Text(
                          "${_selectedPage!.desc}",
                          textAlign: 'language.rtl'.tr.parseBool
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                            color: !ThemeService().isSavedDarkMode()
                                ? Color(0xFF1E272E)
                                : Colors.white,
                            fontFamily:
                                'language.rtl'.tr.parseBool ? 'Rabar' : '',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 110,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustomComponent(
                      onPress: () async {
                        IsFirstService().saveIsFirst(false);
                        Get.offAllNamed('/main');
                      },
                      child: Text(
                        'next'.tr.firstUpperCase,
                        style: TextStyle(
                          fontSize: 20,
                          color: ThemeService().isSavedDarkMode()
                              ? Color(0xFF1E272E)
                              : Colors.white,
                          fontFamily:
                              'language.rtl'.tr.parseBool ? 'Rabar' : '',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _pageViewPointer(BuildContext context) {
    return _pageView
        .map(
          (e) => Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            height: 5,
            width: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _selectedPage == e
                  ? Theme.of(context).primaryColor
                  : ThemeService().isSavedDarkMode()
                      ? Color(0xff222F3E)
                      : Theme.of(context).accentColor,
            ),
          ),
        )
        .toList();
  }
}
