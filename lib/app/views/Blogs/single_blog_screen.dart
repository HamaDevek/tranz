import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/models/blog_model.dart';
import '../../../components/no_glow_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/config.dart';
import '../../../utils/extentions.dart';

class SingleBlogScreen extends StatefulWidget {
  const SingleBlogScreen({Key? key}) : super(key: key);

  @override
  _SingleBlogScreenState createState() => _SingleBlogScreenState();
}

class _SingleBlogScreenState extends State<SingleBlogScreen> {
  BlogModel? blog;
  @override
  void initState() {
    super.initState();
    setState(() {
      blog = Get.arguments;
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
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(blog!.createdAt ?? DateTime.now()),
                          textAlign: 'language.rtl'.tr.parseBool
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontFamily:
                                'language.rtl'.tr.parseBool ? "Rabar" : "",
                            fontSize: 14,
                            color: !ThemeService().isSavedDarkMode()
                                ? const Color(0xFF1E272E)
                                : const Color(0xff9D9D9D),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (blog!.link!.isNotEmpty) {
                            await canLaunch(blog?.link ?? '')
                                ? await launch(blog?.link ?? '',
                                    forceSafariVC: false)
                                : throw 'Could not launch :$blog!.link';
                          }
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              "${blog!.picture?.isBlank ?? false ? ConfigApp.placeholder : blog!.picture?[0]}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
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
                              '${blog!.picture?.isBlank ?? false ? ConfigApp.placeholder : blog!.picture?[0]}',
                              stalePeriod: const Duration(days: 15),
                              maxNrOfCacheObjects: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Text(
                        '${blog!.description?["x-lang".tr] ?? ""}',
                        textAlign: 'language.rtl'.tr.parseBool
                            ? TextAlign.right
                            : TextAlign.left,
                        style: TextStyle(
                          fontFamily:
                              'language.rtl'.tr.parseBool ? "Rabar" : "",
                          fontSize: 20,
                          color: !ThemeService().isSavedDarkMode()
                              ? const Color(0xFF1E272E)
                              : Colors.white,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Html(
                        data: blog!.html?["x-lang".tr],
                        onLinkTap: (String? url, RenderContext context,
                            attributes, element) async {
                          await canLaunch(url!)
                              ? await launch(url, forceSafariVC: false)
                              : throw 'Could not launch :$url';
                        },
                        style: {
                          '*': Style(
                            color: Theme.of(context).textTheme.headline4!.color,
                            fontFamily:
                                'language.rtl'.tr.parseBool ? "Rabar" : "",
                          )
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            Container(
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
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              'language.rtl'.tr.parseBool
                                  ? Iconsax.arrow_right_3
                                  : Iconsax.arrow_left_2,
                            )),
                        Expanded(
                          child: Text(
                            '${blog!.title?["x-lang".tr] ?? ""} ',
                            textAlign: 'language.rtl'.tr.parseBool
                                ? TextAlign.left
                                : TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'language.rtl'.tr.parseBool
                                  ? "Rabar"
                                  : "",
                              fontSize: 20,
                              color: !ThemeService().isSavedDarkMode()
                                  ? const Color(0xFF1E272E)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
