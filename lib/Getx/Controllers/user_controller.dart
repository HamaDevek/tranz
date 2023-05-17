// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../Models/response_model.dart';
import '../../Models/url_param.dart';
import '../../Models/user_model.dart';
import '../../Utility/dio_plugin.dart';
import '../../Utility/endpoint.dart';
import '../../Utility/prints.dart';

class UserController extends GetxController {
  static UserController get to =>
      Get.find<UserController>(tag: 'user.controller');

  @override
  void onInit() {
    super.onInit();
    initUser();
  }

  final authStorage = GetStorage();
  Rx<UserModel>? user = UserModel().obs;

//////Get User Data
  void initUser() async {
    await authStorage.initStorage;
    final auth = await authStorage.read('auth');
    print("AUTH: $auth");

    if (auth != null) {
      user?.value = UserModel.fromJson(auth);
      prints("INIT USER: ${user?.value.toJson()}", tag: 'success');
      Future.delayed(const Duration(milliseconds: 500), () {
        me();
      });
    } else {
      user?.value = UserModel();
    }
  }

  /////**********************////////////
  ///////////////AUTH///////////////////

  Future<ResponseModel> login({
    required String identifier,
    required String password,
    required String userType,
  }) async {
    String firebaseToken =
        "e2ouNbLyEElBmMtU0o1tba:APA91bHS8Me0oMsb-U88FY3_0wkxmI5v3kf0rLoT7wkOtV1BDh8bu70AvQZgFrXUKV1MPhIX71Jk9BVFhzIyjJgbh0eGcf7HSP5hr7NY0twklFMcmy-UfcYh8a1KB2ZAqjGL8j-NKX0z";
    // if (GetPlatform.isIOS || GetPlatform.isAndroid) {
    //   firebaseToken = (await FirebaseMessaging.instance.getToken()).toString();
    // }
    print({
      "identifier": identifier,
      "password": password,
      "firebase_token": firebaseToken,
      "target": userType,
    });
    final res = await DioPlugin().requestWithDio(
        url: getUrl(key: 'auth'),
        data: mapToFormMap(
          {
            "identifier": identifier,
            "password": password,
            "firebase_token": firebaseToken,
            "target": userType,
          },
        ),
        method: 'POST');

    if (res.isSuccess) {
      user?.value = UserModel.fromJson(res.data['data']);
      prints("MY USER: ${user?.value.toJson()}", tag: 'success');
      if (user?.value.token != null) {
        authStorage.write('auth', user?.value.toJson());
      }
    } else {
      prints(
        'error message: ${res.data}',
        tag: 'error',
      );
    }
    return res;
  }

  Future<void> logOut() async {
    final res = await DioPlugin().requestWithDio(
      url: getUrl(key: "auth"),
      data: mapToFormMap({
        '_method': 'DELETE',
        "target":
            user?.value.userType == "UserType.driver" ? "driver" : "client",
      }),
      method: "POST",
    );

    if (res.isSuccess) {
      prints(res.data, tag: 'success');
      user?.value = UserModel();
      await authStorage.remove('auth');
      await authStorage.save();
    } else {
      prints(res.data, tag: 'error');
    }
    return;
  }

  Future<bool> me() async {
    print("ME ROUTE USERTYPE: ${user?.value.userType}");
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(key: 'auth'),
      param: {
        "target":
            user?.value.userType == "UserType.driver" ? "driver" : "client",
      },
      method: "GET",
    );

    if (res.isSuccess) {
      prints("ME ROUTE DATA: ${res.data}", tag: 'success');
      final accessToken = user?.value.token;
      final userType = user?.value.userType;
      // res.data['data']['token'] = accessToken;
      user?.value = UserModel.fromJson(res.data['data']);
      user?.value = user!.value.copyWith(token: accessToken);
      user?.value.userType = userType;

      authStorage.write("auth", user?.value.toJson());
      prints("ME ROUTE USER: $user", tag: 'success');
    } else {
      prints("ME ROUTE ERROR: ${res.data}", tag: 'error');
      logOut();
    }
    return res.isSuccess;
  }

 
  
  
}
