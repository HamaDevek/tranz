import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:dio/dio.dart' as dios;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/product_model.dart';

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

String? replaceKurdishNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const kurdish = ['۰', '۱', '۲', '۳', '٤', '٥', '٦', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], kurdish[i]);
  }
  return input;
}

String dateTimeFormat({required String date, String? format}) {
  return DateFormat(format ?? "dd-MM-yyyy hh:mm a").format(
    DateTime.parse(date).toLocal(),
  );
}

int? calculateDateWithNow(date) {
  return (date.difference(DateTime.now()).inDays * -1);
}

void scrollToSelectedContent({GlobalKey? expansionTileKey, double? alignment}) {
  final keyContext = expansionTileKey?.currentContext;
  if (keyContext != null) {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      Scrollable.ensureVisible(
        keyContext,
        alignment: alignment ?? 0.0,
        // alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
        duration: const Duration(milliseconds: 250),
      );
    });
  }
}

void launchPhoneCall(String phone) async {
  final launchUri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    print("Can't launch ${launchUri.toString()}");
  }
}

String formatPhoneNumber(int phoneNumber, {bool withCountryCode = true}) {
  String phoneNumberString = phoneNumber.toString();

  return phoneNumberString.replaceAllMapped(
    RegExp(r'(\d{3})(\d{3})(\d{4})'),
    withCountryCode
        ? (Match match) => '+964 ${match[1]} ${match[2]} ${match[3]}'
        : (Match match) => '${match[1]} ${match[2]} ${match[3]}',
  );
}

isRtl() {
  return "language.rtl".tr.parseBool;
}

extension StringExtensionHelper on String {
  bool get parseBool => this == 'true';
}

extension AppPadding on Widget {
  Widget symmetricPadding({
    double? vertical,
    double? horizontal,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical ?? 0,
        horizontal: horizontal ?? 0,
      ),
      child: this,
    );
  }

  Widget allPadding(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget directionalPadding({
    double? top,
    double? bottom,
    double? start,
    double? end,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        start: start ?? 0,
        end: end ?? 0,
      ),
      child: this,
    );
  }
}

extension DirectionalityExtension on Widget {
  Widget get ltr =>
      Directionality(textDirection: ui.TextDirection.ltr, child: this);
  Widget get rtl =>
      Directionality(textDirection: ui.TextDirection.rtl, child: this);
  Widget get matchDirectionality =>
      Transform.rotate(angle: isRtl() ? pi : 0, child: this);
}

extension IndexedIterable<E> on List<E> {
  List<T> mapIndexed<T>(T Function(int index, E element) f) {
    int index = 0;
    return map((element) => f(index++, element)).toList();
  }
}

String getTitlesProduct(ProductCategory category) {
  final String lang = "x-lang".tr;
  switch (lang) {
    case "ku":
      return category.nameKu.toString();
    case "ar":
      return category.nameAr.toString();
    case "en":
      return category.nameEn.toString();
    default:
      return category.nameKu.toString();
  }
}

String getTitlesCategory(Category category) {
  final String lang = "x-lang".tr;
  switch (lang) {
    case "ku":
      return category.nameKu.toString();
    case "ar":
      return category.nameAr.toString();
    case "en":
      return category.nameEn.toString();
    default:
      return category.nameKu.toString();
  }
}

String getText(LanguagesModel item) {
  final String lang = "x-lang".tr;
  switch (lang) {
    case "ku":
      return item.ku.toString();
    case "ar":
      return item.ar.toString();
    case "en":
      return item.en.toString();
    default:
      return item.ku.toString();
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length == 1 &&
          (newValue.text == separator || newValue.text == '0')) {
        return const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

//CHECK IF URL IS IMAGE OR NOT
bool isImage(String url) {
  final List<String> imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'heic',
    'heif',
    'bmp',
    'svg',
    'ico',
    'tiff',
    'tif',
    'raw',
    'psd',
  ];
  final String extensionUrl = url.split('.').last;
  return imageExtensions.contains(extensionUrl);
}

enum UrlType { image, video, unknown }

extension UrlTypeExtension on String {
  String get urlType {
    Uri uri = Uri.parse(this);
    String typeString = uri.path.split(".").last.toString().toLowerCase();
    if (typeString == "jpg" ||
        typeString == "png" ||
        typeString == "jpeg" ||
        typeString == "webp") {
      return UrlType.image.name;
    }
    if (typeString == "mp4" || typeString == "mov" || typeString == "avi") {
      return UrlType.video.name;
    } else {
      return UrlType.unknown.name;
    }
  }
}

Future<String> imageToBase64(File imageFile) async {
  return base64Encode(imageFile.readAsBytesSync());
}

Future<dios.Response> sendForm(
    String url, Map<String, dynamic> data, Map<String, File> files) async {
  Map<String, dios.MultipartFile> fileMap = {};
  for (MapEntry fileEntry in files.entries) {
    File file = fileEntry.value;
    String fileName = file.path.split('/').last;
    fileMap[fileEntry.key] = dios.MultipartFile(
        file.openRead(), await file.length(),
        filename: fileName);
  }
  data.addAll(fileMap);
  var formData = dios.FormData.fromMap(data);
  Dio dio = Dio();
  return await dio.post(url,
      data: formData, options: Options(contentType: 'multipart/form-data'));
}
