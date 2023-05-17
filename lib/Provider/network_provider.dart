import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Utility/prints.dart';

class NetworkProviderController extends GetxController {
  static NetworkProviderController get to => Get.find<NetworkProviderController>(tag: 'network');

  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  Rx<int> connectionType = 0.obs;

  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    _getConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> _getConnectionType() async {
    ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
      return _updateState(connectivityResult);
    } on PlatformException catch (e) {
      prints(e, tag: 'error');
    }
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
       
        connectionType(1);
        update();
        break;
      case ConnectivityResult.mobile:
       
        connectionType(2);
        update();
        break;
      case ConnectivityResult.none:
      
        connectionType(0);
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}
