import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/widgets/custom_button.dart';


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
          color: App.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/no_internet.png")
                    )
                ),
              ),
              SizedBox(
                width: App.getDeviceWidthPercent(90, context),
                height: App.getDeviceHeightPercent(10, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: App.large,
                        color: App.lightWhite,
                        fontWeight: FontWeight.bold
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(App_Localization.of(context).translate("no_internet_connection"))
                        ],
                        isRepeatingAnimation: true,
                        onTap: () {

                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                  width: App.getDeviceWidthPercent(70, context),
                  height: 50,
                  text: App_Localization.of(context).translate("please_try_again").toUpperCase(),
                  onPressed: () {
                    API.checkInternet().then((value) {
                      if (value) {
                        Get.back();
                      }
                    });
                  },
                  color: Color(0xFFfea803),
                  borderRadius: 8,
                  textStyle: const TextStyle(
                      fontSize: App.medium,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }


}


