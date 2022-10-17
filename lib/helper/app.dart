import 'package:flutter/material.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class App{

  /// colors
  static const Color primary =  Color(0XFF1e1f21);
  static const Color lightDarkGrey =  Color(0XFF26272a);
  static const Color orange =  Color(0XFFd5a054);
  static const Color grey =  Color(0XFF333436);
  static const Color lightWhite =  Color(0XFF92989e);
  static const Color white =  Color(0XFFccc7c0);
  static const Color lightGrey =  Color(0XFF343537);

  static const Color field =  Color(0XFFd6d8d9);
  static const Color textField =  Color(0XFF444446);

  /// text and button sizes
  static const iconSize = 23.0;
  static const tiny = 10.0;
  static const xSmall = 11.0;
  static const small = 13.0;
  static const medium = 15.0;
  static const big = 17.0;
  static const large = 20.0;


  /// MediaQuery(width,height)
  static getDeviceWidthPercent (percent, context){
    return MediaQuery.of(context).size.width * (percent / 100);
  }
  static getDeviceHeightPercent (percent, context){
    return MediaQuery.of(context).size.height * (percent / 100);
  }

  ///url
  static void lunchURL(BuildContext context,String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      showTopSnackBar(context,
          CustomSnackBar.error(
            message: App_Localization.of(context).translate("something_went_wrong"),
          ));
    } else {
      await launchUrl(Uri.parse(url));
    }
  }

}
