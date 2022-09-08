import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/settings_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  
  SettingsController settingsController = Get.put(SettingsController());
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(100, context),
          color: App.darkGrey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 85),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: App.getDeviceWidthPercent(90, context),
                      child: Text("LUXURY SETTINGS CAR",
                        style: TextStyle(
                          letterSpacing: 1,
                          height: 1.3,
                          fontSize: CommonTextStyle.xXlargeTextStyle,
                          color: App.orange,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                language(context),
                const SizedBox(height: 20),
                location(context),
                const SizedBox(height: 20),
                CallWhatsapp(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  language(BuildContext context) {
    return Column(
      children: [
        Container(
          width: App.getDeviceWidthPercent(90, context),
          height: 45,
          decoration: const BoxDecoration(
              color: App.orange,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("language").toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: CommonTextStyle.mediumTextStyle,
                  letterSpacing: 0.3,
                  height: 1.3,
                ),),
            ],
          ),
        ),
        Container(
          width: App.getDeviceWidthPercent(90, context),
          decoration: BoxDecoration(
              color: App.grey,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if(Global.languageCode == "ar"){
                      Global.changeLanguage(context, "en");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/ar.svg",
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10,),
                      Text(App_Localization.of(context).translate("english"),
                        style: TextStyle(
                            fontSize: CommonTextStyle.mediumTextStyle,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                Divider(
                  color: App.lightGrey,
                  thickness: 1,
                ),
                const SizedBox(height: 5,),
                GestureDetector(
                  onTap: () {
                    if(Global.languageCode == "en"){
                      Global.changeLanguage(context, "ar");
                    }else {

                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/en.svg",
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10,),
                      Text(App_Localization.of(context).translate("arabic"),
                        style: TextStyle(
                            fontSize: CommonTextStyle.mediumTextStyle,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  location(BuildContext context) {
    return  Column(
      children: [
        Container(
          width: App.getDeviceWidthPercent(90, context),
          height: 45,
          decoration: const BoxDecoration(
              color: App.orange,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("location").toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: CommonTextStyle.mediumTextStyle,
                  letterSpacing: 0.3,
                  height: 1.3,
                ),),
            ],
          ),
        ),
        Container(
          width: App.getDeviceWidthPercent(90, context),
          decoration: BoxDecoration(
              color: App.grey,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )
          ),
          child: GestureDetector(
            onTap: () {
              homeController.openMap();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Ground Floor, Shop # 9 Mercure\n""Hotel Suites Apartment Sheikh\n""Zayed Road Dubai - UAE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: CommonTextStyle.mediumTextStyle,
                      letterSpacing: 0.3,
                      height: 1.3,
                    ),),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  CallWhatsapp(BuildContext context) {
    return  Column(
      children: [
        Container(
          width: App.getDeviceWidthPercent(90, context),
          height: 45,
          decoration: const BoxDecoration(
              color: App.orange,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("contact_us").toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: CommonTextStyle.mediumTextStyle,
                  letterSpacing: 0.3,
                  height: 1.3,
                ),),
            ],
          ),
        ),
        Container(
          width: App.getDeviceWidthPercent(90, context),
          decoration: BoxDecoration(
              color: App.grey,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if(await canLaunchUrl(Uri.parse('tel: +971 4 392 7704'))){
                    await launchUrl (Uri.parse('tel: +971 4 392 7704'));
                    }
                  },
                  child: Container(
                    width: App.getDeviceWidthPercent(40, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.call,color: App.orange,size: 23,),
                        const SizedBox(width: 5),
                        Text("+971 4 392 7704",
                          style: TextStyle(
                              fontSize: CommonTextStyle.mediumTextStyle,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Divider(
                  color: App.lightGrey,
                  thickness: 1,
                ),
                const SizedBox(height: 5,),
                GestureDetector(
                  onTap: () {
                    App.lunchURL(context,"https://api.whatsapp.com/send?phone=+971553451555&text=");
                  },
                  child: Container(
                    width: App.getDeviceWidthPercent(40, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.whatsapp,color: App.orange,size: 23,),
                        const SizedBox(width: 5),
                        Text("+971 55 345 1555",
                          style: TextStyle(
                              fontSize: CommonTextStyle.mediumTextStyle,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
