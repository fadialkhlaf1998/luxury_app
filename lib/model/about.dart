import 'dart:convert';

class AboutUs {
  AboutUs({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory AboutUs.fromJson(String str) => AboutUs.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AboutUs.fromMap(Map<String, dynamic> json) => AboutUs(
    code: json["code"] == null ? -1 : json["code"],
    message: json["message"] == null ? "" : json["message"],
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
    required this.about,
  });

  List<About> about;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    about: List<About>.from(json["about"].map((x) => About.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
  };
}

class About {
  About({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.cover,
    // required this.updatedAt,
  });

  int id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  String cover;
  // DateTime updatedAt;

  factory About.fromJson(String str) => About.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory About.fromMap(Map<String, dynamic> json) => About(
    id: json["id"] == null ? -1 : json["id"],
    titleEn: json["title_en"] == null ? "" : json["title_en"],
    titleAr: json["title_ar"] == null ? "" : json["title_ar"],
    descriptionEn: json["description_en"] == null ? "" : json["description_en"],
    descriptionAr: json["description_ar"] == null ? "" : json["description_ar"],
    cover: json["cover"] == null ? "" : json["cover"],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title_en": titleEn == null ? null : titleEn,
    "title_ar": titleAr == null ? null : titleAr,
    "description_en": descriptionEn == null ? null : descriptionEn,
    "description_ar": descriptionAr == null ? null : descriptionAr,
    "cover": cover == null ? null : cover,
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
