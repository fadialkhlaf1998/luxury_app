import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/settings_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {

  Settings() {
    if(Global.languageCode == "en") {
      settingsController.selectValue.value = 0;
    }
    else {
      settingsController.selectValue.value = 1;
    }
  }
  
  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: App.primary,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.primary,
            ),
            body(context),
          ],
        )
    );
  }

  body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.13),
          language(context),
          const SizedBox(height: 20),
          SizedBox(
            width: Get.width * 0.9,
            child: const Divider(
              color: App.lightGrey,
              thickness: 5,
            ),
          ),
          const SizedBox(height: 20),
          ourWebsite(context),
          const SizedBox(height: 20),
          SizedBox(
            width: Get.width * 0.9,
            child: const Divider(
              color: App.lightGrey,
              thickness: 5,
            ),
          ),
          const SizedBox(height: 20),
          contactUs(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  language(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("language").toUpperCase(),
            style: const TextStyle(
              fontSize: App.large,
              color: App.orange,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: settingsController.languages.length,
              itemBuilder: (context,index) {
                return Obx(()=> GestureDetector(
                  onTap: () {
                    Global.changeLanguage(context, settingsController.languages[index]['id']);
                    settingsController.selectValue.value = index;
                    if(settingsController.languages[index]['id'] == "en") {
                      settingsController.languageValue = settingsController.languages[index]["name"];
                    }
                    else {
                      settingsController.languageValue = settingsController.languages[index]["name"];
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            settingsController.languages[index]['id'] == "en"?
                            App_Localization.of(context).translate("english").toUpperCase() :
                            App_Localization.of(context).translate("arabic").toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: App.medium,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Global.changeLanguage(context, settingsController.languages[index]['id']);
                              settingsController.selectValue.value = index;
                              if(settingsController.languages[index]['id'] == "en") {
                                settingsController.languageValue = settingsController.languages[index]["name"];
                              }
                              else {
                                settingsController.languageValue = settingsController.languages[index]["name"];
                              }
                            },
                            child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white,width: 1)
                                ),
                                child: Center(
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: settingsController.selectValue.value == index ?
                                        App.orange : Colors.transparent
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
  ourWebsite(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("our_website").toUpperCase(),
            style: const TextStyle(
              fontSize: App.large,
              color: App.orange,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () async{
              if(await canLaunchUrl(Uri.parse('https://new.luxurycarrental.ae/'))){
                await launchUrl (Uri.parse('https://new.luxurycarrental.ae/'));
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.language,color: App.orange,size: App.iconSize),
                const SizedBox(width: 5),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white)
                    )
                  ),
                  child: Text("new.luxurycarrental.ae/".toUpperCase(),
                    style: const TextStyle(
                      fontSize: App.small,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  contactUs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("contact_us").toUpperCase(),
            style: const TextStyle(
              fontSize: App.large,
              color: App.orange,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  if(await canLaunchUrl(Uri.parse('tel: +971 58 129 6445'))){
                    await launchUrl (Uri.parse('tel: +971 58 129 6445'));
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.call,color: App.orange,size: App.iconSize),
                    SizedBox(width: 5),
                    Text("+971 58 129 6445",
                      style: TextStyle(
                        fontSize: App.small,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async{
                  await launch("https://wa.me/971581296445/?text=${Uri.parse("I need to contact")}");
                  // App.lunchURL(context,"https://api.whatsapp.com/send/?phone=%2B971581296445&text=Hi+LUXURY+Car+Rental%2C+I+would+like+to+inquire+about+Audi+RS+Q8&type=phone_number&app_absent=0");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.whatsapp,color: App.orange,size: App.iconSize),
                    SizedBox(width: 5),
                    Text("+971 58 129 6445",
                      style: TextStyle(
                        fontSize: App.small,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  settingsController.openMap();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.location_on,color: App.orange,size: App.iconSize + 2),
                    SizedBox(width: 5),
                    Text("Ground Floor, Shop # 9 Mercure\n""Hotel Suites Apartment Sheikh\n""Zayed Road Dubai - UAE",
                      style: TextStyle(
                        fontSize: App.small,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
