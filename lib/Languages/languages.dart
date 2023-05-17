import 'package:get/route_manager.dart';
import 'ar_iq.dart';
import 'en_us.dart';
import 'ku_so.dart';

class Languages extends Translations {

  Map <String,Map<String,String>> get keys=>{

     "en_US": enUs,
        "ar_SO": kuSor,
        "ar_IQ": arIq,

  };
}