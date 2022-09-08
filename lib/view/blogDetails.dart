import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/widgets/container_with_image.dart';

class BlogDetails extends StatelessWidget {

  int index;

  BlogDetails(this.index) {}


  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();
  final ScrollController scrollController = ScrollController(initialScrollOffset: 50.0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top,),
                  _header(context),
                  SizedBox(height: 15),
                  _body(context),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        )
    );
  }


  _header(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/top-nav.png"),
              fit: BoxFit.cover
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: ContainerWithImage(
                  width: 30,
                  height: 30,
                  image: Global.languageCode == "en" ?
                  "assets/icons/back-icon.svg" :
                  "assets/icons/back-icon_arabic.svg",
                  option: 0
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                homeController.selectNavDrawer.value = 0;
              },
              child: Container(
                child: SvgPicture.asset("assets/icons/logo.svg",
                  width: 26,
                  height: 26,
                ),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: App.getDeviceWidthPercent(90, context),
          child: Text(
            Global.languageCode == "en" ?
            introductionController.blogs!.data!.blog[index].titleEn :
            introductionController.blogs!.data!.blog[index].titleAr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              letterSpacing: 1,
              height: 1.3,
              fontSize: CommonTextStyle.xXlargeTextStyle,
              color: App.orange,
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: App.getDeviceWidthPercent(90, context),
          height: App.getDeviceHeightPercent(30, context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      API.url + "/" + introductionController.blogs!.data!.blog[index].cover
                  ),
                  fit: BoxFit.cover
              )
          ),
        ),
        SizedBox(height: 20),
        Text(Global.languageCode == "en" ?
        introductionController.blogs!.data!.blog[index].titleEn :
        introductionController.blogs!.data!.blog[index].titleAr,
          style: TextStyle(
              color: Colors.white,
              fontSize: CommonTextStyle.mediumTextStyle
          ),
        ),
      ],
    );
  }
}
