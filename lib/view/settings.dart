import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/settings_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  
  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Container(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(100, context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg-faq.png"),
              fit: BoxFit.cover
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 85),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: App.getDeviceWidthPercent(90, context),
                      child: Text(App_Localization.of(context).translate("settings").toUpperCase(),
                        style: TextStyle(
                          fontSize: CommonTextStyle.xlargeTextStyle,
                          color: App.orange,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                language(context),
                SizedBox(height: settingsController.openLang.value == 0 ? 0 :  15),
                contactUs(context),
                SizedBox(height: settingsController.openContact.value == 0 ? 0 :  15),
                location(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  language(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap:(){
            if(settingsController.openLang.value == 0){
              settingsController.openLang.value = -1;
            }
            else{
              settingsController.openLang.value = 0;
            }
          },
          child: Container(
            width: App.getDeviceWidthPercent(100, context),
            decoration: const BoxDecoration(
              border: Border(
                 bottom: BorderSide( //                    <--- top side
                  color: Colors.white,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(App_Localization.of(context).translate("language").toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: CommonTextStyle.smallTextStyle + 1,
                    ),),
                  Icon(
                    settingsController.openLang.value == 0 ?
                    Icons.keyboard_arrow_down : Global.languageCode == "ar" ? Icons.keyboard_arrow_left :
                    Icons.keyboard_arrow_right,
                    size: 23,color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
          child: Container(
            width: App.getDeviceWidthPercent(100, context),
            child: settingsController.openLang.value != 0
                ? Center()
                :  Container(
              width: App.getDeviceWidthPercent(100, context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        if(Global.languageCode == "ar"){
                          Global.changeLanguage(context, "en");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/icons/ar.svg",
                            fit: BoxFit.cover,
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(width: 10,),
                          Text(App_Localization.of(context).translate("english"),
                            style: TextStyle(
                                fontSize: CommonTextStyle.smallTextStyle,
                                color: App.lightGrey
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if(Global.languageCode == "en"){
                          Global.changeLanguage(context, "ar");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/icons/en.svg",
                            fit: BoxFit.cover,
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(width: 10,),
                          Text("اللغة العربية",
                            style: TextStyle(
                                fontSize: CommonTextStyle.smallTextStyle,
                                color: App.lightGrey
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  contactUs(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap:(){
            if(settingsController.openContact.value == 0){
              settingsController.openContact.value = -1;
            }
            else{
              settingsController.openContact.value = 0;
            }
          },
          child: Container(
            width: App.getDeviceWidthPercent(100, context),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide( //                    <--- top side
                  color: Colors.white,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(App_Localization.of(context).translate("contact_us").toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: CommonTextStyle.smallTextStyle + 1,
                    ),),
                  Icon(
                    settingsController.openContact.value == 0 ?
                    Icons.keyboard_arrow_down : Global.languageCode == "ar" ? Icons.keyboard_arrow_left :
                    Icons.keyboard_arrow_right,
                    size: 23,color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
          child: Container(
            width: App.getDeviceWidthPercent(100, context),
            child: settingsController.openContact.value != 0
                ? Center()
                :  Container(
              width: App.getDeviceWidthPercent(100, context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        if(await canLaunchUrl(Uri.parse('tel: +971 4 392 7704'))){
                          await launchUrl (Uri.parse('tel: +971 4 392 7704'));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.call,color: App.orange,size: 20,),
                          const SizedBox(width: 5),
                          Text("+971 4 392 7704",
                            style: TextStyle(
                                fontSize: CommonTextStyle.smallTextStyle + 1,
                                color: App.lightGrey
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        App.lunchURL(context,"https://api.whatsapp.com/send?phone=+971553451555&text=");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.whatsapp,color: App.orange,size: 20,),
                          const SizedBox(width: 5),
                          Text("+971 55 345 1555",
                            style: TextStyle(
                                fontSize: CommonTextStyle.smallTextStyle + 1,
                                color: App.lightGrey
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide( //                    <--- top side
                color: Colors.white,
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("location").toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: CommonTextStyle.smallTextStyle + 1,
                  ),),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(),
          child: Container(
            width: App.getDeviceWidthPercent(100, context),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
            ),
            child: GestureDetector(
              onTap: () {
                settingsController.openMap();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Ground Floor, Shop # 9 Mercure\n""Hotel Suites Apartment Sheikh\n""Zayed Road Dubai - UAE",
                      style: TextStyle(
                        color: App.lightGrey,
                        fontSize: CommonTextStyle.smallTextStyle,
                      ),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


}
