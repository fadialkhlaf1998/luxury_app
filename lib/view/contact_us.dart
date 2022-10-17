import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/contact_us_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/widgets/custom_button.dart';
import 'package:luxury_app/widgets/drawer.dart';

class ContactUs extends StatelessWidget {

  ContactUsController contactUsController = Get.find();
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: contactUsController.key,
        drawer: CustomDrawer(),
        body: Obx(() => Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.primary,
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
          color: App.primary,
          child: const Center(
            child: CupertinoActivityIndicator(color: App.orange),
          ),
        ):
      SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: App.getDeviceWidthPercent(90, context),
                child: const Text("LUXURY CONTACT US CAR",
                  style: TextStyle(
                    fontSize: App.large,
                    color: App.orange,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          body(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  body(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      decoration: BoxDecoration(
          color: App.grey,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Center(
            child: Text(App_Localization.of(context).translate("need_help_with_choosing_car?"),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: App.small
              ),
            ),
          ),
          const SizedBox(height: 10),
          normalTextField(
            height: 45,
            text: "name",
            context: context,
            textStyle: const TextStyle(
                fontSize: App.medium,
                color: Colors.white,
                fontWeight: FontWeight.normal
            ),
            width: App.getDeviceWidthPercent(80, context),
            controller: contactUsController.name,
            validate: contactUsController.nameValidate.value,
            textAlignVertical: TextAlignVertical.top
          ),
          const SizedBox(height: 10),
          normalTextField(
            height: 45,
            text: "email",
            context: context,
            textStyle: const TextStyle(
                fontSize: App.medium,
                color: Colors.white,
                fontWeight: FontWeight.normal
            ),
            width: App.getDeviceWidthPercent(80, context),
            controller: contactUsController.email,
            validate: contactUsController.emailValidate.value,
            textAlignVertical: TextAlignVertical.top
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(App_Localization.of(context).translate("phone").toUpperCase(),
                style: const TextStyle(
                    fontSize: App.small,
                    color: App.lightWhite,
                    fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: App.getDeviceWidthPercent(80, context),
                  height: 45,
                  child: IntlPhoneField(
                    textAlign: Global.languageCode == "en" ?
                        TextAlign.left : TextAlign.right,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(
                        fontSize: App.medium,
                        color: Colors.white,
                        fontWeight: FontWeight.normal
                    ),
                    controller: contactUsController.phone,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: App.textField,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:  BorderSide(color: contactUsController.phoneValidate.value ? Colors.red : Colors.transparent)
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: contactUsController.phoneValidate.value ? Colors.red : Colors.transparent)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: contactUsController.phoneValidate.value ? Colors.red : Colors.transparent)
                      ),
                    ),
                    initialCountryCode: 'AE',
                    disableLengthCheck: true,
                    dropdownIcon: Icon(Icons.arrow_drop_down_outlined,color: Colors.white.withOpacity(0.3),),
                    dropdownTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: App.medium
                    ),
                    flagsButtonMargin: const EdgeInsets.symmetric(horizontal: 15),
                    showDropdownIcon: true,
                    dropdownIconPosition: IconPosition.trailing,
                    onChanged: (phone) {
                      int max = countries.firstWhere((element) => element.code == phone.countryISOCode).maxLength;
                      if(contactUsController.phone.text.length > max){
                        contactUsController.phone.text = contactUsController.phone.text.substring(0,max);
                      }
                    },
                  )
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(App_Localization.of(context).translate("message").toUpperCase(),
                style: const TextStyle(
                    fontSize: App.small,
                    color: App.lightWhite,
                    fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: App.getDeviceWidthPercent(80, context),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(
                      fontSize: App.medium,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                  ),
                  cursorColor: Colors.white,
                  controller: contactUsController.message,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: App.textField,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:  const BorderSide(color: Colors.transparent)
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.transparent)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.transparent)
                      ),
                      contentPadding: const EdgeInsets.only(top: 15,bottom: 50,left: 15,right: 15)
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomButton(
            width: App.getDeviceWidthPercent(80, context),
            height: 40,
            text: App_Localization.of(context).translate("send").toUpperCase(),
            onPressed: () {
              contactUsController.send(context, contactUsController.name.text,contactUsController.phone.text,
                  contactUsController.email.text,
                  contactUsController.message.text);
            },
            color: App.orange,
            borderRadius: 10,
            textStyle: const TextStyle(
                fontSize: App.medium,
                color: Colors.white,
                fontWeight: FontWeight.normal
            )
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  static normalTextField({required String text,required BuildContext context, required TextStyle textStyle,required double width,
    double? height, TextAlignVertical? textAlignVertical,required TextEditingController controller, required bool validate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate(text).toUpperCase(),
          style: const TextStyle(
              fontSize: App.small,
              color: App.lightWhite,
              fontWeight: FontWeight.normal
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: width,
          height: height,
          child: TextField(
            textAlignVertical: textAlignVertical,
            style: textStyle,
            cursorColor: Colors.white,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: App.textField,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:  BorderSide(color:  validate ? Colors.red : Colors.transparent)
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color:  validate ? Colors.red : Colors.transparent)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color:  validate ? Colors.red : Colors.transparent)
              ),
            ),
            onSubmitted: (pressed){
              // print('Pressed via keypad');
              // print(pressed.length);
              // if(contactUsController.name.text.isNotEmpty || contactUsController.email.text.isNotEmpty
              // || contactUsController.phone.text.isNotEmpty || contactUsController.message.text.isNotEmpty) {
              //   print('done');
              // }else {
              //   contactUsController.clearTextField();
              // }
              }
          ),
        ),
      ],
    );
  }
}
