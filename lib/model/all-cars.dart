import 'dart:convert';

import 'package:get/get.dart';

class AllCars {
  AllCars({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;


  factory AllCars.fromJson(String str) => AllCars.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllCars.fromMap(Map<String, dynamic> json) => AllCars(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromMap(json['data']),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    // "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Data {
  Data({
    required this.cars,
  });

  List<Car> cars;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) =>  Data(
    cars: List<Car>.from(json["cars"].map((x) => Car.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "cars": List<dynamic>.from(cars.map((x) => x.toJson())),
  };
}

class Car {
  Car({
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
    required this.brands,
    required this.types,
    required this.bodies,
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
  DescriptionEn? descriptionEn;
  DescriptionAr? descriptionAr;
  String imgs;
  String metaTitleEn;
  String metaTitleAr;
  String metaKeywordsEn;
  String metaKeywordsAr;
  String metaDescriptionEn;
  String? metaDescriptionAr;
  String metaImage;
  // DateTime updatedAt;
  Brands? brands;
  Bodies? types;
  Bodies? bodies;
  RxInt index = 0.obs;

  factory Car.fromJson(String str) => Car.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Car.fromMap(Map<String, dynamic> json) =>  Car(
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
    descriptionEn: json["description_en"] == null ? null : descriptionEnValues.map[json["description_en"]],
    descriptionAr: json["description_ar"] == null ? null : descriptionArValues.map[json["description_ar"]],
    imgs: json["imgs"] == null ? "" : json["imgs"],
    metaTitleEn: json["meta_title_en"] == null ? "" : json["meta_title_en"],
    metaTitleAr: json["meta_title_ar"] == null ? "" : json["meta_title_ar"],
    metaKeywordsEn: json["meta_keywords_en"] == null ? "" : json["meta_keywords_en"],
    metaKeywordsAr: json["meta_keywords_ar"] == null ? "" : json["meta_keywords_ar"],
    metaDescriptionEn: json["meta_description_en"] == null ? "" : json["meta_description_en"],
    metaDescriptionAr: json["meta_description_ar"] == null ? "" : json["meta_description_ar"],
    metaImage: json["meta_image"] == null ? "" : json["meta_image"],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    brands: json["brands"] == null ? null : Brands.fromJson(json["brands"]),
    types: json["types"] == null ? null : Bodies.fromJson(json["types"]),
    bodies: json["bodies"] == null ? null : Bodies.fromJson(json["bodies"]),
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
    "description_en": descriptionEn == null ? null : descriptionEnValues.reverse[descriptionEn],
    "description_ar": descriptionAr == null ? null : descriptionArValues.reverse[descriptionAr],
    "imgs": imgs == null ? null : imgs,
    "meta_title_en": metaTitleEn == null ? null : metaTitleEn,
    "meta_title_ar": metaTitleAr == null ? null : metaTitleAr,
    "meta_keywords_en": metaKeywordsEn == null ? null : metaKeywordsEn,
    "meta_keywords_ar": metaKeywordsAr == null ? null : metaKeywordsAr,
    "meta_description_en": metaDescriptionEn == null ? null : metaDescriptionEn,
    "meta_description_ar": metaDescriptionAr == null ? null : metaDescriptionAr,
    "meta_image": metaImage == null ? null : metaImage,
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "brands": brands == null ? null : brands!.toJson(),
    "types": types == null ? null : types!.toJson(),
    "bodies": bodies == null ? null : bodies!.toJson(),
  };


}

class Bodies {
  Bodies({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.img,
    // required this.updatedAt,
  });

  int id;
  NameEn? nameEn;
  NameAr? nameAr;
  Img? img;
  // DateTime updatedAt;

  factory Bodies.fromJson(Map<String, dynamic> json) => Bodies(
    id: json["id"] == null ? null : json["id"],
    nameEn: json["name_en"] == null ? null : nameEnValues.map[json["name_en"]],
    nameAr: json["name_ar"] == null ? null : nameArValues.map[json["name_ar"]],
    img: json["img"] == null ? null : imgValues.map[json["img"]],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name_en": nameEn == null ? null : nameEnValues.reverse[nameEn],
    "name_ar": nameAr == null ? null : nameArValues.reverse[nameAr],
    "img": img == null ? null : imgValues.reverse[img],
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

enum Img { UPLOADS_BODIES_PA_XI3_SRUQL_E5_I_VZ_W0_CM_QOEA_VC_RC2_JD_SLK_YZ_HV_HH_A_SVG, UPLOADS_BODIES_8_X6_R_CS_QE_ZE_MENJ_IYBLM_GTU9_C_UFVOL_C_IPML_UM7_N9_G_SVG, UPLOADS_BODIES_4_R5_YR_TPUG_X_GPLMH8_X09_ID54_MUT_G_XP_AV_N_WO_X_OU_HDM_SVG, UPLOADS_BODIES_ZRQQ_S20_ADHW6_KY_V_JRKD_L_CEB_G_XEADSHF_O_TZ3_U_KH_NS_SVG, UPLOADS_TYPES_YUU_RBJ_QRO3_A_ILF8_Q_PEAIU_AJ0_G3_UAO4_G_KQQ49_LE_NZ_PNG }

final imgValues = EnumValues({
  "uploads/bodies/4r5yrTpugXGplmh8x09id54MutGXpAvNWoXOuHdm.svg": Img.UPLOADS_BODIES_4_R5_YR_TPUG_X_GPLMH8_X09_ID54_MUT_G_XP_AV_N_WO_X_OU_HDM_SVG,
  "uploads/bodies/8X6rCsQEZeMenjIYBLMGtu9CUfvolCIpmlUm7n9g.svg": Img.UPLOADS_BODIES_8_X6_R_CS_QE_ZE_MENJ_IYBLM_GTU9_C_UFVOL_C_IPML_UM7_N9_G_SVG,
  "uploads/bodies/PaXi3sruqlE5IVzW0CMQoeaVcRc2JdSLKYzHVHhA.svg": Img.UPLOADS_BODIES_PA_XI3_SRUQL_E5_I_VZ_W0_CM_QOEA_VC_RC2_JD_SLK_YZ_HV_HH_A_SVG,
  "uploads/bodies/ZrqqS20adhw6kyVJrkdLCebGXeadshfOTz3uKhNS.svg": Img.UPLOADS_BODIES_ZRQQ_S20_ADHW6_KY_V_JRKD_L_CEB_G_XEADSHF_O_TZ3_U_KH_NS_SVG,
  "uploads/types/yuuRBJQro3AIlf8qPeaiuAj0G3UAO4GKqq49LeNZ.png": Img.UPLOADS_TYPES_YUU_RBJ_QRO3_A_ILF8_Q_PEAIU_AJ0_G3_UAO4_G_KQQ49_LE_NZ_PNG
});

enum NameAr { EMPTY, NAME_AR, PURPLE, FLUFFY, TENTACLED }

final nameArValues = EnumValues({
  "رياضي": NameAr.EMPTY,
  "أقتصادي": NameAr.FLUFFY,
  "رباعي الدفع": NameAr.NAME_AR,
  "فاخر": NameAr.PURPLE,
  "سيارات": NameAr.TENTACLED
});

enum NameEn { SPORT, SUV, LUXURY, ECONOMY, CARS }

final nameEnValues = EnumValues({
  "cars": NameEn.CARS,
  "ECONOMY": NameEn.ECONOMY,
  "luxury": NameEn.LUXURY,
  "sport": NameEn.SPORT,
  "SUV": NameEn.SUV
});

class Brands {
  Brands({
    required this.id,
    required this.name,
    required this.titleEn,
    required this.titleAr,
    required this.img,
    required this.cover,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.slug,
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
  dynamic descriptionAr;
  String slug;
  int orderNum;
  String metaTitleEn;
  String metaTitleAr;
  String metaKeywordsEn;
  String metaKeywordsAr;
  String metaDescriptionEn;
  String metaDescriptionAr;
  String metaImage;
  // DateTime updatedAt;

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    titleEn: json["title_en"] == null ? null : json["title_en"],
    titleAr: json["title_ar"] == null ? null : json["title_ar"],
    img: json["img"] == null ? null : json["img"],
    cover: json["cover"] == null ? null : json["cover"],
    descriptionEn: json["description_en"] == null ? "null" : json["description_en"],
    descriptionAr: json["description_ar"],
    slug: json["slug"] == null ? null : json["slug"],
    orderNum: json["order_num"] == null ? null : json["order_num"],
    metaTitleEn: json["meta_title_en"] == null ? null : json["meta_title_en"],
    metaTitleAr: json["meta_title_ar"] == null ? null : json["meta_title_ar"],
    metaKeywordsEn: json["meta_keywords_en"] == null ? null : json["meta_keywords_en"],
    metaKeywordsAr: json["meta_keywords_ar"] == null ? null : json["meta_keywords_ar"],
    metaDescriptionEn: json["meta_description_en"] == null ? "null" : json["meta_description_en"],
    metaDescriptionAr: json["meta_description_ar"] == null ? "null" : json["meta_description_ar"],
    metaImage: json["meta_image"] == null ? "null" : json["meta_image"],
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
    "description_ar": descriptionAr,
    "slug": slug == null ? null : slug,
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

enum DescriptionAr { P_P, P_SPAN_STYLE_FONT_SIZE_144_PX_INFINITI_QX80_SPAN_BR_P }

final descriptionArValues = EnumValues({
  "<p>.</p>": DescriptionAr.P_P,
  "<p><span style=\"font-size: 14.4px;\">Infiniti Qx80</span><br></p>": DescriptionAr.P_SPAN_STYLE_FONT_SIZE_144_PX_INFINITI_QX80_SPAN_BR_P
});

enum DescriptionEn { P_P, P_INFINITI_QX80_BR_P }

final descriptionEnValues = EnumValues({
  "<p>Infiniti Qx80<br></p>": DescriptionEn.P_INFINITI_QX80_BR_P,
  "<p>.</p>": DescriptionEn.P_P
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
