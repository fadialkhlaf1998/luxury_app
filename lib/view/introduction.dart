import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/widgets/container_with_image.dart';

class Introduction extends StatelessWidget {

  IntroductionController introductionController = Get.put(IntroductionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerWithImage(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(100, context),
          image: "assets/images/intro.png",
          option: 1
      )
    );
  }

}
