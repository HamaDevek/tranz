import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../app/controllers/cart_controller.dart';
import '../../app/models/item_model.dart';
import '../../services/theme_service.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

class CartItemComponent extends StatefulWidget {
  const CartItemComponent({Key? key, required this.item}) : super(key: key);
  final ItemModel item;

  @override
  _CartItemComponentState createState() => _CartItemComponentState();
}

class _CartItemComponentState extends State<CartItemComponent> {
  final CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 130,
            width: 150,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.item.localizeName?["x-lang".tr] ?? ""}',
                          textAlign: 'language.rtl'.tr.parseBool
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontFamily:
                                'language.rtl'.tr.parseBool ? "Rabar" : "",
                            fontSize: 16,
                            color: !ThemeService().isSavedDarkMode()
                                ? const Color(0xFF1E272E)
                                : Colors.white,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _cartController.deleteCartList(widget.item);
                        },
                        child: const Icon(
                          Iconsax.trash,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ((widget.item.sellingPrice ?? 0) * (widget.item.amount ?? 0)).parseToCurrency,
                        textAlign: 'language.rtl'.tr.parseBool
                            ? TextAlign.right
                            : TextAlign.left,
                        style: TextStyle(
                          fontFamily:
                              'language.rtl'.tr.parseBool ? "Rabar" : "",
                          fontSize: 16,
                          color: !ThemeService().isSavedDarkMode()
                              ? const Color(0xFF1E272E)
                              : Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                _cartController.incrementAmount(widget.item);
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '${widget.item.amount}',
                              style: TextStyle(
                                fontFamily: 'language.rtl'.tr.parseBool
                                    ? "Rabar"
                                    : "",
                                fontSize: 16,
                                color: !ThemeService().isSavedDarkMode()
                                    ? const Color(0xFF1E272E)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Material(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                _cartController.decrementAmount(widget.item);
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
