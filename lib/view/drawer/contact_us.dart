import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/contact_us_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/widgets/custom_button.dart';
import 'package:luxury_app/widgets/drawer.dart';


class ContactUs extends StatelessWidget {

  ContactUs() {
  }

  ContactUsController contactUsController = Get.put(ContactUsController());
  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: contactUsController.key,
        drawer: CustomDrawer(homeController: homeController),
        body: Obx(() => Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
            ),
            contactUs(context),
          ],
        ))
    );
  }

  contactUs(BuildContext context) {
    return contactUsController.loading.value ?
        Container(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(100, context),
          color: App.darkGrey,
          child: const Center(
            child: CircularProgressIndicator(color: App.orange),
          ),
        ):
      SingleChildScrollView(
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
                child: Text(App_Localization.of(context).translate("contact_us").toUpperCase(),
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
          SizedBox(height: 30),
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
                contactUsController.key.currentState!.openDrawer();
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
    return Column(
      children: [
        textFields(context),
        SizedBox(height: 30,),

        SizedBox(height: 20),
      ],
    );
  }
  textFields(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      decoration: BoxDecoration(
          color: App.grey,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          App.normalTextField(
            context: context,
            textStyle: CommonTextStyle.textStyleForMediumWhiteNormal,
            width: App.getDeviceWidthPercent(80, context),
            controller: contactUsController.name,
            validate: contactUsController.nameValidate.value,
            hintText: "enter_name",
            hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: CommonTextStyle.mediumTextStyle
            ),
          ),
          SizedBox(height: 15),
          App.normalTextField(
            context: context,
            textStyle: CommonTextStyle.textStyleForMediumWhiteNormal,
            width: App.getDeviceWidthPercent(80, context),
            // height: App.getDeviceHeightPercent(8.5, context),
            controller: contactUsController.email,
            validate: contactUsController.emailValidate.value,
            // textAlignVertical: contactUsController.emailValidate.value ? TextAlignVertical.bottom : TextAlignVertical.center,
            hintText: "enter_email",
            hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: CommonTextStyle.mediumTextStyle
            ),
          ),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: App.getDeviceWidthPercent(80, context),
                  child: IntlPhoneField(
                    style: CommonTextStyle.textStyleForMediumWhiteNormal,
                    controller: contactUsController.phone,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: App.textField,
                      hintText: App_Localization.of(context).translate("enter_phone"),
                      hintStyle:  TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: CommonTextStyle.mediumTextStyle
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:  BorderSide(color: contactUsController.phoneValidate.value ? Colors.red : App.orange)
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: contactUsController.phoneValidate.value ? Colors.red : App.textField)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: contactUsController.phoneValidate.value ? Colors.red : App.textField)
                      ),
                    ),
                    initialCountryCode: 'AE',
                    disableLengthCheck: true,
                    dropdownIcon: Icon(Icons.arrow_drop_down_outlined,color: Colors.white.withOpacity(0.3),),
                    dropdownTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: CommonTextStyle.mediumTextStyle
                    ),
                    flagsButtonMargin: const EdgeInsets.symmetric(horizontal: 15),
                    showDropdownIcon: true,
                    dropdownIconPosition: IconPosition.trailing,
                    onChanged: (phone) {
                      print(phone.countryCode);
                    },
                  )
              ),
            ],
          ),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: App.getDeviceWidthPercent(80, context),
                // height: App.getDeviceHeightPercent(13, context),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  style: CommonTextStyle.textStyleForMediumWhiteNormal,
                  cursorColor: Colors.white,
                  controller: contactUsController.message,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: App.textField,
                      hintText: App_Localization.of(context).translate("enter_message"),
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: CommonTextStyle.mediumTextStyle
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:  BorderSide(color: App.orange)
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: App.textField)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: App.textField)
                      ),
                      contentPadding: EdgeInsets.only(top: 15,bottom: 70,left: 15,right: 15)
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          CustomButton(
            width: App.getDeviceWidthPercent(80, context),
            height: App.getDeviceHeightPercent(7, context),
            text: App_Localization.of(context).translate("send").toUpperCase(),
            onPressed: () {
              contactUsController.send(context, contactUsController.name.text,contactUsController.phone.text,
                  contactUsController.email.text,
                  contactUsController.message.text);
            },
            color: App.orange,
            borderRadius: 20,
            textStyle: CommonTextStyle.textStyleForBigWhiteNormal,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
