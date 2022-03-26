import 'dart:convert';

class ItemModel {
  ItemModel({
    this.picture,
    this.sellingPrice,
    this.id,
    this.barcode,
    this.name,
    this.category,
    this.brand,
    this.itemInfo,
    this.amount,
    this.localizeName,
    this.description,
  });

  List<String>? picture;
  int? sellingPrice;
  int? amount;
  String? id;
  String? barcode;
  String? name;
  String? category;
  String? brand;
  String? itemInfo;
  Map? localizeName;
  Map? description;
  factory ItemModel.fromJson(str) => ItemModel.fromMap(str);
  String toJson() => json.encode(toMap());
  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        picture: json["picture"] == null
            ? null
            : List<String>.from(json["picture"].map((x) => x)),
        sellingPrice:
            json["sellingPrice"],
        id: json["_id"],
        barcode: json["barcode"],
        name: json["name"],
        category: json["category"],
        brand: json["brand"],
        itemInfo: json["itemInfo"],
        amount: json["amount"] ?? 1,
        localizeName:
            json["localizeName"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "picture":
            picture == null ? null : List<String>.from(picture!.map((x) => x)),
        "sellingPrice": sellingPrice,
        "_id": id,
        "barcode": barcode,
        "name": name,
        "category": category,
        "brand": brand,
        "itemInfo": itemInfo,
        "amount": amount,
        "localizeName": localizeName,
        "description": description,
      };
  ItemModel copyWith({
    List<String>? picture,
    int? sellingPrice,
    int? amount,
    String? id,
    String? barcode,
    String? name,
    String? category,
    String? brand,
    String? itemInfo,
    Map? localizeName,
    Map? description,
  }) =>
      ItemModel(
        picture: picture ?? this.picture,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        id: id ?? this.id,
        barcode: barcode ?? this.barcode,
        name: name ?? this.name,
        category: category ?? this.category,
        brand: brand ?? this.brand,
        itemInfo: itemInfo ?? this.itemInfo,
        amount: amount ?? this.amount,
        localizeName: localizeName ?? this.localizeName,
        description: description ?? this.description,
      );
}
