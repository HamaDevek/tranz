import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'Getx/Binding/binding.dart';
import 'Languages/languages.dart';
import 'Pages/Splash/splash_page.dart';
import 'Routes/routes.dart';
import 'Theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const MyApp());
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
  MaterialAppWithProviderState createState() => MaterialAppWithProviderState();
}

class MaterialAppWithProviderState extends State<MaterialAppWithProvider> {
  late Locale lang = const Locale("en_US");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: context.isTablet,
        breakpoints: context.isTablet
            ? const [
                ResponsiveBreakpoint.autoScale(480,
                    name: MOBILE, scaleFactor: 0.8),
                ResponsiveBreakpoint.autoScale(800,
                    name: TABLET, scaleFactor: 1.2),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(1024,
                    name: TABLET, scaleFactor: 1.7),
                ResponsiveBreakpoint.autoScale(2460,
                    name: '4K', scaleFactor: 1.4),
              ]
            : [],
        background: Container(
          color: const Color(0xFFF5F5F5),
        ),
      ),
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: lang,
      fallbackLocale: lang,
      initialBinding: BindingManager(),
      getPages: RouteNames.routes,
      initialRoute: SplashPage.routeName,
      title: "Tranz House",
      theme: theme,
    );
  }
}
