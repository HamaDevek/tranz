import 'package:get/get.dart';

import '../languages/ar_iq.dart';
import '../languages/en_us.dart';
import '../languages/ku_sor.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": enUs,
        "ar_SO": kuSor,
        "ar_IQ": arIq,
      };
}
