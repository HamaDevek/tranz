import 'dart:developer';
import 'dart:io' as io;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Future<String> getDeviceIdentifier() async {
  String identifier = 'Unknowen';
  var deviceInfo = DeviceInfoPlugin();

  try {
    if (io.Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      identifier = androidInfo.androidId ?? "Unknowen";
    } else if (io.Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      identifier = iosInfo.identifierForVendor ?? "Unknowen";
    }
  } on PlatformException {
    log('Failed to get platform version');
  }
  return identifier;
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

bool checkIfIpad(BuildContext context) {
  if (screenWidth(context) > 600) {
    return true;
  } else {
    return false;
  }
}

String? replaceKurdishNumber(String input) {
  final english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  final kurdish = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  for (int i = 0; i < english.length; i++) {
    input.toString().replaceAll(english[i], kurdish[i]);
  }
  return input;
}

bool isEnglish(String name) {
  return (name.codeUnitAt(0) >= 97 && name.codeUnitAt(0) <= 122) ||
      (name.codeUnitAt(0) >= 65 && name.codeUnitAt(0) <= 90);
}

String convertStrToDate(String date) =>
    DateFormat("yyyy-MM-dd hh:mm a").format(DateTime.parse(date));
