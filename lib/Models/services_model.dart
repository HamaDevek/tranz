// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

class ServicesModel {
  String? id;
  Category? category;
  List<Service>? services;

  ServicesModel({
    this.id,
    this.category,
    this.services,
  });

  factory ServicesModel.fromRawJson(String str) =>
      ServicesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        id: json["_id"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"]!.map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category?.toJson(),
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class Category {
  String? id;
  String? nameKu;
  String? nameEn;
  String? nameAr;
  int? deliveryFee;
  String? image;
  int? v;

  Category({
    this.id,
    this.nameKu,
    this.nameEn,
    this.nameAr,
    this.image,
    this.deliveryFee,
    this.v,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        nameKu: json["name_ku"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        deliveryFee: json["delivery_fee"],
        image: json["image"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name_ku": nameKu,
        "name_en": nameEn,
        "name_ar": nameAr,
        "delivery_fee": deliveryFee,
        "image": image,
        "__v": v,
      };
}

class Service {
  String? id;
  String? language;
  String? status;
  LanguagesModel? title;
  LanguagesModel? description;
  String? contactEmail;
  List<String>? images;
  String? parent;
  List<Article>? articles;
  int? v;
  Category? category;

  Service({
    this.id,
    this.language,
    this.status,
    this.title,
    this.description,
    this.contactEmail,
    this.images,
    this.parent,
    this.articles,
    this.v,
    this.category,
  });

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        language: json["language"],
        status: json["status"],
        title: json["title"] == null
            ? null
            : LanguagesModel.fromJson(json["title"]),
        description: json["description"] == null
            ? null
            : LanguagesModel.fromJson(json["description"]),
        contactEmail: json["contactEmail"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        parent: json["parent"],
        articles: json["articles"] == null
            ? []
            : List<Article>.from(
                json["articles"]!.map((x) => Article.fromJson(x))),
        v: json["__v"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "language": language,
        "status": status,
        "title": title?.toJson(),
        "description": description?.toJson(),
        "contactEmail": contactEmail,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "parent": parent,
        "articles": articles == null
            ? []
            : List<dynamic>.from(articles!.map((x) => x.toJson())),
        "__v": v,
        "category": category?.toJson(),
      };
}

class Article {
  String? language;
  String? status;
  LanguagesModel? title;
  LanguagesModel? description;
  List<String>? images;
  List<String>? links;
  String? id;

  Article({
    this.language,
    this.status,
    this.title,
    this.description,
    this.images,
    this.links,
    this.id,
  });

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        language: json["language"],
        status: json["status"],
        title: json["title"] == null
            ? null
            : LanguagesModel.fromJson(json["title"]),
        description: json["description"] == null
            ? null
            : LanguagesModel.fromJson(json["description"]),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        links: json["links"] == null
            ? []
            : List<String>.from(json["links"]!.map((x) => x)),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "status": status,
        "title": title?.toJson(),
        "description": description?.toJson(),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
        "id": id,
      };
}

class LanguagesModel {
  String? en;
  String? ku;
  String? ar;

  LanguagesModel({
    this.en,
    this.ku,
    this.ar,
  });

  factory LanguagesModel.fromRawJson(String str) =>
      LanguagesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LanguagesModel.fromJson(Map<String, dynamic> json) => LanguagesModel(
        en: json["en"],
        ku: json["ku"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "ku": ku,
        "ar": ar,
      };
}
