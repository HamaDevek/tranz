import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tranzhouse/Getx/Controllers/admin_controller.dart';
import 'package:tranzhouse/Getx/Controllers/client_controller.dart';
import 'package:tranzhouse/Getx/Controllers/product_controller.dart';
import 'package:tranzhouse/Getx/Controllers/serivices_controller.dart';
import 'package:tranzhouse/Notifications/notification_manager.dart';

import '../../Provider/network_provider.dart';
import '../Controllers/language_controller.dart';
import '../Controllers/user_controller.dart';

class BindingManager extends Bindings {
  @override
  Future<void> dependencies() async {
    // await SetCache.instance.init();
    await GetStorage.init();
    await dotenv.load(fileName: ".env");
    Get.put(LanguageController(), tag: 'language', permanent: true);
    Get.put(UserController(), tag: 'user.controller', permanent: true);
    Get.put(NetworkProviderController(), tag: 'network', permanent: true);
    NotificationManager().onInit();
    Get.put(ServicesController(), tag: "services-controller", permanent: true);
    Get.put(ProductsController(), tag: "products-controller", permanent: true);
    Get.put(ClientController(), tag: "client-controller", permanent: true);
    Get.put(AdminController(), tag: "admin-controller", permanent: true);
  }
}
