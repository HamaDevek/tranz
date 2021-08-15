extension StringExtensionHelper on String {
  bool get parseBool => this == 'true';
  String get capitalize => this[0].toUpperCase() + this.substring(1);
  String get firstUpperCase =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}
