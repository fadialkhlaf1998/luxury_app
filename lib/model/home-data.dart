import 'dart:convert';

import 'package:get/get.dart';

class HomeData {
  HomeData({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory HomeData.fromJson(String str) => HomeData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeData.fromMap(Map<String, dynamic> json) => HomeData(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromMap(json['data']),
    // data: List<Data>.from(json["data"].map((x) => Data.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    // "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Data {
  Data({
    required this.maxPriceDaily,
    required this.maxPriceHourly,
    required this.carBody,
    required this.carType,
    required this.cars,
    required this.brands,
    required this.social,
    required this.contact,
    required this.brandsWithAll,
  });

  int maxPriceDaily;
  int maxPriceHourly;
  List<CarBody> carBody;
  List<CarBody> carType;
  Cars cars;
  List<Brand> brands;
  List<Brand> brandsWithAll;
  List<Social> social;
  List<Contact> contact;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory Data.fromMap(Map<String, dynamic> json) {
   Data data = Data(
      maxPriceDaily: json["max-price-daily"] == null ? -1 : json["max-price-daily"],
      maxPriceHourly: json["max-price-hourly"] == null ? -1 : json["max-price-hourly"],
      carBody: List<CarBody>.from(json["car-body"].map((x) => CarBody.fromJson(x))),
      carType: List<CarBody>.from(json["car-type"].map((x) => CarBody.fromJson(x))),
      cars: Cars.fromJson(json["cars"]),
      brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
      brandsWithAll: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
      social: List<Social>.from(json["social"].map((x) => Social.fromJson(x))),
      contact: List<Contact>.from(json["contact"].map((x) => Contact.fromJson(x))),
    );
   // this.brands.add(Brand(id: -1, name: "ALL", titleEn: "ALL", titleAr: "جميع", img: "", cover: "", descriptionEn: "", descriptionAr: "", slug: "all", orderNum: -1,
   //     metaTitleEn: "", metaTitleAr: "", metaKeywordsEn: "", metaKeywordsAr: "", metaDescriptionEn: "", metaDescriptionAr: "", metaImage: ""));
   return data;
  }

  Map<String, dynamic> toMap() => {
    "max-price-daily": maxPriceDaily == null ? null : maxPriceDaily,
    "max-price-hourly": maxPriceHourly == null ? null : maxPriceHourly,
    "car-body": carBody == null ? null : List<dynamic>.from(carBody.map((x) => x.toJson())),
    "car-type": carType == null ? null : List<dynamic>.from(carType.map((x) => x.toJson())),
    "cars": cars == null ? null : cars.toJson(),
    "brands": brands == null ? null : List<dynamic>.from(brands.map((x) => x.toJson())),
    "social": social == null ? null : List<dynamic>.from(social.map((x) => x.toJson())),
    "contact": contact == null ? null : List<dynamic>.from(contact.map((x) => x.toJson())),
  };
}

class Brand {
  Brand({
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
  String descriptionAr;
  String slug;
  int orderNum;
  String metaTitleEn;
  String metaTitleAr;
  String metaKeywordsEn;
  String metaKeywordsAr;
  String metaDescriptionEn;
  String metaDescriptionAr;
  String metaImage;
  Rx<bool> selected = false.obs;
  // DateTime updatedAt;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"] == null ? -1 : json["id"],
    name: json["name"] == null ? "" : json["name"],
    titleEn: json["title_en"] == null ? "" : json["title_en"],
    titleAr: json["title_ar"] == null ? "" : json["title_ar"],
    img: json["img"] == null ? "" : json["img"],
    cover: json["cover"] == null ? "" : json["cover"],
    descriptionEn: json["description_en"] == null ? "" : json["description_en"],
    descriptionAr: json["description_ar"] == null ? "" : json["description_ar"],
    slug: json["slug"] == null ? "" : json["slug"],
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


class CarBody {
  CarBody({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.img,
    required this.updatedAt,
  });

  int id;
  String nameEn;
  String nameAr;
  String img;
  DateTime? updatedAt;

  factory CarBody.fromJson(Map<String, dynamic> json) => CarBody(
    id: json["id"] == null ? -1 : json["id"],
    nameEn: json["name_en"] == null ? "null" : json["name_en"],
    nameAr: json["name_ar"] == null ? "null" : json["name_ar"],
    img: json["img"] == null ? "null" : json["img"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name_en": nameEn == null ? null : nameEn,
    "name_ar": nameAr == null ? null : nameAr,
    "img": img == null ? null : img,
    "updated_at": updatedAt == null ? null : updatedAt!,
  };
}

class Cars {
  Cars({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Datum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link>? links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Cars.fromJson(Map<String, dynamic> json) => Cars(
    currentPage: json["current_page"] == null ? -1 : json["current_page"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    firstPageUrl: json["first_page_url"] == null ? "null" : json["first_page_url"],
    from: json["from"] == null ? -1 : json["from"],
    lastPage: json["last_page"] == null ? -1 : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? "null" : json["last_page_url"],
    links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"] == null ? "null" : json["next_page_url"],
    path: json["path"] == null ? "null" : json["path"],
    perPage: json["per_page"] == null ? -1 : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? -1 : json["to"],
    total: json["total"] == null ? -1 : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "last_page_url": lastPageUrl == null ? null : lastPageUrl,
    "links": links == null ? null : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl == null ? null : nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class Datum {
  Datum({
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
  dynamic descriptionEn;
  dynamic descriptionAr;
  String imgs;
  String metaTitleEn;
  String metaTitleAr;
  String metaKeywordsEn;
  String metaKeywordsAr;
  String metaDescriptionEn;
  String metaDescriptionAr;
  String metaImage;
  // DateTime? updatedAt;
  Brand? brands;
  CarBody? types;
  CarBody? bodies;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? -1 : json["id"],
    typeId: json["type_id"] == null ? -1 : json["type_id"],
    brandId: json["brand_id"] == null ? -1 : json["brand_id"],
    bodyId: json["body_id"] == null ? -1 : json["body_id"],
    slug: json["slug"] == null ? "null" : json["slug"],
    slugGroup: json["slug_group"] == null ? "null" : json["slug_group"],
    model: json["model"] == null ? "null" : json["model"],
    year: json["year"] == null ? -1 : json["year"],
    innerColor: json["inner_color"] == null ? "null" : json["inner_color"],
    outerColor: json["outer_color"] == null ? "null" : json["outer_color"],
    seats: json["seats"] == null ? "null" : json["seats"],
    oldDailyPrice: json["old_daily_price"] == null ? -1 : json["old_daily_price"],
    dailyPrice: json["daily_price"] == null ? -1 : json["daily_price"],
    oldHourlyPrice: json["old_hourly_price"] == null ? -1 : json["old_hourly_price"],
    hourlyPrice: json["hourly_price"] == null ? -1 : json["hourly_price"],
    descriptionEn: json["description_en"],
    descriptionAr: json["description_ar"],
    imgs: json["imgs"] == null ? "null" : json["imgs"],
    metaTitleEn: json["meta_title_en"] == null ? "null" : json["meta_title_en"],
    metaTitleAr: json["meta_title_ar"] == null ? "null" : json["meta_title_ar"],
    metaKeywordsEn: json["meta_keywords_en"] == null ? "null" : json["meta_keywords_en"],
    metaKeywordsAr: json["meta_keywords_ar"] == null ? "null" : json["meta_keywords_ar"],
    metaDescriptionEn: json["meta_description_en"] == null ? "null" : json["meta_description_en"],
    metaDescriptionAr: json["meta_description_ar"] == null ? "null" : json["meta_description_ar"],
    metaImage: json["meta_image"] == null ? null : json["meta_image"],
    //updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    brands: Brand.fromJson(json["brands"]),
    types:  CarBody.fromJson(json["types"]),
    bodies: CarBody.fromJson(json["bodies"]),
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
    "daily_price": dailyPrice == null ? null : dailyPrice,
    "hourly_price": hourlyPrice == null ? null : hourlyPrice,
    "description_en": descriptionEn,
    "description_ar": descriptionAr,
    "imgs": imgs == null ? null : imgs,
    "meta_title_en": metaTitleEn == null ? null : metaTitleEn,
    "meta_title_ar": metaTitleAr == null ? null : metaTitleAr,
    "meta_keywords_en": metaKeywordsEn == null ? null : metaKeywordsEn,
    "meta_keywords_ar": metaKeywordsAr == null ? null : metaKeywordsAr,
    "meta_description_en": metaDescriptionEn == null ? null : metaDescriptionEn,
    "meta_description_ar": metaDescriptionAr == null ? null : metaDescriptionAr,
    "meta_image": metaImage == null ? null : metaImage,
    //"updated_at": updatedAt == null ? null : updatedAt!,
    "brands": brands == null ? null : brands!.toJson(),
    "types": types == null ? null : types!.toJson(),
    "bodies": bodies == null ? null : bodies!.toJson(),
  };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? "null" : json["url"],
    label: json["label"] == null ? null : json["label"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label == null ? null : label,
    "active": active == null ? null : active,
  };
}

class Contact {
  Contact({
    required this.id,
    required this.title,
    required this.icon,
    required this.type,
    required this.url,
    required this.updatedAt,
  });

  int id;
  String title;
  String icon;
  String type;
  String url;
  DateTime? updatedAt;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    icon: json["icon"] == null ? null : json["icon"],
    type: json["type"] == null ? null : json["type"],
    url: json["url"] == null ? null : json["url"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "icon": icon == null ? null : icon,
    "type": type == null ? null : type,
    "url": url == null ? null : url,
    "updated_at": updatedAt == null ? null : updatedAt!,
  };
}

class Social {
  Social({
    required this.id,
    required this.icon,
    required this.url,
    required this.updatedAt,
  });

  int id;
  String icon;
  String url;
  DateTime? updatedAt;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    id: json["id"] == null ? null : json["id"],
    icon: json["icon"] == null ? null : json["icon"],
    url: json["url"] == null ? null : json["url"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "icon": icon == null ? null : icon,
    "url": url == null ? null : url,
    "updated_at": updatedAt == null ? null : updatedAt!,
  };
}

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
