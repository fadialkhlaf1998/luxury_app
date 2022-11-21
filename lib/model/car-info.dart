import 'dart:convert';
import '../model/all-cars.dart';

class CarInfo {
  CarInfo({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  CarData? data;

  factory CarInfo.fromJson(String str) => CarInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarInfo.fromMap(Map<String, dynamic> json) => CarInfo(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : CarData.fromMap(json['data']),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    // "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };

}

class CarData {
  CarData({
    required this.car,
  });

  CarDetail? car;

  factory CarData.fromJson(String str) => CarData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarData.fromMap(Map<String, dynamic> json) =>  CarData(
    car: json["car"] == null ? null : CarDetail.fromJson(json["car"]),
  );

  Map<String, dynamic> toMap() => {
    "car": car == null ? null : car!.toJson(),
  };

}

class CarDetail {
  CarDetail({
    required this.id,
    required this.orderNumber,
    required this.orderBrandNumber,
    required this.orderCategoryNumber,
    required this.typeId,
    required this.brandId,
    // required this.bodyId,
    required this.canonical,
    required this.slug,
    required this.slugGroup,
    required this.model,
    required this.year,
    required this.innerColor,
    required this.outerColor,
    required this.seats,
    required this.oldDailyPrice,
    required this.dailyPrice,
    required this.oldHourlyPrice,
    required this.hourlyPrice,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.imgs,
    required this.metaTitleEn,
    required this.metaTitleAr,
    required this.metaKeywordsEn,
    required this.metaKeywordsAr,
    required this.metaDescriptionEn,
    required this.metaDescriptionAr,
    required this.metaImage,
    // required this.updatedAt,
    required this.brandsList,
    required this.bodies,
  });

  int id;
  int orderNumber;
  int orderBrandNumber;
  int orderCategoryNumber;
  int typeId;
  int brandId;
  // int bodyId;
  String canonical;
  String slug;
  String slugGroup;
  String model;
  int year;
  String innerColor;
  String outerColor;
  int seats;
  int oldDailyPrice;
  int dailyPrice;
  int oldHourlyPrice;
  int hourlyPrice;
  String descriptionEn;
  String descriptionAr;
  String imgs;
  String metaTitleEn;
  String metaTitleAr;
  String metaKeywordsEn;
  String metaKeywordsAr;
  String metaDescriptionEn;
  String metaDescriptionAr;
  String metaImage;
  // DateTime updatedAt;
  Brands? brandsList;
  List<Bodies> bodies;

  factory CarDetail.fromJson(Map<String, dynamic> json) => CarDetail(
    id: json["id"] == null ? -1 : json["id"],
    orderNumber: json["order_number"] == null ? -1 : json["order_number"],
    orderBrandNumber: json["order_brand_number"] == null ? -1 : json["order_brand_number"],
    orderCategoryNumber: json["order_category_number"] == null ? -1 : json["order_category_number"],
    typeId: json["type_id"] == null ? -1 : json["type_id"],
    brandId: json["brand_id"] == null ? -1 : json["brand_id"],
    // bodyId: json["body_id"] == null ? -1 : json["body_id"],
    canonical: json["canonical"] == null ? "null" : json["canonical"],
    slug: json["slug"] == null ? "" : json["slug"],
    slugGroup: json["slug_group"] == null ? "" : json["slug_group"],
    model: json["model"] == null ? "" : json["model"],
    year: json["year"] == null ? -1 : json["year"],
    innerColor: json["inner_color"] == null ? "" : json["inner_color"],
    outerColor: json["outer_color"] == null ? "" : json["outer_color"],
    seats: json["seats"] == null ? -1 : json["seats"],
    oldDailyPrice: json["old_daily_price"] == null ? -1 : json["old_daily_price"],
    dailyPrice: json["daily_price"] == null ? -1 : json["daily_price"],
    oldHourlyPrice: json["old_hourly_price"] == null ? -1 : json["old_hourly_price"],
    hourlyPrice: json["hourly_price"] == null ? -1 : json["hourly_price"],
    descriptionEn: json["description_en"] == null ? "" : json["description_en"],
    descriptionAr: json["description_ar"] == null ? "" : json["description_ar"],
    imgs: json["imgs"] == null ? "" : json["imgs"],
    metaTitleEn: json["meta_title_en"] == null ? "" : json["meta_title_en"],
    metaTitleAr: json["meta_title_ar"] == null ? "" : json["meta_title_ar"],
    metaKeywordsEn: json["meta_keywords_en"] == null ? "" : json["meta_keywords_en"],
    metaKeywordsAr: json["meta_keywords_ar"] == null ? "" : json["meta_keywords_ar"],
    metaDescriptionEn: json["meta_description_en"] == null ? "" : json["meta_description_en"],
    metaDescriptionAr: json["meta_description_ar"] == null ? "" : json["meta_description_ar"],
    metaImage: json["meta_image"] == null ? "" : json["meta_image"],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    brandsList: json["brands"] == null ? null : Brands.fromJson(json["brands"]),
    bodies: List<Bodies>.from(json["bodies"].map((x) => Bodies.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "order_number": orderNumber == null ? null : orderNumber,
    "order_brand_number": orderBrandNumber == null ? null : orderBrandNumber,
    "order_category_number": orderCategoryNumber == null ? null : orderCategoryNumber,
    "type_id": typeId == null ? null : typeId,
    "brand_id": brandId == null ? null : brandId,
    // "body_id": bodyId == null ? null : bodyId,
    "canonical": canonical == null ? null : canonical,
    "slug": slug == null ? null : slug,
    "slug_group": slugGroup == null ? null : slugGroup,
    "model": model == null ? null : model,
    "year": year == null ? null : year,
    "inner_color": innerColor == null ? null : innerColor,
    "outer_color": outerColor == null ? null : outerColor,
    "seats": seats == null ? null : seats,
    "old_daily_price": oldDailyPrice == null ? null : oldDailyPrice,
    "daily_price": dailyPrice == null ? null : dailyPrice,
    "old_hourly_price": oldHourlyPrice == null ? null : oldHourlyPrice,
    "hourly_price": hourlyPrice == null ? null : hourlyPrice,
    "description_en": descriptionEn,
    "description_ar": descriptionAr,
    "imgs": imgs == null ? null : imgs,
    "meta_title_en": metaTitleEn == null ? null : metaTitleEn,
    "meta_title_ar": metaTitleAr == null ? null : metaTitleAr,
    "meta_keywords_en": metaKeywordsEn == null ? null : metaKeywordsEn,
    "meta_keywords_ar": metaKeywordsAr == null ? null : metaKeywordsAr,
    "meta_description_en": metaDescriptionEn == null ? null : metaDescriptionEn,
    "meta_description_ar": metaDescriptionAr,
    "meta_image": metaImage == null ? null : metaImage,
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "brands": brandsList == null ? null : brandsList!.toJson(),
    "bodies": bodies == null ? null : List<dynamic>.from(bodies.map((x) => x.toJson())),
  };
}

class BodiesCars {
  BodiesCars({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.slug,
    required this.canonical,
    required this.img,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.metaTitleEn,
    required this.metaTitleAr,
    required this.metaKeywordsEn,
    required this.metaKeywordsAr,
    required this.metaDescriptionEn,
    required this.metaDescriptionAr,
    required this.metaImage,
    // required this.updatedAt,
    required this.pivot,
  });

  int id;
  String nameEn;
  String nameAr;
  String slug;
  String canonical;
  String img;
  String descriptionEn;
  String descriptionAr;
  String metaTitleEn;
  String metaTitleAr;
  String metaKeywordsEn;
  String metaKeywordsAr;
  String metaDescriptionEn;
  String metaDescriptionAr;
  String metaImage;
  // DateTime updatedAt;
  Pivot? pivot;

  factory BodiesCars.fromJson(Map<String, dynamic> json) => BodiesCars(
    id: json["id"] == null ? -1 : json["id"],
    nameEn: json["name_en"] == null ? "" : json["name_en"],
    nameAr: json["name_ar"] == null ? "" : json["name_ar"],
    slug: json["slug"] == null ? "" : json["slug"],
    canonical: json["canonical"] == null ? "" : json["canonical"],
    img: json["img"] == null ? null : json["img"],
    descriptionEn: json["description_en"] == null ? "" : json["description_en"],
    descriptionAr: json["description_ar"] == null ? "" : json["description_ar"],
    metaTitleEn: json["meta_title_en"] == null ? "" : json["meta_title_en"],
    metaTitleAr: json["meta_title_ar"] == null ? "null" : json["meta_title_ar"],
    metaKeywordsEn: json["meta_keywords_en"] == null ? "" : json["meta_keywords_en"],
    metaKeywordsAr: json["meta_keywords_ar"] == null ? "" : json["meta_keywords_ar"],
    metaDescriptionEn: json["meta_description_en"] == null ? "" : json["meta_description_en"],
    metaDescriptionAr: json["meta_description_ar"] == null ? "" : json["meta_description_ar"],
    metaImage: json["meta_image"] == null ? null : json["meta_image"],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name_en": nameEn == null ? null : nameEn,
    "name_ar": nameAr == null ? null : nameAr,
    "slug": slug == null ? null : slug,
    "canonical": canonical,
    "img": img == null ? null : img,
    "description_en": descriptionEn == null ? null : descriptionEn,
    "description_ar": descriptionAr == null ? null : descriptionAr,
    "meta_title_en": metaTitleEn == null ? null : metaTitleEn,
    "meta_title_ar": metaTitleAr == null ? null : metaTitleAr,
    "meta_keywords_en": metaKeywordsEn == null ? null : metaKeywordsEn,
    "meta_keywords_ar": metaKeywordsAr == null ? null : metaKeywordsAr,
    "meta_description_en": metaDescriptionEn == null ? null : metaDescriptionEn,
    "meta_description_ar": metaDescriptionAr == null ? null : metaDescriptionAr,
    "meta_image": metaImage == null ? null : metaImage,
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "pivot": pivot == null ? null : pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    required this.carId,
    required this.bodyId,
  });

  int carId;
  int bodyId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    carId: json["car_id"] == null ? -1 : json["car_id"],
    bodyId: json["body_id"] == null ? -1 : json["body_id"],
  );

  Map<String, dynamic> toJson() => {
    "car_id": carId == null ? null : carId,
    "body_id": bodyId == null ? null : bodyId,
  };
}

class BrandsCars {
  BrandsCars({
    required this.id,
    required this.name,
    required this.titleEn,
    required this.titleAr,
    required this.img,
    required this.cover,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.slug,
    required this.canonical,
    required this.orderNum,
    required this.metaTitleEn,
    required this.metaTitleAr,
    required this.metaKeywordsEn,
    required this.metaKeywordsAr,
    required this.metaDescriptionEn,
    required this.metaDescriptionAr,
    required this.metaImage,
    // required this.updatedAt,
  });

  int id;
  String name;
  String titleEn;
  String titleAr;
  String img;
  String cover;
  String descriptionEn;
  String descriptionAr;
  String slug;
  String canonical;
  int orderNum;
  String metaTitleEn;
  String metaTitleAr;
  String metaKeywordsEn;
  String metaKeywordsAr;
  String metaDescriptionEn;
  String metaDescriptionAr;
  String metaImage;
  // DateTime updatedAt;

  factory BrandsCars.fromJson(Map<String, dynamic> json) => BrandsCars(
    id: json["id"] == null ? -1 : json["id"],
    name: json["name"] == null ? "" : json["name"],
    titleEn: json["title_en"] == null ? "" : json["title_en"],
    titleAr: json["title_ar"] == null ? "" : json["title_ar"],
    img: json["img"] == null ? "" : json["img"],
    cover: json["cover"] == null ? "" : json["cover"],
    descriptionEn: json["description_en"] == null ? "" : json["description_en"],
    descriptionAr: json["description_ar"] == null ? "" : json["description_ar"],
    slug: json["slug"] == null ? "" : json["slug"],
    canonical: json["canonical"] == null ? "" : json["canonical"],
    orderNum: json["order_num"] == null ? -1 : json["order_num"],
    metaTitleEn: json["meta_title_en"] == null ? "" : json["meta_title_en"],
    metaTitleAr: json["meta_title_ar"] == null ? "" : json["meta_title_ar"],
    metaKeywordsEn: json["meta_keywords_en"] == null ? "" : json["meta_keywords_en"],
    metaKeywordsAr: json["meta_keywords_ar"] == null ? "" : json["meta_keywords_ar"],
    metaDescriptionEn: json["meta_description_en"] == null ? "" : json["meta_description_en"],
    metaDescriptionAr: json["meta_description_ar"] == null ? "" : json["meta_description_ar"],
    metaImage: json["meta_image"] == null ? "" : json["meta_image"],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "title_en": titleEn == null ? null : titleEn,
    "title_ar": titleAr == null ? null : titleAr,
    "img": img == null ? null : img,
    "cover": cover == null ? null : cover,
    "description_en": descriptionEn == null ? null : descriptionEn,
    "description_ar": descriptionAr == null ? null : descriptionAr,
    "slug": slug == null ? null : slug,
    "canonical": canonical == null ? null : canonical,
    "order_num": orderNum == null ? null : orderNum,
    "meta_title_en": metaTitleEn == null ? null : metaTitleEn,
    "meta_title_ar": metaTitleAr == null ? null : metaTitleAr,
    "meta_keywords_en": metaKeywordsEn == null ? null : metaKeywordsEn,
    "meta_keywords_ar": metaKeywordsAr == null ? null : metaKeywordsAr,
    "meta_description_en": metaDescriptionEn == null ? null : metaDescriptionEn,
    "meta_description_ar": metaDescriptionAr == null ? null : metaDescriptionAr,
    "meta_image": metaImage == null ? null : metaImage,
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}



