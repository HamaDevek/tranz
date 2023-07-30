import 'package:flutter/material.dart';

import '../Models/product_model.dart';
import '../Models/services_model.dart';


const List<BoxShadow> boxShadows = [
  BoxShadow(
    color: Color(0x02000000),
    blurRadius: 2.21,
    offset: Offset(0, -7),
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0x03000000),
    blurRadius: 5.32,
    offset: Offset(0, -10),
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0x03000000),
    blurRadius: 10.02,
    offset: Offset(0, -20),
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0x04000000),
    blurRadius: 17.87,
    offset: Offset(0, 22.34),
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0x05000000),
    blurRadius: 33.42,
    offset: Offset(0, -10),
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0x07000000),
    blurRadius: 80,
    offset: Offset(0, 27),
    spreadRadius: 0,
  )
];

List<String> categoris = [
  "All Orders",
  "Pending Orders",
  "Completed Orders",
  "Declined Orders",
];

 List<ProductModel> counterList = [];
    void generateList(){
      counterList = List.generate(
      5,
      (index) => ProductModel(
        category: "category",
        description: LanguagesModel(
          ku: "description",
          en: "description",
          ar: "description",
        ),
        id: "id",
        images: ["https://picsum.photos/400/200"],
        links: ["links"],
        price: 23000,
        status: "status",
        title: LanguagesModel(
          ku: "title",
          en: "title",
          ar: "title",
        ),
        language: "language",
      ),
    );
    }



