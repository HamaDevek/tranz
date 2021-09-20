import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trancehouse/app/controllers/language_controller.dart';

import '../services/theme_service.dart';
import '../theme/theme_modes.dart';
import '../utils/config.dart';
import '../app/bindings/binding_manager.dart';
import '../app/views/PageNotFound/unknowen_route_page.dart';
import '../utils/messages.dart';
import '../utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // systemNavigationBarColor: Color(0xff38424D),
      // statusBarColor: ThemeService().getThemeMode(),
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialAppWithProvider();
  }
}

class MaterialAppWithProvider extends StatefulWidget {
  @override
  _MaterialAppWithProviderState createState() =>
      _MaterialAppWithProviderState();
}

class _MaterialAppWithProviderState extends State<MaterialAppWithProvider> {
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageController.changeLanguage(
        dialect: prefs.getString('dialect').toString(),
        language: prefs.getString('language').toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Messages(),
      locale: const Locale('ar', 'SO'),
      fallbackLocale: const Locale('ar', 'SO'),
      initialBinding: BindingManager(),
      unknownRoute:
          GetPage(name: '/notfound', page: () => const UnknownRoutePage()),
      // enableLog: false,
      getPages: RouteName.routes,
      initialRoute: ConfigApp.root,
      title: ConfigApp.appName,
      theme: Themes().lightMode,
      darkTheme: Themes().darkMode,
      themeMode: ThemeService().getThemeMode(),
    );
  }
}
