
import 'dart:convert';

class ContactUsResult {
  ContactUsResult({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  dynamic data;

  factory ContactUsResult.fromJson(String str) => ContactUsResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactUsResult.fromMap(Map<String, dynamic> json) => ContactUsResult(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data,
  };
}
