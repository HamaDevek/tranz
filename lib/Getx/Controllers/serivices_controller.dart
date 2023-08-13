import 'package:get/get.dart';
import 'package:tranzhouse/Api/api_endpoints.dart';
import 'package:tranzhouse/Models/blogs_model.dart';
import 'package:tranzhouse/Models/response_model.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Utility/dio_plugin.dart';
import 'package:tranzhouse/Utility/endpoint.dart';
import 'package:tranzhouse/Utility/prints.dart';

class ServicesController extends GetxController {
  static ServicesController get to =>
      Get.find<ServicesController>(tag: "services-controller");

  @override
  void onInit() {
    super.onInit();
    getCities();
    getBlogs();
  }

  /////GET SERVICES//////
  ///
  // RxList<Service> services = <Service>[].obs;
  RxList<ServicesModel> serviceCategories = <ServicesModel>[].obs;
  RxBool servicesLoading = false.obs;

  Future<void> getServices() async {
    if (serviceCategories.isEmpty) {
      servicesLoading.value = true;
    }
    // final services = SetCache.instance.get('services');
    // if (services != null) {
    //   serviceCategories.addAll(
    //     (services as List)
    //         .map<ServicesModel>(
    //           (service) => ServicesModel.fromJson(service),
    //         )
    //         .toList(),
    //   );
    //   servicesLoading.value = false;
    // }
    // await Future.delayed(const Duration(milliseconds: 1000));
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().client.services,
      ),
    );

    if (res.isSuccess) {
      serviceCategories.addAll(
        (res.data['services'] as List)
            .map<ServicesModel>(
              (service) => ServicesModel.fromJson(service),
            )
            .toList(),
      );
      // SetCache.instance.save(res.data["services"], "services");
      prints(serviceCategories, tag: "success");
      // await Future.delayed(const Duration(milliseconds: 5000));
      servicesLoading.value = false;
    } else {
      prints(res.data, tag: "error");
      servicesLoading.value = false;
    }
  }

  ///////GET CITIES//////

  RxList<Category> cities = <Category>[].obs;

  Future<void> getCities() async {
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().cities,
      ),
    );

    if (res.isSuccess) {
      cities.value = (res.data['cities'] as List)
          .map<Category>(
            (city) => Category.fromJson(city),
          )
          .toList();
      prints(cities, tag: "success");
    } else {
      prints(res.data, tag: "error");
    }
  }
  ///////GET BLOGS//////

  RxList<BlogsModel> blogs = <BlogsModel>[].obs;
  RxBool blogsLoading = false.obs;

  Future<void> getBlogs() async {
    blogsLoading.value = true;
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().blogs,
      ),
    );

    if (res.isSuccess) {
      blogs.value = (res.data['blogs'] as List)
          .map<BlogsModel>(
            (blog) => BlogsModel.fromJson(blog),
          )
          .toList();
      prints(blogs, tag: "success");
      blogsLoading.value = false;
    } else {
      prints(res.data, tag: "error");
      blogsLoading.value = false;
    }
  }
}
