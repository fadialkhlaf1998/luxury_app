import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/faq_controller.dart';
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
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: faqController.key,
        drawer: CustomDrawer(),
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
          SizedBox(height: Get.height * 0.12),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: App.getDeviceWidthPercent(90, context),
          //       child: const Text("LUXURY FAQ CAR",
          //         style: TextStyle(
          //           fontSize: App.large,
          //           color: App.orange,
          //           fontWeight: FontWeight.bold,
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: App.getDeviceWidthPercent(90, context),
          //       child: const Text("Luxury Rental Car Company Specializes In Cars Of The Premium Segment. We Know How To Please A Demanding Client And How To Provide Rental Services Of The Highest Quality. Being Our Client, You Will Feel A Superb Level Of Luxury And Comfort.",
          //         style: TextStyle(
          //           fontSize: App.small,
          //           color: App.lightWhite,
          //           fontWeight: FontWeight.normal,
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 25),
          const Center(
            child: Text("FEQs: GET MORE Information About Car Rental Services",
              style: TextStyle(
                  fontSize: App.tiny,
                  color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          body(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  body(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: introductionController.faq!.data!.faq.length,
        itemBuilder: (context,index) {
          return Obx(() => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
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
                          topRight: const Radius.circular(10),
                          topLeft: const Radius.circular(10),
                          bottomLeft: faqController.open.value == index ? const Radius.circular(0) : const Radius.circular(10),
                          bottomRight: faqController.open.value == index ? const Radius.circular(0) : const Radius.circular(10),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContainerWithImage(
                              width: faqController.open.value == index ? 35 : 25,
                              height: faqController.open.value == index ? 35 : 25,
                              image: "assets/icons/ask.svg",
                              option: 0,
                            color: faqController.open.value == index ? App.grey : App.orange,
                          ),
                          SizedBox(
                            width: App.getDeviceWidthPercent(63, context),
                            child: Text(Global.languageCode == "en" ?
                            introductionController.faq!.data!.faq[index].questionEn :
                            introductionController.faq!.data!.faq[index].questionAr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: App.small,
                                fontWeight: FontWeight.w600
                              ),),
                          ),
                          Icon(faqController.open.value == index ?
                             Icons.keyboard_arrow_up :
                             Icons.keyboard_arrow_down,
                            color: faqController.open.value == index ?
                            Colors.black : Colors.white,
                            size: App.iconSize)
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  child: SizedBox(
                    width: App.getDeviceWidthPercent(90, context),
                    child: !(faqController.open.value == index)
                        ? const Center()
                        :  Container(
                      width: App.getDeviceWidthPercent(90, context),
                      decoration: BoxDecoration(
                          color: App.grey,
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(10),
                            bottomRight: const Radius.circular(10),
                            topLeft: faqController.open.value == index ? const Radius.circular(0) : const Radius.circular(10),
                            topRight: faqController.open.value == index ? const Radius.circular(0) : const Radius.circular(10),
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: App.getDeviceWidthPercent(80, context),
                              child: Text(Global.languageCode == "en" ?
                              introductionController.faq!.data!.faq[index].answerEn :
                              introductionController.faq!.data!.faq[index].answerAr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: App.xSmall,
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
