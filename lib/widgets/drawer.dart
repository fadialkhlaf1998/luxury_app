import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/widgets/container_with_image.dart';

class CustomDrawer extends StatelessWidget {

  CustomDrawer();

  IntroductionController introductionController = Get.find();
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      width: App.getDeviceWidthPercent(100, context),
      child: Drawer(
        child: Container(
          width: App.getDeviceWidthPercent(100, context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/nav-bg.webp",),
                  fit: BoxFit.cover
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: ContainerWithImage(
                              width: 28,
                              height: 28,
                              image: Global.languageCode == "en" ?
                              "assets/icons/back-icon.svg" :
                              "assets/icons/back-icon_arabic.svg",
                              option: 0
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          child: SvgPicture.asset("assets/icons/logo.svg",
                            width: 30,
                            height: 30
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
                SizedBox(height: 45),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeController.selectNavDrawer.value = 3;
                        Get.back();
                        homeController.key.currentState!.openEndDrawer();
                      },
                      child: drawerText(homeController, 3, context, "about_us", CommonTextStyle.mediumTextStyle, FontWeight.normal),
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        homeController.selectNavDrawer.value = 4;
                        Get.back();
                        homeController.key.currentState!.openEndDrawer();
                      },
                      child: drawerText(homeController, 4, context, "rent_terms",CommonTextStyle.mediumTextStyle, FontWeight.normal),
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        homeController.selectNavDrawer.value = 5;
                        Get.back();
                        homeController.key.currentState!.openEndDrawer();
                      },
                      child: drawerText(homeController, 5, context, "faq",CommonTextStyle.mediumTextStyle, FontWeight.normal),
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        homeController.selectNavDrawer.value = 6;
                        Get.back();
                        homeController.key.currentState!.openEndDrawer();
                      },
                      child: drawerText(homeController, 6, context, "blog",CommonTextStyle.mediumTextStyle, FontWeight.normal),
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        homeController.selectNavDrawer.value = 7;
                        Get.back();
                        homeController.key.currentState!.openEndDrawer();
                      },
                      child: drawerText(homeController, 7, context, "contact_us",CommonTextStyle.mediumTextStyle, FontWeight.normal),
                    ),

                    const SizedBox(height: 50),
                    Container(
                      width:App.getDeviceWidthPercent(60, context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              App.lunchURL(context,"https://www.instagram.com/accounts/login/?next=/luxurycarrental_ae/");
                            },
                            child: SvgPicture.asset("assets/icons/instagram.svg",width: 18,height: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              App.lunchURL(context, "https://www.facebook.com/luxurycarrental.ae/");
                            },
                            child: SvgPicture.asset("assets/icons/facebook.svg",width: 18,height: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              App.lunchURL(context, "https://twitter.com/luxurycarsdxb");
                            },
                            child: SvgPicture.asset("assets/icons/twitter.svg",width: 16,height: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              App.lunchURL(context, "https://www.youtube.com/channel/UCg8q_8DqhHBeqnkOSscbdUw");
                            },
                            child: SvgPicture.asset("assets/icons/youtube.svg",width: 16,height: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
  ///text inside drawer
  static drawerText(HomeController homeController,int index ,BuildContext context,String text,double fontSize,FontWeight fontWeight) {
    return Container(
        width: App.getDeviceWidthPercent(100, context),
        color: homeController.selectNavDrawer.value == index ? App.grey : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
              child: Text(App_Localization.of(context).translate(text).toUpperCase(),
                style: TextStyle(
                  color: homeController.selectNavDrawer.value == index ?  App.orange :  Colors.white,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              )
          ),
        )
    );
  }

}