import 'package:intl/intl.dart';

extension StringExtensionHelper on String {
  bool get parseBool => this == 'true';
  String get capitalize => this[0].toUpperCase() + substring(1);
  String get firstUpperCase =>
      split(" ").map((str) => str.capitalize).join(" ");
}

extension IntExtensionHelper on int {
  String get parseToCurrency => NumberFormat.decimalPattern().format(this);
}
