import '../Api/api_endpoints.dart';
import '../Models/url_param.dart';

Uri getUrl({required String key, List<UrlParam>? param}) {
  String apiUrl = 'https://redpack.kurdishmail.com/api/';
  String endPoint = '$apiUrl${api[key]}';
  if (param?.isNotEmpty ?? false) {
    endPoint = '$endPoint?';
    for (var e in param!) {
      endPoint =
          '$endPoint${e.key}=${e.value}${param[param.length - 1].key != e.key ? '&' : ''}';
    }
  }
  // localStorage.
  return Uri.parse(endPoint);
}
