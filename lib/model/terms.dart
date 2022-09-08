import 'dart:convert';

class RentTerms {
  RentTerms({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory RentTerms.fromJson(String str) => RentTerms.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RentTerms.fromMap(Map<String, dynamic> json) => RentTerms(
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
    required this.terms,
  });

  List<Term> terms;


  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    terms: List<Term>.from(json["terms"].map((x) => Term.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "terms": List<dynamic>.from(terms.map((x) => x.toJson())),
  };
}

class Term {
  Term({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    // required this.updatedAt,
  });

  int id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  // DateTime updatedAt;

  factory Term.fromJson(String str) => Term.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Term.fromMap(Map<String, dynamic> json) => Term(
    id: json["id"] == null ? 01 : json["id"],
    titleEn: json["title_en"] == null ? "" : json["title_en"],
    titleAr: json["title_ar"] == null ? "" : json["title_ar"],
    descriptionEn: json["description_en"] == null ? "" : json["description_en"],
    descriptionAr: json["description_ar"] == null ? "" : json["description_ar"],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title_en": titleEn == null ? null : titleEn,
    "title_ar": titleAr == null ? null : titleAr,
    "description_en": descriptionEn == null ? null : descriptionEn,
    "description_ar": descriptionAr == null ? null : descriptionAr,
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
