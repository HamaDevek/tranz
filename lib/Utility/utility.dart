import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';
import 'package:tranzhouse/Models/services_model.dart';

import '../Models/product_model.dart';

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
        ? 'd ago'.trParams({
            "days": "${replaceKurdishNumber('$days')}",
          })
        : 'd ago'.trParams({
            'days': '$days',
          });

    // return '$days${'d ago'.tr}';
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

void scrollToSelectedContent({GlobalKey? expansionTileKey, double? alignment}) {
  final keyContext = expansionTileKey?.currentContext;
  if (keyContext != null) {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      Scrollable.ensureVisible(
        keyContext,
        alignment: alignment ?? 0.0,
        // alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
        duration: const Duration(milliseconds: 250),
      );
    });
  }
}

String formatPhoneNumber(int phoneNumber) {
  String phoneNumberString = phoneNumber.toString();

  return phoneNumberString.replaceAllMapped(
    RegExp(r'(\d{3})(\d{3})(\d{4})'),
    (Match match) => '+964 ${match[1]} ${match[2]} ${match[3]}',
  );
}

isRtl() {
  return "language.rtl".tr.parseBool;
}

extension StringExtensionHelper on String {
  bool get parseBool => this == 'true';
}

extension AppPadding on Widget {
  Widget symmetricPadding({
    double? vertical,
    double? horizontal,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical ?? 0,
        horizontal: horizontal ?? 0,
      ),
      child: this,
    );
  }

  Widget allPadding(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget directionalPadding({
    double? top,
    double? bottom,
    double? start,
    double? end,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        start: start ?? 0,
        end: end ?? 0,
      ),
      child: this,
    );
  }
}

extension DirectionalityExtension on Widget {
  Widget get ltr =>
      Directionality(textDirection: ui.TextDirection.ltr, child: this);
  Widget get rtl =>
      Directionality(textDirection: ui.TextDirection.rtl, child: this);
  Widget get matchDirectionality =>
      Transform.rotate(angle: isRtl() ? pi : 0, child: this);
}


extension IndexedIterable<E> on List<E> {
  List<T> mapIndexed<T>(T Function(int index, E element) f) {
    int index = 0;
    return map((element) => f(index++, element)).toList();
  }
}

String getTitlesProduct(ProductCategory category) {
    final String lang = "x-lang".tr;
    switch (lang) {
      case "ku":
        return category.nameKu.toString();
      case "ar":
        return category.nameAr.toString();
      case "en":
        return category.nameEn.toString();
      default:
        return category.nameKu.toString();
    }
  }
  String getTitlesCategory(Category category) {
    final String lang = "x-lang".tr;
    switch (lang) {
      case "ku":
        return category.nameKu.toString();
      case "ar":
        return category.nameAr.toString();
      case "en":
        return category.nameEn.toString();
      default:
        return category.nameKu.toString();
    }
  }
  String getText(LanguagesModel item) {
    final String lang = "x-lang".tr;
    switch (lang) {
      case "ku":
        return item.ku.toString();
      case "ar":
        return item.ar.toString();
      case "en":
        return item.en.toString();
      default:
        return item.ku.toString();
    }
  }


