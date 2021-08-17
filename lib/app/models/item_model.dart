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
  });

  List<dynamic>? picture;
  int? sellingPrice;
  String? id;
  String? barcode;
  String? name;
  String? category;
  String? brand;
  factory ItemModel.fromJson(str) => ItemModel.fromMap(str);
  String toJson() => json.encode(toMap());
  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        picture: json["picture"] == null
            ? null
            : List<dynamic>.from(json["picture"].map((x) => x)),
        sellingPrice:
            json["sellingPrice"] == null ? null : json["sellingPrice"],
        id: json["_id"] == null ? null : json["_id"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
        brand: json["brand"] == null ? null : json["brand"],
      );

  Map<String, dynamic> toMap() => {
        "picture":
            picture == null ? null : List<dynamic>.from(picture!.map((x) => x)),
        "sellingPrice": sellingPrice == null ? null : sellingPrice,
        "_id": id == null ? null : id,
        "barcode": barcode == null ? null : barcode,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
        "brand": brand == null ? null : brand,
      };
}
