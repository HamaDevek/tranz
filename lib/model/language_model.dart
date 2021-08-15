class LanguageModel {
  final String name;
  final String value;
  final String code;
  final String? direction;

  LanguageModel({
    required this.name,
    required this.value,
    required this.code,
    this.direction,
  });
}
