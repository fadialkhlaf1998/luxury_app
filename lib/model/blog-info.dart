import 'dart:convert';

class BlogsInfo {
  BlogsInfo({
    required this.code,
    required this.message,
    required this.blogData,
  });

  int code;
  String message;
  BlogData? blogData;

  factory BlogsInfo.fromJson(String str) => BlogsInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogsInfo.fromMap(Map<String, dynamic> json) => BlogsInfo(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    blogData: json["data"] == null ? null : BlogData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": blogData == null ? null : blogData!.toJson(),
  };
}

class BlogData {
  BlogData({
    required this.blogInfo,
  });

  BlogInfo? blogInfo;

  factory BlogData.fromJson(String str) => BlogData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogData.fromMap(Map<String, dynamic> json) => BlogData(
    blogInfo: json["blog"] == null ? null : BlogInfo.fromJson(json["blog"]),
  );

  Map<String, dynamic> toMap() => {
    "blog": blogInfo == null ? null : blogInfo!.toJson(),
  };
}

class BlogInfo {
  BlogInfo({
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

  factory BlogInfo.fromJson(Map<String, dynamic> json) => BlogInfo(
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
    metaImage: json["meta_image"] == null ? null : json["meta_image"],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
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
