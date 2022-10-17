import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {

  static String languageCode = "en";

  static List<String> hoursList = [
    "12:00 AM","12:30 AM","01:00 AM","01:30 AM","02:00 AM", "02:30 AM","03:00 AM",
    "03:30 AM","04:00 AM","04:30 AM","05:00 AM","05:30 AM","06:00 AM","06:30 AM",
    "07:00 AM", "07:30 AM","08:00 AM","08:30 AM","09:00 AM","09:30 AM","10:00 AM",
    "10:30 AM","11:00 AM","11:30 AM",
    "12:00 PM", "12:30 PM","01:00 PM","01:30 PM","02:00 PM", "02:30 PM","03:00 PM",
    "03:30 PM","04:00 PM","04:30 PM","05:00 PM","05:30 PM","06:00 PM","06:30 PM",
    "07:00 PM", "07:30 PM","08:00 PM","08:30 PM","09:00 PM","09:30 PM","10:00 PM",
    "10:30 PM","11:00 PM","11:30 PM"
  ];

  static Future<String> loadLanguage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String lang=prefs.getString("language")??'default';
      if(lang!="default") {
        languageCode=lang;
      }
      else {
        languageCode="en";
      }
      Get.updateLocale(Locale(languageCode));
      return languageCode;
    }
    catch(e) {
      return "en";
    }
  }
  static saveLanguage(BuildContext context,String lang) {
    SharedPreferences.getInstance().then((preference) {
      preference.setString("language", lang);
      languageCode=lang;
      MyApp.setLocale(context, Locale(lang));
      Get.updateLocale(Locale(lang));
    });
  }
  static changeLanguage(BuildContext context, String lang) {
    Global.languageCode = lang;
    Locale locale = Locale(lang);
    MyApp.setLocale(context, locale);
    saveLanguage(context,lang);
  }
}