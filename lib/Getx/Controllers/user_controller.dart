// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:tranzhouse/Api/api_endpoints.dart';
import 'package:tranzhouse/Models/url_param.dart';
import 'package:tranzhouse/Pages/Client/Main%20Page/main_page.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import '../../Models/response_model.dart';
import '../../Models/user_model.dart';
import '../../Utility/dio_plugin.dart';
import '../../Utility/endpoint.dart';
import '../../Utility/prints.dart';
import 'package:dio/dio.dart' as dios;

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
        if (user?.value.user?.employee != null &&
            user?.value.user?.employee == true) {
          employeeMe();
        } else {
          me();
        }
      });
    } else {
      user?.value = UserModel();
    }
  }

  /////**********************////////////
  ///////////////AUTH///////////////////
  bool isUserLoggedin() {
    return user?.value.token != null;
  }

///////////////////////////////////////////
  ///PROFILE INFO VALIDATION////////////////
  RxBool isProfileInfoChanged = false.obs;
  RxBool isUserNameChanged = false.obs;
  RxBool isUserImageChanged = false.obs;
  // RxBool isUserPhoneChanged = false.obs;
  RxBool isUserAddressChanged = false.obs;
  void isNameChanged({required String name}) {
    if (user?.value.user?.name != name) {
      isUserNameChanged.value = true;
    } else {
      isUserNameChanged.value = false;
    }
    isProfileChanged();
  }

  // void isPhoneChanged({required String phone}) {
  //   if (user?.value.user?.phone != "+964${phone.replaceAll(' ', '').trim()}") {
  //     isUserPhoneChanged.value = true;
  //   } else {
  //     isUserPhoneChanged.value = false;
  //   }
  //   isProfileChanged();
  // }

  void isImageChanged({required String? image}) {
    if (image != null && image.isNotEmpty) {
      isUserImageChanged.value = true;
    } else {
      isUserImageChanged.value = false;
    }
    isProfileChanged();
  }

  void isAddressChanged({required String address}) {
    if (user?.value.user?.address != address) {
      isUserAddressChanged.value = true;
    } else {
      isUserAddressChanged.value = false;
    }
    isProfileChanged();
  }

  void isProfileChanged() {
    if (isUserNameChanged.value ||
        isUserImageChanged.value ||
        isUserAddressChanged.value) {
      isProfileInfoChanged.value = true;
    } else {
      isProfileInfoChanged.value = false;
    }
  }

  void resetValues() {
    isUserNameChanged.value = false;

    isUserImageChanged.value = false;
    isProfileInfoChanged.value = false;
  }

///////////FIREBASE VERIFY PHONE/////////////////////
///////////////////////////////////////////
///////////////////////////////////////////

  Future<String?> firebaseVerifyPhoneNumber(String phone) async {
    print('fbVerifyPhoneNumber($phone)');
    Completer<String?> completer = Completer();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+964${phone.replaceAll(' ', '').trim()}",
      // '+44 7123 123 456',
      verificationCompleted: (PhoneAuthCredential credential) {
        if (!completer.isCompleted) {
          completer.complete(credential.verificationId);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        completer.complete(null);
        print('FirebaseAuthException:${e.message}');
        Get.showSnackbar(GetSnackBar(
          title: 'OTP Error',
          message: e.message ?? 'Something went wrong!',
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorPalette.red,
          snackStyle: SnackStyle.GROUNDED,
        ));
      },
      codeSent: (String verificationId, int? resendToken) {
        print('codeSent: $verificationId');
        if (!completer.isCompleted) {
          completer.complete(verificationId);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return completer.future;
  }

///////////////////////////////////////////
///////////////////////////////////////////

  Future<ResponseModel> updateProfile({
    required String name,
    required String address,
    required File? image,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "address": address,
    };

    if (image != null) {
      body['file'] = await dios.MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
        contentType: MediaType('image', 'png'),
      );
    }
    dios.FormData formData = dios.FormData.fromMap(body);

    print("BODY: $body");
    final res = await DioPlugin().requestWithDio(
      url: getUrl(key: ApiEndpoint().client.updateProfile),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'multipart/form-data',
        // 'x-lang': 'x-lang'.tr,
      },

      // data: mapToFormMap(body),
      object: formData,
      method: RequestType.POST,
    );

    if (res.isSuccess) {
      prints("USER DATA: ${res.data}", tag: 'success');
      await me();
      Get.snackbar(
        'Success',
        // "${res.data}",
        'Profile updated successfully',
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorPalette.green,
        snackStyle: SnackStyle.FLOATING,
        colorText: ColorPalette.whiteColor,
        borderRadius: 10,
      );
    } else {
      prints('ERROR MESSAGE: ${res.data}', tag: 'error');
      Get.snackbar(
        'Error',
        res.data['error'] ?? 'Something went wrong!',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorPalette.red,
        colorText: ColorPalette.whiteColor,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
      );
    }
    return res;
  }
///////////////////////////////////////////
///////////////////////////////////////////

  Future<ResponseModel> signUp({
    required String name,
    required String phone,
    required String code,
    required String sessionInfo,
    required String password,
    required String address,
  }) async {
    final res = await DioPlugin().requestWithDio(
      url: getUrl(
        key: ApiEndpoint().signUp,
      ),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'x-lang': 'x-lang'.tr,
      },
      object: json.encode(
        // mapToFormMap(
        {
          "name": name,
          "phone": "+964$phone",
          "code": code,
          "session_info": sessionInfo,
          "password": password,
          "address": address,
        },
        // ),
      ),
      method: RequestType.POST,
    );

    if (res.isSuccess) {
      prints("USER DATA: ${res.data}", tag: 'success');
      user?.value = UserModel.fromJson(res.data);
      authStorage.write('auth', user?.value.toJson());
      Get.snackbar(
        'Success',
        'Account created successfully',
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorPalette.green,
        snackStyle: SnackStyle.FLOATING,
        colorText: ColorPalette.whiteColor,
        borderRadius: 10,
      );
    } else {
      prints('ERROR MESSAGE: ${res.data}', tag: 'error');
      Get.snackbar(
        'Error',
        res.data['error'] ?? 'Something went wrong!',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorPalette.red,
        colorText: ColorPalette.whiteColor,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
      );
    }

    return res;
  }

