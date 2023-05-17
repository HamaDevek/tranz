import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

String? replaceKurdishNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const kurdish = ['۰', '۱', '۲', '۳', '٤', '٥', '٦', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], kurdish[i]);
  }
  return input;
}

String dateTimeFormat({required String date, String? format}) {
  return DateFormat(format ?? "dd-MM-yyyy hh:mm a").format(
    DateTime.parse(date).toLocal(),
  );
}

int? calculateDateWithNow(date) {
  return (date.difference(DateTime.now()).inDays * -1);
}

class MyCustomMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'Now'.tr;
  @override
  String aboutAMinute(int minutes) => 'Minute ago'.tr;
  @override
  String minutes(int minutes) {
    if (minutes == 1) {
      return 'Minute ago'.tr;
    }
    return "language.rtl".tr.parseBool
        ? 'Minutes ago'.trParams({
            'minutes': '${replaceKurdishNumber('$minutes')}',
          })
        : 'Minutes ago'.trParams({
            'minutes': '$minutes',
          });
    // return '$minutes ${'label.minutes.ago'.tr}';
  }

  @override
  String aboutAnHour(int minutes) => 'Hour ago';
  @override
  String hours(int hours) {
    if (hours == 1) {
      return 'Hour ago';
    }
    return "language.rtl".tr.parseBool
        ? 'Hours ago'.trParams({
            "hours": "${replaceKurdishNumber('$hours')}",
          })
        : 'Hours ago'.trParams({
            "hours": "$hours",
          });
    // return '$hours ${'label.hours.ago'.tr}';
  }

  @override
  String aDay(int hours) {
    return 'Yesterday'.tr;
  }

  @override
  String days(int days) {
    if (days == 1) {
      return 'Yesterday'.tr;
    }
    return "language.rtl".tr.parseBool
        ? 'Days ago'.trParams({
            "days": "${replaceKurdishNumber('$days')}",
          })
        : 'Days ago'.trParams({
            'days': '$days',
          });

    // return '$days ${'label.days.ago'.tr}';
  }

  @override
  String aboutAMonth(int days) => 'Month ago'.tr;
  @override
  String months(int months) {
    {
      if (months == 1) {
        return "Month ago".tr;
      }
      return "language.rtl".tr.parseBool
          ? 'Months ago'.trParams({
              'months': '${replaceKurdishNumber('$months')}',
            })
          : 'Months ago'.trParams({
              'months': '$months',
            });
      // return '$months ${'label.months.ago'.tr}';
    }
  }

  @override
  String aboutAYear(int year) => 'Year ago';
  @override
  String years(int years) {
    if (years == 1) {
      return 'Year ago'.tr;
    }
    return "language.rtl".tr.parseBool
        ? 'Years ago'.trParams({
            'years': '${replaceKurdishNumber('$years')}',
          })
        : 'Years ago'.trParams({
            'years': '$years',
          });
  }

  @override
  String wordSeparator() => ' '.tr;
}

void scrollToSelectedContent({GlobalKey? expansionTileKey,double? alignment}) {
  final keyContext = expansionTileKey?.currentContext;
  if (keyContext != null) {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      Scrollable.ensureVisible(
        
        keyContext,
        alignment:alignment?? 0.0,
        duration: const Duration(milliseconds: 250),
      );
    });
  }
}



isRtl() {
  return "language.rtl".tr.parseBool;
}


String formatPhoneNumber(int phoneNumber) {
  String phoneNumberString = phoneNumber.toString();

  return phoneNumberString.replaceAllMapped(
    RegExp(r'(\d{3})(\d{3})(\d{4})'),
    (Match match) => '+964 ${match[1]} ${match[2]} ${match[3]}',
  );
}


extension StringExtensionHelper on String {
  bool get parseBool => this == 'true';
}


