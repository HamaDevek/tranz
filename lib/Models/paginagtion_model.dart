// To parse this JSON data, do
//
//     final paginationModel = paginationModelFromJson(jsonString);

import 'dart:convert';

class PaginationModel {
  PaginationModel({
    this.currentPage,
    this.firstPage,
    this.firstPageUrl,
    this.nextPage,
    this.nextPageUrl,
    this.prevPage,
    this.prevPageUrl,
  });

  int? currentPage;
  int? firstPage;
  String? firstPageUrl;
  int? nextPage;
  dynamic nextPageUrl;
  int? prevPage;
  dynamic prevPageUrl;

  factory PaginationModel.fromRawJson(String str) =>
      PaginationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        currentPage: json["current_page"],
        firstPage: json["first_page"],
        firstPageUrl: json["first_page_url"],
        nextPage: json["next_page"],
        nextPageUrl: json["next_page_url"],
        prevPage: json["prev_page"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "first_page": firstPage,
        "first_page_url": firstPageUrl,
        "next_page": nextPage,
        "next_page_url": nextPageUrl,
        "prev_page": prevPage,
        "prev_page_url": prevPageUrl,
      };
}
