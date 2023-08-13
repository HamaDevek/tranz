import 'package:flutter/material.dart';
import 'package:tranzhouse/Models/admin_order_model.dart';
import 'package:tranzhouse/Models/blogs_model.dart';
import 'package:tranzhouse/Models/product_model.dart';

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
List<String> orderStatus = [
  "All",
  "Pending",
  "Accept",
  "Rejected",
];

List<ServicesModel> fakeServiceCategories = List.generate(
  3,
  (index) => ServicesModel(
    category: Category(
        image: "https://picsum.photos/200/300", nameEn: "Category Name"),
  ),
);
List<ProductModel> fakeProducts = List.generate(
    3,
    (index) => ProductModel(
          description: LanguagesModel(
            en: "Description",
          ),
          images: [
            "https://picsum.photos/200/300",
            "https://picsum.photos/200/300",
            "https://picsum.photos/200/300",
            "https://picsum.photos/200/300",
          ],
          title: LanguagesModel(
            en: "Product Name",
          ),
        ));

List<BlogsModel> fakeBlogs = List.generate(
    3,
    (index) => BlogsModel(
          updatedAt: DateTime.parse(DateTime.now().toString()),
          title: LanguagesModel(
            en: "Title",
          ),
        ));
List<AdminOrderModel> fakeAdminOrders = List.generate(
    3,
    (index) => AdminOrderModel(
          owner: Owner(
            name: "Owner Name",
          ),
          createdAt: DateTime.parse(DateTime.now().toString()),
          service: Service(
            title: LanguagesModel(
              en: "Title",
            ),
          ),
        ));
