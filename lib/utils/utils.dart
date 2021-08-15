import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';

Future<String> initPlatformState() async {
  String platformImei = 'Unknown';
  try {
    if (io.Platform.isAndroid) {
      platformImei = await ImeiPlugin.getId();
    } else if (io.Platform.isIOS) {
      platformImei = await ImeiPlugin.getImei();
    }
  } on PlatformException {
    platformImei = 'Failed to get Device Imei Address.';
  }
  return platformImei;
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
