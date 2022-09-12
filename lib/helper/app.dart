import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class App{

  static const Color field =  Color(0XFFd6d8d9);
  static const Color darkGrey =  Color(0XFF1e1f21);
  static const Color lightDarkGrey =  Color(0XFF212325);
  static const Color grey =  Color(0XFF333436);
  static const Color orange =  Color(0XFFd5a054);
  static const Color lightGrey =  Color(0XFF94918e);
  static const Color textField =  Color(0XFF444446);

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
      errorTopBar(context, "something_wrong");
    } else {
      await launchUrl(Uri.parse(url));
    }
  }

  ///top bar message
  static errorTopBar(BuildContext context,String msg) {
    return showTopSnackBar(context,
    CustomSnackBar.error(message: msg));
  }
  static successTopBar(BuildContext context,String msg) {
    return showTopSnackBar(context,
        CustomSnackBar.success(
          message: msg,
          backgroundColor: orange,
        ));
  }

  static normalTextField({required BuildContext context, required TextStyle textStyle,required double width,
    double? height, TextAlignVertical? textAlignVertical,required TextEditingController controller,
    required String hintText,required TextStyle hintStyle, required bool validate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          child: TextField(
            textAlignVertical: textAlignVertical,
            style: textStyle,
            cursorColor: Colors.white,
            controller: controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: App.textField,
                hintText: App_Localization.of(context).translate(hintText),
                hintStyle: hintStyle,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color:  validate ? Colors.red : App.orange)
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color:  validate ? Colors.red : App.textField)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color:  validate ? Colors.red : App.textField)
                ),
            ),
          ),
        ),
      ],
    );
  }

}

abstract class CommonTextStyle {

  static const tinyTextStyle = 12.0;
  static const xSmallTextStyle = 13.0;
  static const smallTextStyle = 14.0;
  static const mediumTextStyle = 16.0;
  static const bigTextStyle = 18.0;
  static const largeTextStyle = 20.0;
  static const xlargeTextStyle = 22.0;
  static const xXlargeTextStyle = 26.0;
  static const headerIcons = 30.0;


  /// white

  static const textStyleForTinyWhiteNormal = TextStyle(
      fontSize: tinyTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.normal
  );

  static const textStyleForXSmallWhiteNormal = TextStyle(
      fontSize: xSmallTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.normal
  );

  static const textStyleForSmallWhiteHalfBold = TextStyle(
      fontSize: smallTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.w500
  );

  static const textStyleForMediumWhiteNormal = TextStyle(
      fontSize: mediumTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.normal
  );

  static const textStyleForMediumWhiteHalfBold = TextStyle(
      fontSize: mediumTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.w500
  );

  static const textStyleForBigWhiteNormal = TextStyle(
      fontSize: bigTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.normal
  );

  static const textStyleForLargeWhiteBold = TextStyle(
      fontSize: largeTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.bold
  );


  /// orange
  static const textStyleForMediumOrangeNormal = TextStyle(
      fontSize: mediumTextStyle,
      color: App.orange,
      fontWeight: FontWeight.normal
  );

  static const textStyleForBigOrangeBold = TextStyle(
      fontSize: bigTextStyle,
      color: App.orange,
      fontWeight: FontWeight.bold
  );

  static const textStyleForXLargeOrangeBold = TextStyle(
      fontSize: xlargeTextStyle,
      color: App.orange,
      fontWeight: FontWeight.bold
  );


  /// field
  static const textStyleForMediumField = TextStyle(
      fontSize: mediumTextStyle,
      color: App.field,
      fontWeight: FontWeight.normal
  );

}