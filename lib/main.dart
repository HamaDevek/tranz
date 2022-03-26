import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../services/theme_service.dart';
import '../app/controllers/language_controller.dart';
import '../theme/theme_modes.dart';
import '../utils/config.dart';
import '../app/bindings/binding_manager.dart';
import '../app/views/PageNotFound/unknowen_route_page.dart';
import '../utils/messages.dart';
import '../utils/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // systemNavigationBarColor: Color(0xff38424D),
      // statusBarColor: ThemeService().getThemeMode(),
      ));
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialAppWithProvider();
  }
}

class MaterialAppWithProvider extends StatefulWidget {
  const MaterialAppWithProvider({Key? key}) : super(key: key);

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
    FirebaseMessaging.instance.getToken().then((value) {
      log(value.toString());
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('OnMessage Listen');
      log(message.data.toString());
      openUrlFirebase(message.data['link_url']);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      log(message.data.toString());
    });
  }

  Future<void> _loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageController.changeLanguage(
        dialect: prefs.getString('dialect').toString(),
        language: prefs.getString('language').toString());
  }

  void openUrlFirebase(url) async {
    await canLaunch(url!)
        ? await launch(url, forceSafariVC: false)
        : throw 'Could not launch :$url';
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
      enableLog: false,
      getPages: RouteName.routes,
      initialRoute: ConfigApp.root,
      title: ConfigApp.appName,
      theme: Themes().lightMode,
      darkTheme: Themes().darkMode,
      themeMode: ThemeService().getThemeMode(),
    );
  }
}
