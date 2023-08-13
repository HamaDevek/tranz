import 'package:get/get.dart';
import 'package:timeago/timeago.dart';
import 'package:tranzhouse/Utility/utility.dart';

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
  String aboutAMinute(int minutes) => 'A minute ago'.tr;
  @override
  String minutes(int minutes) {
    if (minutes == 1) {
      return 'A minute ago'.tr;
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
  String aboutAnHour(int minutes) => 'An hour ago';
  @override
  String hours(int hours) {
    if (hours == 1) {
      return 'An hour ago';
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

    // return '$days${'d ago'.tr}';
  }

  @override
  String aboutAMonth(int days) => 'A month ago'.tr;
  @override
  String months(int months) {
    {
      if (months == 1) {
        return "A month ago".tr;
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
  String aboutAYear(int year) => 'A year ago'.tr;
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
