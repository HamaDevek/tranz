import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iconsax/iconsax.dart';
import '../../app/models/item_model.dart';
import '../../services/theme_service.dart';
import 'package:get/get.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

class ShopCardComponent extends StatelessWidget {
  const ShopCardComponent({Key? key, required this.item}) : super(key: key);
  final ItemModel item;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).accentColor,
      child: InkWell(
        onTap: () {
          Get.toNamed('/single-item', arguments: item);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(16),
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: CachedNetworkImage(
                  imageUrl: item.picture?.isBlank ?? false
                      ? "${ConfigApp.placeholder}"
                      : "${ConfigApp.apiUrl}/public/uploads/item/${item.picture?[0]}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        // colorFilter:
                        //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
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
                      item.picture?.isBlank ?? false
                          ? "${ConfigApp.placeholder}"
                          : "${ConfigApp.apiUrl}/public/uploads/item/${item.picture?[0]}",
                      stalePeriod: const Duration(days: 15),
                      maxNrOfCacheObjects: 100,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Text(
                  '${item.name ?? "empty".tr}',
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 20,
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Text(
                  '${item.sellingPrice ?? "0"} ' + 'IQD'.tr,
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 20,
                    color: !ThemeService().isSavedDarkMode()
                        ? Color(0xFF1E272E)
                        : Colors.white,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
