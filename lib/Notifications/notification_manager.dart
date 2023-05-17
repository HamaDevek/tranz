import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Theme/theme.dart';
import '../Utility/prints.dart';

class NotificationManager {
  static Completer<bool> isInitialized = Completer<bool>();
  onInit() async {

    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    if (GetPlatform.isIOS) {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.getToken().then((value) {
      prints('firebaseToken: ${value.toString()}', tag: 'success');
    });

    if (initialMessage != null) {
      print('INITIAL MESSAGE: ${initialMessage.data}');
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen(onMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void onMessage(RemoteMessage message) {
    if (Platform.isIOS) {
      return;
    }
    prints('onMessage: ${message.data}', tag: "success");

    // if (Get.isSnackbarOpen == true) {
    //   Get.close(1);
    // }

    Get.showSnackbar(GetSnackBar(
      title: message.notification?.title ?? '',
      message: message.notification?.body ?? '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorPalette.yellow,
      isDismissible: true,
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      boxShadows: [
        BoxShadow(
          offset: const Offset(0, 3),
          blurRadius: 5,
          color: Colors.grey.shade300,
        )
      ],
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      onTap: (GetSnackBar snack) {
        prints("close snackbar ${message.data}", tag: "success");
        _handleMessage(message);
        Get.closeCurrentSnackbar();
      },
    ));
  }

  void _handleMessage(RemoteMessage message) async {
    prints('MESSAGE HANDLE: ${message.data}', tag: "success");
    // await isInitialized.future;
    NotificationListenerController.instance().notifyAllListeners(message.data);
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}

class NotificationListenerController {
  static NotificationListenerController? _controller;
  static NotificationListenerController instance() {
    _controller ??= NotificationListenerController();
    return _controller!;
  }

  void notifyAllListeners(Map data) {
    for (var element in listeners) {
      element(data);
    }
  }

  List<Function(Map)> listeners = [];

  removeListeners() {
    listeners.clear();
  }

  removeListener(Function(Map) listener) {
    listeners.remove(listener);
  }
}
