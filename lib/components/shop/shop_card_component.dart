import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iconsax/iconsax.dart';
import '../../app/models/item_model.dart';
import '../../services/theme_service.dart';
import 'package:get/get.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

class ShopCardComponent extends StatefulWidget {
  const ShopCardComponent({Key? key, required this.item}) : super(key: key);

  final ItemModel item;

  @override
  _ShopCardComponentState createState() => _ShopCardComponentState();
}

class _ShopCardComponentState extends State<ShopCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: () {
          Get.toNamed('/single-item', arguments: widget.item);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 1000,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // margin: EdgeInsets.all(16),
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.item.picture?.isBlank ?? false
                      ? ConfigApp.placeholder
                      : "${ConfigApp.apiUrl}/public/uploads/item/${widget.item.picture?[0]}",
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
                  placeholder: (context, url) => const Center(
                    child: Icon(
                      Iconsax.gallery,
                      size: 50,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Iconsax.gallery_slash,
                    size: 50,
                  ),
                  cacheManager: CacheManager(
                    Config(
                      widget.item.picture?.isBlank ?? false
                          ? ConfigApp.placeholder
                          : "${ConfigApp.apiUrl}/public/uploads/item/${widget.item.picture?[0]}",
                      stalePeriod: const Duration(days: 15),
                      maxNrOfCacheObjects: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: double.infinity,
                child: Text(
                  '${widget.item.localizeName?["x-lang".tr] ?? ""}',
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 20,
                    color: !ThemeService().isSavedDarkMode()
                        ? const Color(0xFF1E272E)
                        : Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Text(
                  '${widget.item.sellingPrice?.parseToCurrency ?? "0"} ' +
                      'IQD'.tr,
                  textAlign: 'language.rtl'.tr.parseBool
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                    fontSize: 16,
                    color: !ThemeService().isSavedDarkMode()
                        ? const Color(0xFF1E272E)
                        : Colors.white,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
