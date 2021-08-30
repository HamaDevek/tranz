import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:trancehouse/app/controllers/cart_controller.dart';
import 'package:trancehouse/app/models/item_model.dart';
import 'package:trancehouse/app/models/item_model.dart';
import 'package:trancehouse/components/button_custom_component.dart';
import 'package:trancehouse/components/no_glow_component.dart';
import 'package:trancehouse/services/theme_service.dart';
import 'package:trancehouse/utils/config.dart';
import 'package:trancehouse/utils/extentions.dart';

class SingleItemScreen extends StatefulWidget {
  const SingleItemScreen({Key? key}) : super(key: key);

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  ItemModel? item;
  int? counter;
  final CartController _cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    setState(() {
      item = Get.arguments;
      counter = _cartController.getItemFromCart(item!).amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: NoGlowComponent(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item!.picture?.isBlank ?? false
                            ? "${ConfigApp.placeholder}"
                            : "${ConfigApp.apiUrl}/public/uploads/item/${item!.picture?[0]}",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: Icon(
                            Iconsax.gallery,
                            size: 50,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Iconsax.gallery_slash,
                          size: 50,
                        ),
                        cacheManager: CacheManager(
                          Config(
                            item!.picture?.isBlank ?? false
                                ? "${ConfigApp.placeholder}"
                                : "${ConfigApp.apiUrl}/public/uploads/item/${item!.picture?[0]}",
                            stalePeriod: const Duration(days: 15),
                            maxNrOfCacheObjects: 100,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Text(
                        '${item!.itemInfo ?? "empty".tr}',
                        textAlign: 'language.rtl'.tr.parseBool
                            ? TextAlign.right
                            : TextAlign.left,
                        style: TextStyle(
                          fontFamily:
                              'language.rtl'.tr.parseBool ? "Rabar" : "",
                          fontSize: 20,
                          color: !ThemeService().isSavedDarkMode()
                              ? Color(0xFF1E272E)
                              : Colors.white,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(
                      height: 286,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.4),
                          spreadRadius: 6,
                          blurRadius: 7,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '${item!.name ?? "empty".tr} ',
                                    textAlign: 'language.rtl'.tr.parseBool
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'language.rtl'.tr.parseBool
                                          ? "Rabar"
                                          : "",
                                      fontSize: 20,
                                      color: !ThemeService().isSavedDarkMode()
                                          ? Color(0xFF1E272E)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    'language.rtl'.tr.parseBool
                                        ? Iconsax.arrow_left_2
                                        : Iconsax.arrow_right_3,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 270,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.4),
                        spreadRadius: 6,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width - 32,
                        color: ThemeService().isSavedDarkMode()
                            ? Color(0xFF222F3E)
                            : Theme.of(context).accentColor,
                        margin: EdgeInsets.only(bottom: 8),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                        width: double.infinity,
                        child: Text(
                          'ratio'.tr,
                          textAlign: 'language.rtl'.tr.parseBool
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontFamily:
                                'language.rtl'.tr.parseBool ? "Rabar" : "",
                            fontSize: 20,
                            color: !ThemeService().isSavedDarkMode()
                                ? Color(0xFF1E272E)
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Material(
                                      color: ThemeService().isSavedDarkMode()
                                          ? Color(0xFF222F3E)
                                          : Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(100),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        onTap: () {
                                          setState(() {
                                            counter = counter! + 1;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        '$counter',
                                        style: TextStyle(
                                          fontFamily:
                                              'language.rtl'.tr.parseBool
                                                  ? "Rabar"
                                                  : "",
                                          fontSize: 24,
                                          color:
                                              !ThemeService().isSavedDarkMode()
                                                  ? Color(0xFF1E272E)
                                                  : Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: ThemeService().isSavedDarkMode()
                                          ? Color(0xFF222F3E)
                                          : Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(100),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        onTap: () {
                                          setState(() {
                                            counter = counter! > 1
                                                ? counter! - 1
                                                : counter;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${(item?.sellingPrice ?? 0) * counter!} ' +
                                      'IQD'.tr,
                                  textAlign: 'language.rtl'.tr.parseBool
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'language.rtl'.tr.parseBool
                                        ? "Rabar"
                                        : "",
                                    fontSize: 24,
                                    color: !ThemeService().isSavedDarkMode()
                                        ? Color(0xFF1E272E)
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 32),
                        child: ButtonCustomComponent(
                          onPress: () async {
                            _cartController.addItem(item!, counter!);
                            // print(_cartController.cart);
                          },
                          child: Text(
                            'cart.add'.tr,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF1E272E),
                              fontFamily:
                                  'language.rtl'.tr.parseBool ? 'Rabar' : '',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
