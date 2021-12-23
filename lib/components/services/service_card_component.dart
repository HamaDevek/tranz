import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../app/controllers/service_api_controller.dart';
import '../../app/models/service_model.dart';
import '../../utils/config.dart';
import '../../../utils/extentions.dart';

class ServiceCardComponent extends StatefulWidget {
  const ServiceCardComponent({Key? key, required this.service})
      : super(key: key);

  final ServiceModel service;

  @override
  _ServiceCardComponentState createState() => _ServiceCardComponentState();
}

class _ServiceCardComponentState extends State<ServiceCardComponent> {
  final ServiceApiController _serviceApiController =
      Get.put(ServiceApiController());

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).accentColor,
      child: InkWell(
        onTap: () {
          if (_serviceApiController
                  .getchiled(widget.service.id!.toString())!
                  .length >
              0) {
            // Get.back();
            Get.toNamed('/subservice?${widget.service.id}',
                arguments: widget.service);
          } else {
            Get.toNamed('/subservice/blogs', arguments: widget.service);
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    '${widget.service.picture.isBlank ?? false ? ConfigApp.placeholder : "${ConfigApp.apiUrl}/public/uploads/category/${widget.service.picture}"}',
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
                    '${widget.service.picture.isBlank ?? false ? ConfigApp.placeholder : "${ConfigApp.apiUrl}/public/uploads/category/${widget.service.picture}"}',
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
                          '${widget.service.title?["x-lang".tr] ?? ""}',
                          style: TextStyle(
                            fontFamily:
                                'language.rtl'.tr.parseBool ? "Rabar" : "",
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
