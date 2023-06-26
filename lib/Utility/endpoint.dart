import 'package:tranzhouse/Utility/prints.dart';

import '../Models/url_param.dart';

Uri getUrl({required String key, List<UrlParam>? param}) {
  String apiUrl = 'https://tranz.kurdishmail.com/api/v1/';
  String endPoint = '$apiUrl$key';
  prints(endPoint, tag: "success");
  if (param?.isNotEmpty ?? false) {
    endPoint = '$endPoint?';
    for (var e in param!) {
      endPoint =
          '$endPoint${e.key}=${e.value}${param[param.length - 1].key != e.key ? '&' : ''}';
    }
  }
  return Uri.parse(endPoint);
}
