import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../Theme/theme.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.isCircle = false,
    this.border,
    this.borderRadius = 12,
    this.fit,
    this.alignment,
    this.imageFile,
    this.placeholder,
  });
  final String? imageUrl;
  final double? height;
  final double? width;
  final double borderRadius;
  final bool isCircle;
  final BoxBorder? border;
  final BoxFit? fit;
  final File? imageFile;
  final Alignment? alignment;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        // border: border,
        borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: imageFile != null
          ? Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: border,
                borderRadius:
                    isCircle ? null : BorderRadius.circular(borderRadius),
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              ),
              child: ClipRRect(
                borderRadius: isCircle
                    ? BorderRadius.circular(1000)
                    : BorderRadius.circular(borderRadius),
                child: Image.file(
                  imageFile!,
                  alignment: alignment ?? Alignment.center,
                  fit: fit ?? BoxFit.cover,
                  isAntiAlias: true,
                  width: width,
                  height: height,
                ),
              ),
            )
          : CachedNetworkImage(
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
              imageUrl: imageUrl ?? '',
              alignment: alignment ?? Alignment.center,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  border: border,
                  borderRadius:
                      isCircle ? null : BorderRadius.circular(borderRadius),
                  shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit ?? BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: placeholder != null
                  ? (context, url, error) => placeholder!
                  : (context, url, error) => const DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorPalette.whiteColor,
                        ),
                        child: Icon(
                          CupertinoIcons.person_solid,
                          size: 60,
                          color: ColorPalette.primary,
                        ),
                      ),
              cacheManager: CacheManager(
                Config(
                  imageUrl ?? '',
                  stalePeriod: const Duration(days: 15),
                  maxNrOfCacheObjects: 100,
                ),
              ),
            ),
    );
  }
}
