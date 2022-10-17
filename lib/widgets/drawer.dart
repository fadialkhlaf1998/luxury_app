import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/contact_us_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/helper/app.dart';

class CustomDrawer extends StatelessWidget {

  CustomDrawer();

  HomeController homeController = Get.find();
  ContactUsController contactUsController = Get.put(ContactUsController());


  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: SizedBox(
        width: App.getDeviceWidthPercent(60, context),
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: Container(
            width: App.getDeviceWidthPercent(60, context),
            decoration: const BoxDecoration(
                color: App.grey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                )
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).viewPadding.top),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  homeController.key.currentState!.openEndDrawer();
                                },
                                child: SvgPicture.asset("assets/icons/menu.svg",color: App.orange)
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          homeController.key.currentState!.openEndDrawer();
                        },
                        child: SizedBox(
                          width: 190,
                          child: SvgPicture.asset("assets/icons/logo.svg"),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              contactUsController.clearTextField();
                              homeController.selectNavDrawer.value = 0;
                              Get.back();
                              homeController.key.currentState!.openEndDrawer();
                            },
                            child: drawerText(homeController, 0, context, "about_us", App.medium, FontWeight.normal,"assets/icons/about.svg"),
                          ),
                          const SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              contactUsController.clearTextField();
                              homeController.selectNavDrawer.value = 1;
                              Get.back();
                              homeController.key.currentState!.openEndDrawer();
                            },
                            child: drawerText(homeController, 1, context, "faq",App.medium, FontWeight.normal,"assets/icons/faq.svg"),
                          ),
                          const SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              contactUsController.clearTextField();
                              homeController.selectNavDrawer.value = 2;
                              Get.back();
                              homeController.key.currentState!.openEndDrawer();
                            },
                            child: drawerText(homeController, 2, context, "blog",App.medium, FontWeight.normal,"assets/icons/blog.svg"),
                          ),
                          const SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              contactUsController.clearTextField();
                              homeController.selectNavDrawer.value = 3;
                              Get.back();
                              homeController.key.currentState!.openEndDrawer();
                            },
                            child: drawerText(homeController, 3, context, "rent_terms",App.medium, FontWeight.normal,"assets/icons/rent_terms.svg"),
                          ),
                          const SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              contactUsController.clearTextField();
                              homeController.selectNavDrawer.value = 4;
                              Get.back();
                              homeController.key.currentState!.openEndDrawer();
                            },
                            child: drawerText(homeController, 4, context, "contact_us",App.medium, FontWeight.normal,"assets/icons/contact.svg"),
                          ),
                          const SizedBox(height: 70),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width:App.getDeviceWidthPercent(60, context),
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            App.lunchURL(context,"https://www.instagram.com/accounts/login/?next=/luxurycarrental_ae/");
                          },
                          child: SvgPicture.asset("assets/icons/instagram.svg",width: 16,height: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            App.lunchURL(context, "https://www.facebook.com/luxurycarrental.ae/");
                          },
                          child: SvgPicture.asset("assets/icons/facebook.svg",width: 16,height: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            App.lunchURL(context, "https://twitter.com/luxurycarsdxb");
                          },
                          child: SvgPicture.asset("assets/icons/twitter.svg",width: 15,height: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            App.lunchURL(context, "https://www.youtube.com/channel/UCg8q_8DqhHBeqnkOSscbdUw");
                          },
                          child: SvgPicture.asset("assets/icons/youtube.svg",width: 15,height: 15),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
  ///text inside drawer
  static drawerText(HomeController homeController,int index ,BuildContext context,String text,double fontSize,FontWeight fontWeight,String icon) {
    return Container(
        width: App.getDeviceWidthPercent(100, context),
        color: homeController.selectNavDrawer.value == index ? App.lightDarkGrey.withOpacity(0.6) : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: Row(
            children: [
              SvgPicture.asset(icon,color: App.orange),
              const SizedBox(width: 20),
              Text(App_Localization.of(context).translate(text),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              )
            ],
          ),
        )
    );
  }

}