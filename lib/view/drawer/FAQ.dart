import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/faq_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/drawer.dart';

class FAQ extends StatelessWidget {

  FAQ(){
    faqController.open.value = 0;
  }

  FAQController faqController = Get.put(FAQController());
  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: faqController.key,
        drawer: CustomDrawer(homeController: homeController),
        body: Stack(
          children: [
            ContainerWithImage(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                image: "assets/images/bg-faq.png",
                option: 1
            ),
            faq(context),
          ],
        )
    );
  }

  faq(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 70),
          // header(context),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Text("LUXURY FAQ CAR",
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
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Text("Luxury Rental Car Company Specializes In Cars Of The Premium Segment. We Know How To Please A Demanding Client And How To Provide Rental Services Of The Highest Quality. Being Our Client, You Will Feel A Superb Level Of Luxury And Comfort.",
                  style: TextStyle(
                    letterSpacing: 0.3,
                    height: 1.3,
                    fontSize: CommonTextStyle.mediumTextStyle,
                    color: App.lightGrey,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Center(
            child: Text("FEQs: GET MORE Information About Car Rental Services",
              style: TextStyle(
                  fontSize: CommonTextStyle.tinyTextStyle,
                  color: Colors.white
              ),
            ),
          ),
          body(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  header(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/top-nav.png"),
              fit: BoxFit.cover
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                faqController.key.currentState!.openDrawer();
              },
              child: Icon(Icons.menu,size: CommonTextStyle.headerIcons,color: App.orange),
            ),
            GestureDetector(
              onTap: () {
                homeController.selectNavDrawer.value = 0;
                homeController.key.currentState!.openEndDrawer();
              },
              child: Container(
                child: SvgPicture.asset("assets/icons/logo.svg",
                  width: 28,
                  height: 28,
                ),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
  body(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: introductionController.faq!.data!.faq.length,
        itemBuilder: (context,index) {
          return Obx(() => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap:(){
                    if(faqController.open.value == index){
                      faqController.open.value = -1;
                    }
                    else{
                      faqController.open.value = index;
                    }
                  },
                  child: Container(
                    width: App.getDeviceWidthPercent(90, context),
                    decoration: BoxDecoration(
                        color: faqController.open.value == index ? App.orange : App.grey,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: faqController.open.value == index ? Radius.circular(0) : Radius.circular(10),
                          bottomRight: faqController.open.value == index ? Radius.circular(0) : Radius.circular(10),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContainerWithImage(
                              width: 25,
                              height: 25,
                              image: "assets/images/faq.png",
                              option: 1
                          ),
                          Container(
                            width: App.getDeviceWidthPercent(63, context),
                            child: Text(Global.languageCode == "en" ?
                            introductionController.faq!.data!.faq[index].questionEn :
                            introductionController.faq!.data!.faq[index].questionAr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: CommonTextStyle.mediumTextStyle,
                                letterSpacing: 0.3,
                                height: 1.3,
                              ),),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  child: Container(
                    width: App.getDeviceWidthPercent(90, context),
                    child: !(faqController.open.value == index)
                        ? Center()
                        :  Container(
                      width: App.getDeviceWidthPercent(90, context),
                      decoration: BoxDecoration(
                          color: App.grey,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: faqController.open.value == index ? Radius.circular(0) : Radius.circular(10),
                            topRight: faqController.open.value == index ? Radius.circular(0) : Radius.circular(10),
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: App.getDeviceWidthPercent(80, context),
                              child: Text(Global.languageCode == "en" ?
                              introductionController.faq!.data!.faq[index].answerEn :
                              introductionController.faq!.data!.faq[index].answerAr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: CommonTextStyle.mediumTextStyle,
                                  letterSpacing: 0.3,
                                  height: 1.3,
                                ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        }
      ),
    );
  }
}
