import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                image: "assets/images/bg-terms.png",
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
          SizedBox(height: Get.height * 0.12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: App.getDeviceWidthPercent(90, context),
                child: const Text("LUXURY RENT TERMS CAR",
                  style: TextStyle(
                    fontSize: App.large,
                    color: App.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          body(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  body(BuildContext context) {
    return SizedBox(
      width: App.getDeviceWidthPercent(90, context),
      child: ListView.builder(
          itemCount: introductionController.terms!.data!.terms.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context , index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                        child: Column(
                          children: [
                            Text((index + 1).toString(),
                              style: TextStyle(
                                  color: App.lightWhite.withOpacity(0.5),
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 38),
                        Text(Global.languageCode == "en" ?
                        introductionController.terms!.data!.terms[index].titleEn :
                        introductionController.terms!.data!.terms[index].titleAr,
                          style: const TextStyle(
                              color: App.orange,
                              fontSize: App.big,
                              fontWeight: FontWeight.bold
                          ),),
                        const SizedBox(height: 5),
                        Text(Global.languageCode == "en" ?
                        introductionController.terms!.data!.terms[index].descriptionEn :
                        introductionController.terms!.data!.terms[index].descriptionAr,
                          style: const TextStyle(
                            fontSize: App.small,
                            color: App.lightWhite,
                              fontWeight: FontWeight.normal
                          ),
                        )

                      ],
                    ),
                  )
                ],
              )
            );
          }
      ),
    );
  }
}
