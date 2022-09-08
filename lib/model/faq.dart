import 'dart:convert';

class Faq {
  Faq({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory Faq.fromJson(String str) => Faq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Faq.fromMap(Map<String, dynamic> json) => Faq(
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
    required this.faq,
  });

  List<FaqElement> faq;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    faq: List<FaqElement>.from(json["faq"].map((x) => FaqElement.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "faq": List<dynamic>.from(faq.map((x) => x.toJson())),
  };
}

class FaqElement {
  FaqElement({
    required this.id,
    required this.questionEn,
    required this.questionAr,
    required this.answerEn,
    required this.answerAr,
    // required this.updatedAt,
  });

  int id;
  String questionEn;
  String questionAr;
  String answerEn;
  String answerAr;
  // DateTime updatedAt;

  factory FaqElement.fromJson(String str) => FaqElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FaqElement.fromMap(Map<String, dynamic> json) => FaqElement(
    id: json["id"] == null ? -1 : json["id"],
    questionEn: json["question_en"] == null ? "" : json["question_en"],
    questionAr: json["question_ar"] == null ? "" : json["question_ar"],
    answerEn: json["answer_en"] == null ? "" : json["answer_en"],
    answerAr: json["answer_ar"] == null ? "" : json["answer_ar"],
    // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "question_en": questionEn == null ? null : questionEn,
    "question_ar": questionAr == null ? null : questionAr,
    "answer_en": answerEn == null ? null : answerEn,
    "answer_ar": answerAr == null ? null : answerAr,
    // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
