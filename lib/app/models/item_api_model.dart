import 'dart:convert';

import 'package:trancehouse/utils/config.dart';

class ItemApiModel {
  ItemApiModel({
    this.trader,
    required this.traderName,
    this.invoiceSpecialType,
    required this.quickCustomerName,
    required this.quickCustomerPhone,
    required this.versions,
  });

  String? trader;
  final String traderName;
  String? invoiceSpecialType;
  final String quickCustomerName;
  final String quickCustomerPhone;
  final List<Version> versions;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "trader": 1,
        "traderName": traderName,
        "invoiceSpecialType": "purchaseOrder",
        "quickCustomerName": quickCustomerName,
        "quickCustomerPhone": quickCustomerPhone,
        "branch": {
          "_id": ConfigApp.branchAccess,
          "name": "slemani",
          "appType": "company"
        },
        "branchId": ConfigApp.branchAccess,
        "invoiceType": "ORDER",
        "state": '1',
        "statement": 'ordered',
        "versions": List<dynamic>.from(versions.map((x) => x.toMap())),
      };
}

class Version {
  Version({
    required this.totalPrice,
    required this.items,
    required this.note,
  });

  final TotalPrice totalPrice;
  final List<Item> items;
  final String note;

  factory Version.fromJson(String str) => Version.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Version.fromMap(Map<String, dynamic> json) => Version(
        totalPrice: TotalPrice.fromMap(json["totalPrice"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        note: json["note"],
      );

  Map<String, dynamic> toMap() => {
        "totalPrice": totalPrice.toMap(),
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "note": note,
      };
}

class Item {
  Item({
    required this.name,
    required this.barcode,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.currency,
    required this.service,
  });

  final String name;
  final String barcode;
  final String quantity;
  final String price;
  final String totalPrice;
  final String currency;
  final bool service;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        name: json["name"],
        barcode: json["barcode"],
        quantity: json["quantity"],
        price: json["price"],
        totalPrice: json["totalPrice"],
        currency: json["currency"],
        service: json["service"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "barcode": barcode,
        "quantity": quantity,
        "price": price,
        "totalPrice": totalPrice,
        "currency": currency,
        "service": service,
      };
}

class TotalPrice {
  TotalPrice({
    required this.amount,
    required this.totalInvoiceBalance,
  });

  final int amount;
  final int totalInvoiceBalance;

  factory TotalPrice.fromJson(String str) =>
      TotalPrice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TotalPrice.fromMap(Map<String, dynamic> json) => TotalPrice(
        amount: json["amount"],
        totalInvoiceBalance: json["totalInvoiceBalance"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "totalInvoiceBalance": totalInvoiceBalance,
      };
}
