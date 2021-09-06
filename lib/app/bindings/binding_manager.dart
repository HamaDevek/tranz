import 'package:get/get.dart';
import '../../app/controllers/language_controller.dart';
import '../../app/controllers/network_manager_controller.dart';
import '../../app/controllers/webinfo_api_controller.dart';

class BindingManager extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkManagerController>(() => NetworkManagerController());
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<WebinfoApiController>(() => WebinfoApiController());
  }
}
