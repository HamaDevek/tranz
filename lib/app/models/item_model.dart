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
            json["sellingPrice"] == null ? null : json["sellingPrice"],
        id: json["_id"] == null ? null : json["_id"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
        brand: json["brand"] == null ? null : json["brand"],
        itemInfo: json["itemInfo"] == null ? null : json["itemInfo"],
        amount: json["amount"] == null ? 1 : json["amount"],
        localizeName:
            json["localizeName"] == null ? null : json["localizeName"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "picture":
            picture == null ? null : List<String>.from(picture!.map((x) => x)),
        "sellingPrice": sellingPrice == null ? null : sellingPrice,
        "_id": id == null ? null : id,
        "barcode": barcode == null ? null : barcode,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
        "brand": brand == null ? null : brand,
        "itemInfo": itemInfo == null ? null : itemInfo,
        "amount": amount == null ? null : amount,
        "localizeName": localizeName == null ? null : localizeName,
        "description": description == null ? null : description,
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
