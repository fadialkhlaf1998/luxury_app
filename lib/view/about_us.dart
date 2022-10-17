import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/about_us_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/widgets/drawer.dart';


class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);

  AboutUsController aboutUsController = Get.put(AboutUsController());
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: aboutUsController.key,
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.primary,
            ),
            about(context),
          ],
        )
    );
  }

  about(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.1,
            color: App.grey,
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
        itemCount: introductionController.aboutUs!.data!.about.length,
        shrinkWrap: true,
        itemBuilder: (context,index) {
          return Column(
            children: [
              // SizedBox(
              //   width: App.getDeviceWidthPercent(90, context),
              //   child: Html(
              //     data: Global.languageCode == "en" ?
              //     introductionController.aboutUs!.data!.about[index].titleEn :
              //     introductionController.aboutUs!.data!.about[index].titleAr,
              //     style: {
              //       "body": Style(
              //         fontSize: const FontSize(App.small),
              //         fontWeight: FontWeight.normal,
              //         color: App.lightWhite,
              //         textAlign: TextAlign.center
              //       ),
              //       "h1" : Style(
              //           color: App.orange,
              //           fontWeight: FontWeight.bold,
              //           fontSize: const FontSize(App.large),
              //           textAlign: TextAlign.center
              //       )
              //     },
              //   ),
              // ),
              // const SizedBox(height: 15),
              SizedBox(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(25, context),
                child: Image.network("${API.url}/${introductionController.aboutUs!.data!.about[index].cover}"
                  , fit: BoxFit.cover),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: App.getDeviceWidthPercent(90, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() => GestureDetector(
                      onTap: () {
                        aboutUsController.selected.value = 0 ;
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5,left: 5,right: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: aboutUsController.selected.value == 0 ? App.orange : Colors.transparent,
                                )
                            )
                        ),
                        child: Center(
                          child: Text(App_Localization.of(context).translate("why_choose_us_title"),
                            style: const TextStyle(
                              color: App.orange,
                              fontSize: App.small,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),),
                    Obx(() => GestureDetector(
                      onTap: () {
                        aboutUsController.selected.value = 1;
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5,left: 5,right: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: aboutUsController.selected.value != 0 ? App.orange : Colors.transparent
                                )
                            )
                        ),
                        child: Center(
                          child: Text(App_Localization.of(context).translate("what_do_we_offer_title"),
                            style: const TextStyle(
                              color: App.orange,
                              fontSize: App.small,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: App.getDeviceWidthPercent(85, context),
                child: aboutUsController.selected.value == 0 ?
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SvgPicture.asset("assets/icons/checkbox.svg",width: 20,height: 20,),
                        ),
                        Container(
                          width:  App.getDeviceWidthPercent(75, context),
                          child: Text(
                              App_Localization.of(context).translate("why_choose_us_content"),
                              style: const TextStyle(
                                color: App.lightWhite,
                                fontSize: App.xSmall,
                              )
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SvgPicture.asset("assets/icons/checkbox.svg",width: 20,height: 20,),
                        ),
                        SizedBox(
                          width:  App.getDeviceWidthPercent(75, context),
                          child: Text(App_Localization.of(context).translate("why_choose_us_content"),
                              style: const TextStyle(
                                color: App.lightWhite,
                                fontSize: App.xSmall,
                              )),
                        ),
                      ],
                    ),
                  ],
                ) :
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SvgPicture.asset("assets/icons/checkbox.svg",width: 20,height: 20,),
                        ),
                        SizedBox(
                          width: App.getDeviceWidthPercent(75, context),
                          child: Text(App_Localization.of(context).translate("what_do_we_offer_content"),
                          style: const TextStyle(
                            color: App.lightWhite,
                            fontSize: App.xSmall,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SvgPicture.asset("assets/icons/checkbox.svg",width: 20,height: 20,),
                        ),
                        SizedBox(
                          width: App.getDeviceWidthPercent(75, context),
                          child: Text(App_Localization.of(context).translate("what_do_we_offer_content"),
                              style: const TextStyle(
                                color: App.lightWhite,
                                fontSize: App.xSmall,
                              )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
