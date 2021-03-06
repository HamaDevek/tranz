import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../app/models/blog_model.dart';
import '../../services/theme_service.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

class BlogComponent extends StatelessWidget {
  const BlogComponent({Key? key, required this.blog}) : super(key: key);
  final BlogModel blog;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          splashColor: Theme.of(context).primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            blog.toMap();
            Get.toNamed('/single-blog', arguments: blog);
          },
          child: Container(
            height: 365,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "${blog.picture?.isBlank ?? false ? ConfigApp.placeholder : blog.picture?[0]}",
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
                        '${blog.picture?.isBlank ?? false ? ConfigApp.placeholder : blog.picture?[0]}',
                        stalePeriod: const Duration(days: 15),
                        maxNrOfCacheObjects: 100,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _listTitle,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 100,
                    child: Text(
                      '${blog.description?["x-lang".tr] ?? ""}',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get _listTitle {
    return [
      Expanded(
        child: Text(
          '${blog.title?["x-lang".tr] ?? ""}',
          textAlign:
              'language.rtl'.tr.parseBool ? TextAlign.right : TextAlign.left,
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
      Text(
        DateFormat('yyyy-MM-dd').format(blog.createdAt ?? DateTime.now()),
        style: TextStyle(
          fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
          fontSize: 14,
          color: !ThemeService().isSavedDarkMode()
              ? const Color(0xFF1E272E)
              : const Color(0xff9D9D9D),
        ),
      )
    ];
  }
}
