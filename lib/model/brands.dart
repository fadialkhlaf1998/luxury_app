import 'dart:convert';

class AllBrands {
  AllBrands({
    required this.code,
    required this.message,
    required this.brand,
  });

  int code;
  String message;
  MyBrand brand;

  factory AllBrands.fromJson(String str) => AllBrands.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllBrands.fromMap(Map<String, dynamic> json) => AllBrands(
    code: json["code"] == null ? -1 : json["code"],
    message: json["message"] == null ? "" : json["message"],
    brand: MyBrand.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": brand == null ? null : brand.toJson(),
  };
}

class MyBrand {
  MyBrand({
    required this.brands,
  });

  List<BrandInfo>? brands;


  factory MyBrand.fromJson(String str) => MyBrand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyBrand.fromMap(Map<String, dynamic> json) => MyBrand(
    brands: json["brands"] == null ? null : List<BrandInfo>.from(json["brands"].map((x) => BrandInfo.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "brands": List<dynamic>.from(brands!.map((x) => x.toJson())),
  };
}

class BrandInfo {
  BrandInfo({
    required this.id,
    required this.typeId,
    required this.brandId,
    required this.bodyId,
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
  });

  int id;
  int typeId;
  int brandId;
  int bodyId;
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

  factory BrandInfo.fromJson(String str) => BrandInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandInfo.fromMap(Map<String, dynamic> json) => BrandInfo(
    id: json["id"] == null ? -1 : json["id"],
    typeId: json["type_id"] == null ? -1 : json["type_id"],
    brandId: json["brand_id"] == null ? -1 : json["brand_id"],
    bodyId: json["body_id"] == null ? -1 : json["body_id"],
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
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "type_id": typeId == null ? null : typeId,
    "brand_id": brandId == null ? null : brandId,
    "body_id": bodyId == null ? null : bodyId,
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
    "description_en": descriptionEn == null ? null : descriptionEn,
    "description_ar": descriptionAr == null ? null : descriptionAr,
    "imgs": imgs == null ? null : imgs,
    "meta_title_en": metaTitleEn == null ? null : metaTitleEn,
    "meta_title_ar": metaTitleAr == null ? null : metaTitleAr,
    "meta_keywords_en": metaKeywordsEn == null ? null : metaKeywordsEn,
    "meta_keywords_ar": metaKeywordsAr == null ? null : metaKeywordsAr,
    "meta_description_en": metaDescriptionEn == null ? null : metaDescriptionEn,
    "meta_description_ar": metaDescriptionAr,
    "meta_image": metaImage == null ? null : metaImage,
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
