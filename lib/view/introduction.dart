import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/widgets/container_with_image.dart';

class Introduction extends StatelessWidget {

  IntroductionController introductionController = Get.put(IntroductionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: App.getDeviceWidthPercent(100, context),
        height: App.getDeviceHeightPercent(100, context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/introo.png"),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Lottie.asset("assets/images/luxury_logo_animation.json",
            fit: BoxFit.contain,
          ),
        )
      )
    );
  }

}
