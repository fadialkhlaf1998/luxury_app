import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/about_us_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
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
              color: App.darkGrey,
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
          SizedBox(height: 70),
          body(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  body(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: introductionController.aboutUs!.data!.about.length,
        shrinkWrap: true,
        itemBuilder: (context,index) {
          return Column(
            children: [
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Html(
                  data: Global.languageCode == "en" ?
                  introductionController.aboutUs!.data!.about[index].titleEn :
                  introductionController.aboutUs!.data!.about[index].titleAr,
                  style: {
                    "body": Style(
                        fontSize: FontSize(CommonTextStyle.xSmallTextStyle),
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.3,
                        color: App.lightGrey,
                        textAlign: TextAlign.center
                    ),
                    "h1" : Style(
                        color: App.orange,
                        textAlign: TextAlign.center,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize(CommonTextStyle.xlargeTextStyle)
                    )
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(25, context),
                child: Image.network(API.url + "/" + introductionController.aboutUs!.data!.about[index].cover
                  , fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() => GestureDetector(
                      onTap: () {
                        aboutUsController.selected.value = 0 ;
                      },
                      child: Container(
                        width: App.getDeviceWidthPercent(40, context),
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: aboutUsController.selected.value == 0 ? App.orange : Colors.transparent,
                                )
                            )
                        ),
                        child: Center(
                          child: Text(App_Localization.of(context).translate("why_choose_us_title"),
                            style: TextStyle(
                              color: App.orange,
                              fontSize: CommonTextStyle.smallTextStyle,
                              fontWeight: FontWeight.w500,
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
                        width: App.getDeviceWidthPercent(40, context),
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: aboutUsController.selected.value != 0 ? App.orange : Colors.transparent
                                )
                            )
                        ),
                        child: Center(
                          child: Text(App_Localization.of(context).translate("what_do_we_offer_title"),
                            style: TextStyle(
                              color: App.orange,
                              fontSize: CommonTextStyle.smallTextStyle,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: App.getDeviceWidthPercent(85, context),
                child: aboutUsController.selected.value == 0 ?
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/icons/checkbox.svg",color: App.lightGrey,width: 25,height: 25,),
                        Container(
                          width:  App.getDeviceWidthPercent(75, context),
                          child: Text(App_Localization.of(context).translate("why_choose_us_content"),
                              style: TextStyle(
                                color: App.lightGrey,
                                fontSize: CommonTextStyle.xSmallTextStyle,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/icons/checkbox.svg",color: App.lightGrey,width: 25,height: 25,),
                        Container(
                          width:  App.getDeviceWidthPercent(75, context),
                          child: Text(App_Localization.of(context).translate("why_choose_us_content"),
                              style: TextStyle(
                                color: App.lightGrey,
                                fontSize: CommonTextStyle.xSmallTextStyle,
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
                        SvgPicture.asset("assets/icons/checkbox.svg",color: App.lightGrey,width: 25,height: 25,),
                        Container(
                          width: App.getDeviceWidthPercent(75, context),
                          child: Text(App_Localization.of(context).translate("what_do_we_offer_content"),
                          style: TextStyle(
                            color: App.lightGrey,
                            fontSize: CommonTextStyle.xSmallTextStyle,
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/icons/checkbox.svg",color: App.lightGrey,width: 25,height: 25,),
                        Container(
                          width: App.getDeviceWidthPercent(75, context),
                          child: Text(App_Localization.of(context).translate("what_do_we_offer_content"),
                              style: TextStyle(
                                color: App.lightGrey,
                                fontSize: CommonTextStyle.xSmallTextStyle,
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
