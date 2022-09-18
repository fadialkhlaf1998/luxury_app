import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';


class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(100, context),
          color: App.darkGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off,color: App.orange,size: 100),
              Container(
                width: App.getDeviceWidthPercent(90, context),
                height: App.getDeviceHeightPercent(10, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(App_Localization.of(context).translate("no_internet_connection"),
                          style: const TextStyle(
                            fontSize: CommonTextStyle.mediumTextStyle,
                            color: App.field,
                            fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  API.checkInternet().then((value) {
                    if (value) {
                      Get.back();
                    }
                  });
                },
                child: Container(
                    width: App.getDeviceWidthPercent(35, context),
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: App.orange
                    ),
                    child: Center(
                        child: Text(App_Localization.of(context).translate("please_try_again"),
                          style: const TextStyle(
                              fontSize: CommonTextStyle.smallTextStyle,
                              color: App.field,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


