import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/controller/rent_terms_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/drawer.dart';


class RentTermsPage extends StatelessWidget {
  RentTermsPage({Key? key}) : super(key: key);

  RentTermsController rentTermsController = Get.put(RentTermsController());
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: rentTermsController.key,
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            ContainerWithImage(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                image: "assets/images/bg-faq.png",
                option: 1
            ),
            rentTerms(context),
          ],
        )
    );
  }

  rentTerms(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 85),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Text(App_Localization.of(context).translate("rent_terms").toUpperCase(),
                  style: TextStyle(
                    fontSize: CommonTextStyle.xlargeTextStyle,
                    color: App.orange,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          body(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  body(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: ListView.builder(
          itemCount: introductionController.terms!.data!.terms.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context , index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                    width: App.getDeviceWidthPercent(90, context),
                    height: 45,
                    decoration: const BoxDecoration(
                        color: App.orange,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(Global.languageCode == "en" ?
                          introductionController.terms!.data!.terms[index].titleEn :
                          introductionController.terms!.data!.terms[index].titleAr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: CommonTextStyle.smallTextStyle,
                            ),),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: App.getDeviceWidthPercent(90, context),
                    decoration: BoxDecoration(
                        color: App.grey,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text( Global.languageCode == "en" ?
                            introductionController.terms!.data!.terms[index].descriptionEn :
                            introductionController.terms!.data!.terms[index].descriptionAr,
                            style: TextStyle(
                              fontSize: CommonTextStyle.xSmallTextStyle,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            );
          }
      ),
    );
  }
}
