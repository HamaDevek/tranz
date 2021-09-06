import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:iconsax/iconsax.dart';
import '../../app/models/service_model.dart';
import '../../services/theme_service.dart';
import 'package:get/get.dart';
import '../../utils/config.dart';
import '../../utils/extentions.dart';

class ServiceCardComponent extends StatelessWidget {
  const ServiceCardComponent({Key? key}) : super(key: key);
  // final ServiceModel service;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).accentColor,
      child: InkWell(
        onTap: () {
          // Get.toNamed('/single-item', arguments: item);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: '${ConfigApp.placeholder}',
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
                    '${ConfigApp.placeholder}',
                    stalePeriod: const Duration(days: 15),
                    maxNrOfCacheObjects: 100,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      // Colors.black.withOpacity(.3),
                      Colors.black.withOpacity(.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          'خزمەتگوزاریەکان',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
