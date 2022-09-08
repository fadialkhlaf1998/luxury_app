import 'dart:convert';

class BLOG {
  BLOG({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory BLOG.fromJson(String str) => BLOG.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BLOG.fromMap(Map<String, dynamic> json) => BLOG(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.blog,
  });

  List<BlogElement> blog;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    blog: List<BlogElement>.from(json["blog"].map((x) => BlogElement.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "blog": List<dynamic>.from(blog.map((x) => x.toJson())),
  };
}

class BlogElement {
  BlogElement({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.slug,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.cover,
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
  String titleEn;
  String titleAr;
  String slug;
  String descriptionEn;
  String descriptionAr;
  String cover;
  String metaTitleEn;
  String metaTitleAr;
  String metaKeywordsEn;
  String metaKeywordsAr;
  String metaDescriptionEn;
  String metaDescriptionAr;
  String metaImage;
  // DateTime updatedAt;

  factory BlogElement.fromJson(String str) => BlogElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogElement.fromMap(Map<String, dynamic> json) => BlogElement(
    id: json["id"] == null ? -1 : json["id"],
    titleEn: json["title_en"] == null ? "" : json["title_en"],
    titleAr: json["title_ar"] == null ? "" : json["title_ar"],
    slug: json["slug"] == null ? "" : json["slug"],
    descriptionEn: json["description_en"] == null ? "" : json["description_en"],
    descriptionAr: json["description_ar"] == null ? "" : json["description_ar"],
    cover: json["cover"] == null ? "" : json["cover"],
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
    "title_en": titleEn == null ? null : titleEn,
    "title_ar": titleAr == null ? null : titleAr,
    "slug": slug == null ? null : slug,
    "description_en": descriptionEn == null ? null : descriptionEn,
    "description_ar": descriptionAr == null ? null : descriptionAr,
    "cover": cover == null ? null : cover,
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
