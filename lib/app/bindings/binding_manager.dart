import 'package:get/get.dart';
import 'package:trancehouse/app/controllers/language_controller.dart';
import 'package:trancehouse/app/controllers/network_manager_controller.dart';
import 'package:trancehouse/app/controllers/webinfo_api_controller.dart';

class BindingManager extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkManagerController>(() => NetworkManagerController());
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<WebinfoApiController>(() => WebinfoApiController());
  }
}
