import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:trancehouse/enums/connectivity_status.dart';

class NetworkManagerController extends GetxController {
  ConnectivityStatus connectivityType = ConnectivityStatus.offline;
  final Connectivity _connectivity = Connectivity();
  @override
  void onInit() {
    super.onInit();
    getConnectionType();
    _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectionType() async {
    ConnectivityResult? connectivityResualt;
    try {
      connectivityResualt = await _connectivity.checkConnectivity();
    } catch (e) {
      Get.snackbar('Network Error', 'Failed to get network status');
    }
    return _updateState(connectivityResualt!);
  }

  void _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectivityType = ConnectivityStatus.wifi;
        update();
        break;
      case ConnectivityResult.mobile:
        connectivityType = ConnectivityStatus.celluler;
        update();
        break;
      case ConnectivityResult.none:
        connectivityType = ConnectivityStatus.offline;
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get network status');
        break;
    }
  }
}
