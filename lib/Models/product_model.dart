import 'dart:convert';

import 'package:tranzhouse/Models/services_model.dart';

// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

class ProductModel {
  String? id;
  String? language;
  String? status;
  LanguagesModel? title;
  int? price;
  String? category;
  LanguagesModel? description;
  List<String>? images;
  List<String>? links;
  int? v;
  int quantity;

  ProductModel({
    this.id,
    this.language,
    this.status,
    this.title,
    this.price,
    this.category,
    this.description,
    this.images,
    this.links,
    this.v,
    this.quantity = 1,
  });

  ProductModel copyWith({
    String? id,
    String? language,
    String? status,
    LanguagesModel? title,
    int? price,
    String? category,
    LanguagesModel? description,
    List<String>? images,
    List<String>? links,
    int? v,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      language: language ?? this.language,
      status: status ?? this.status,
      title: title ?? this.title,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
      images: images ?? this.images,
      links: links ?? this.links,
      v: v ?? this.v,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        language: json["language"],
        status: json["status"],
        title: json["title"] == null
            ? null
            : LanguagesModel.fromJson(json["title"]),
        price: json["price"],
        category: json["category"],
        description: json["description"] == null
            ? null
            : LanguagesModel.fromJson(json["description"]),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        links: json["links"] == null
            ? []
            : List<String>.from(json["links"]!.map((x) => x)),
        v: json["__v"],
        quantity: json["quantity"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "language": language,
        "status": status,
        "title": title?.toJson(),
        "price": price,
        "category": category,
        "description": description?.toJson(),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
        "__v": v,
        "quantity": quantity,
      };
}

class ProductCategory {
  String? id;
  String? nameKu;
  String? nameEn;
  String? nameAr;
  int? v;

  ProductCategory({
    this.id,
    this.nameKu,
    this.nameEn,
    this.nameAr,
    this.v,
  });

  factory ProductCategory.fromRawJson(String str) =>
      ProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["_id"],
        nameKu: json["name_ku"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name_ku": nameKu,
        "name_en": nameEn,
        "name_ar": nameAr,
        "__v": v,
      };
}