///////////////////////////////////////////
///////////////////////////////////////////
  Future<ResponseModel> login({
    required String phone,
    required String password,
  }) async {
    final res = await DioPlugin().requestWithDio(
      url: getUrl(key: ApiEndpoint().login),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'x-lang': 'x-lang'.tr,
      },
      object: {
        "phone": "+964$phone",
        "password": password,
      },
      method: RequestType.POST,
    );

    if (res.isSuccess) {
      prints("USER DATA: ${res.data}", tag: 'success');
      user?.value = UserModel.fromJson(res.data);
      authStorage.write('auth', user?.value.toJson());
    } else {
      prints('ERROR MESSAGE: ${res.data}', tag: 'error');
      Get.snackbar(
        'Error',
        res.data['error'] ?? 'Something went wrong!',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorPalette.red,
        colorText: ColorPalette.whiteColor,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
      );
    }
    return res;
  }

  Future<ResponseModel> employeeLogin({
    required String email,
    required String password,
  }) async {
    final res = await DioPlugin().requestWithDio(
      url: getUrl(key: ApiEndpoint().login),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'x-lang': 'x-lang'.tr,
      },
      object: {
        "phone": email,
        "password": password,
      },
      method: RequestType.POST,
    );

    if (res.isSuccess) {
      prints("USER DATA: ${res.data}", tag: 'success');
      user?.value = UserModel.fromJson(res.data);
      authStorage.write('auth', user?.value.toJson());
    } else {
      prints('ERROR MESSAGE: ${res.data}', tag: 'error');
      Get.snackbar(
        'Error',
        res.data['error'] ?? 'Something went wrong!',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorPalette.red,
        colorText: ColorPalette.whiteColor,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
      );
    }
    return res;
  }

  void logOut() async {
    // final res = await DioPlugin().requestWithDio(
    //   url: getUrl(key: "auth"),
    //   data: mapToFormMap({
    //     '_method': 'DELETE',
    //     // "target":
    //     //     user?.value.userType == "UserType.driver" ? "driver" : "client",
    //   }),
    //   method: "POST",
    // );

    // if (res.isSuccess) {
    // prints(res.data, tag: 'success');
    user?.value = UserModel();
    await authStorage.remove('auth');
    await authStorage.save();
    Get.offAllNamed(ClientMainPage.routeName);
    // } else {
    // prints(res.data, tag: 'error');
    // }
    // return;
  }

  //////////////////////////
  /// PHONE TAKEN
  /// ///////////////////////
  RxBool isPhoneTaken = false.obs;

  Future<ResponseModel> phoneTaken({
    required String phone,
  }) async {
    final res = await DioPlugin().requestWithDio(
      url: getUrl(key: ApiEndpoint().client.phoneTaken, param: [
        UrlParam(
          key: "phone",
          value: "964$phone",
        ),
      ]),
      method: RequestType.GET,
    );

    if (res.isSuccess) {
      prints("PHONE TAKEN: ${res.data}", tag: 'success');
      if (res.data['phoneTaken'] != null && res.data['phoneTaken'] == true) {
        isPhoneTaken.value = true;
        Get.showSnackbar(const GetSnackBar(
          titleText: TextWidget("Number taken"),
          messageText: TextWidget("This Phone number is already taken"),
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorPalette.red,
          snackStyle: SnackStyle.FLOATING,
          borderRadius: 10,
        ));
      } else {
        isPhoneTaken.value = false;
      }
    } else {
      prints("PHONE TAKEN: ${res.data}", tag: 'error');
    }
    return res;
  }

  Future<bool> me() async {
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(key: ApiEndpoint().me),
      method: RequestType.GET,
    );

    if (res.isSuccess) {
      prints("ME ROUTE DATA: ${res.data}", tag: 'success');
      final accessToken = user?.value.token;
      // res.data['data']['token'] = accessToken;
      user?.value = UserModel.fromJson(res.data);
      user?.value = user!.value.copyWith(token: accessToken);

      authStorage.write("auth", user?.value.toJson());
      prints("ME ROUTE USER: $user", tag: 'success');
    } else {
      prints("ME ROUTE ERROR: ${res.data}", tag: 'error');
      logOut();
    }
    return res.isSuccess;
  }

  Future<bool> employeeMe() async {
    ResponseModel res = await DioPlugin().requestWithDio(
      url: getUrl(key: ApiEndpoint().admin.employeeMe),
    );

    if (res.isSuccess) {
      prints("ME EMPLOYEE ROUTE DATA: ${res.data}", tag: 'success');
      final accessToken = user?.value.token;
      // res.data['data']['token'] = accessToken;
      user?.value = UserModel.fromJson(res.data);
      user?.value = user!.value.copyWith(token: accessToken);

      authStorage.write("auth", user?.value.toJson());
      prints("ME EMPLOYEE ROUTE USER: $user", tag: 'success');
    } else {
      prints("ME EMPLOYEE ROUTE ERROR: ${res.data}", tag: 'error');
      logOut();
    }
    return res.isSuccess;
  }
}
