// To parse this JSON data, do
//
//     final metaDataModel = metaDataModelFromJson(jsonString);

import 'dart:convert';

class MetaDataModel {
    String? id;
    String? addressKu;
    String? addressAr;
    String? addressEn;
    String? descriptionKu;
    String? descriptionAr;
    String? descriptionEn;
    String? lat;
    String? long;
    String? phone1;
    String? phone2;
    String? email;
    String? logo;
    List<Link>? links;
    int? v;

    MetaDataModel({
        this.id,
        this.addressKu,
        this.addressAr,
        this.addressEn,
        this.descriptionKu,
        this.descriptionAr,
        this.descriptionEn,
        this.lat,
        this.long,
        this.phone1,
        this.phone2,
        this.email,
        this.logo,
        this.links,
        this.v,
    });

    factory MetaDataModel.fromRawJson(String str) => MetaDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MetaDataModel.fromJson(Map<String, dynamic> json) => MetaDataModel(
        id: json["_id"],
        addressKu: json["address_ku"],
        addressAr: json["address_ar"],
        addressEn: json["address_en"],
        descriptionKu: json["description_ku"],
        descriptionAr: json["description_ar"],
        descriptionEn: json["description_en"],
        lat: json["lat"],
        long: json["long"],
        phone1: json["phone_1"],
        phone2: json["phone_2"],
        email: json["email"],
        logo: json["logo"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "address_ku": addressKu,
        "address_ar": addressAr,
        "address_en": addressEn,
        "description_ku": descriptionKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "lat": lat,
        "long": long,
        "phone_1": phone1,
        "phone_2": phone2,
        "email": email,
        "logo": logo,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "__v": v,
    };
}

class Link {
    String? name;
    String? value;

    Link({
        this.name,
        this.value,
    });

    factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
    };
}
