import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/book_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/custom_button.dart';
import 'package:luxury_app/widgets/text_app.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Book extends StatelessWidget {

  Book();

  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();
  BookController bookController = Get.put(BookController());


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: App.darkGrey,
      body: SafeArea(
        child: Container(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(100, context),
          color: App.darkGrey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                const SizedBox(height: 15),
                _date(context),
                const SizedBox(height: 20),
                Container(
                  width: App.getDeviceWidthPercent(75, context),
                  child: Divider(
                    color: App.orange,
                    thickness: 2,
                  ),
                ),
                const SizedBox(height: 20),
                textFields(context),
                const SizedBox(height: 20),
                Container(
                  width: App.getDeviceWidthPercent(75, context),
                  child: Divider(
                    color: App.orange,
                    thickness: 2,
                  ),
                ),
                const SizedBox(height: 20),
                babySeat(context),
                const SizedBox(height: 15),
                additionalDriver(context),
                const SizedBox(height: 15),
                payNowLater(context),
                const SizedBox(height: 20),
                Container(
                  width: App.getDeviceWidthPercent(75, context),
                  child: Divider(
                    color: App.orange,
                    thickness: 2,
                  ),
                ),
                const SizedBox(height: 20),
                subTotalVatTotal(context),
                const SizedBox(height: 15),
                CustomButton(
                  width: App.getDeviceWidthPercent(90, context),
                  height: 50,
                  text: App_Localization.of(context).translate("confirmation").toUpperCase(),
                  onPressed: () {
                    /// confirm
                  },
                  color: App.orange,
                  borderRadius: 20,
                  textStyle: CommonTextStyle.textStyleForBigWhiteNormal,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: ContainerWithImage(
                width: 30,
                height: 30,
                image: Global.languageCode == "en" ?
                "assets/icons/back-icon.svg" :
                "assets/icons/back-icon_arabic.svg",
                option: 0
            ),
          ),
          Text(App_Localization.of(context).translate("your_info"),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: CommonTextStyle.bigTextStyle
            ),
          ),
          GestureDetector(
            onTap: () {
              bookController.clear();
            },
            child: Container(
              child: Row(
                children: const [
                  Text("Clear",
                    style: TextStyle(
                        color: App.orange,
                        fontSize: CommonTextStyle.mediumTextStyle
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _date(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/year.svg",fit: BoxFit.cover,width: 40,height: 40,color: Colors.white,),
            TextApp(text: App_Localization.of(context).translate("pick_date").toUpperCase(),
                textStyle: CommonTextStyle.textStyleForMediumWhiteNormal
            )
          ],
        ),
        const SizedBox(height: 15),
        perDayHour(context),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            dateDialog(context);
          },
          child: Container(
            width: App.getDeviceWidthPercent(90, context),
            height: 50,
            decoration: BoxDecoration(
              color: App.grey,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Center(
              child: Text(
                bookController.saveDate.value ? bookController.range.value :
                App_Localization.of(context).translate("pickup_and_dropOff_date"),
                style: TextStyle(
                  color: App.lightGrey,
                  fontSize: CommonTextStyle.mediumTextStyle
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        pickUpDropOffTime(context)
      ],
    );
  }
  perDayHour(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                bookController.selectRentalModel.value = 0;
              },
              child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 2)
                  ),
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bookController.selectRentalModel.value == 0 ? Colors.white : Colors.transparent
                      ),
                    ),
                  )
              ),
            ),
            const SizedBox(width: 8),
            Text(App_Localization.of(context).translate("daily"),
              style: CommonTextStyle.textStyleForMediumWhiteNormal,
            ),
          ],
        ),
        const SizedBox(width: 15),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                bookController.selectRentalModel.value = 1;
              },
              child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 2)
                  ),
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bookController.selectRentalModel.value != 0 ? Colors.white : Colors.transparent
                      ),
                    ),
                  )
              ),
            ),
            const SizedBox(width: 8),
            Text(App_Localization.of(context).translate("hour"),
              style: CommonTextStyle.textStyleForMediumWhiteNormal,
            ),
          ],
        ),
      ],
    );
  }
  dateDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return Column(
          children: [
            SizedBox(height: App.getDeviceHeightPercent(100, context)/3.1),
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: App.grey,
              child: Container(
                width: App.getDeviceWidthPercent(90, context),
                // height: App.getDeviceHeightPercent(40, context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    SfDateRangePicker(
                      onSelectionChanged: bookController.onSelectionDateChanges,
                      selectionMode: DateRangePickerSelectionMode.range,
                      minDate: DateTime.now(),
                      view: DateRangePickerView.month,
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: const TextStyle(
                            color: App.lightGrey
                          ),
                          backgroundColor: App.lightGrey.withOpacity(0.3),
                        ),
                      ),
                      initialSelectedRange: PickerDateRange(
                          DateTime.now().subtract(const Duration()),
                          DateTime.now().add(const Duration())
                      ),
                      selectionTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: CommonTextStyle.mediumTextStyle
                      ),
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(
                         color: Colors.white,
                         fontSize: CommonTextStyle.mediumTextStyle,
                        ),
                        disabledDatesTextStyle: TextStyle(
                            color: App.lightGrey,
                            fontSize: CommonTextStyle.mediumTextStyle,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                      yearCellStyle: const DateRangePickerYearCellStyle(
                        disabledDatesTextStyle: TextStyle(
                            color: App.lightGrey,
                            fontSize: CommonTextStyle.mediumTextStyle,
                            decoration: TextDecoration.lineThrough
                        ),
                        todayTextStyle: TextStyle(
                          fontSize: CommonTextStyle.mediumTextStyle
                        ),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: CommonTextStyle.mediumTextStyle
                        ),
                      ),
                      rangeSelectionColor: App.lightGrey.withOpacity(0.3),
                      rangeTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: CommonTextStyle.mediumTextStyle
                      ),
                      headerStyle: const DateRangePickerHeaderStyle(
                        textStyle: TextStyle(
                          color: App.orange,
                          fontSize: CommonTextStyle.mediumTextStyle,
                        ),
                      ),
                    ),
                    CustomButton(
                      width: App.getDeviceWidthPercent(40, context),
                      height: 40,
                      text: App_Localization.of(context).translate("confirmation").toUpperCase(),
                      onPressed: () {
                        bookController.saveDate.value = true;
                        print(bookController.range.value);
                        Get.back();
                      },
                      color: App.orange,
                      borderRadius: 15,
                      textStyle: CommonTextStyle.textStyleForBigWhiteNormal,
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            )
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.forward) {
          tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(0, 1), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
  pickUpDropOffTime(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: App.getDeviceWidthPercent(40, context),
            height: 40,
            decoration: BoxDecoration(
                color: App.grey,
                border: Border.all(
                  color: !bookController.pickUpValidate.value && bookController.pickTime.value=="non"? Colors.red : App.grey,
                ),
                borderRadius: BorderRadius.circular(15)
            ),
            child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownMaxHeight: 200,
                  isExpanded: true,
                  dropdownDecoration: BoxDecoration(
                    color: App.grey,
                  ),
                  buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                  hint: Text(App_Localization.of(context).translate("pickup_time"),
                    style: TextStyle(
                        color: App.lightGrey,
                        fontSize: CommonTextStyle.mediumTextStyle,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  iconEnabledColor: App.lightGrey,
                  value: bookController.pickTime.value=="non"? null : bookController.pickTime.value,
                  items: Global.pickUpTime.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: TextStyle(
                            color: App.lightGrey,
                            fontSize: CommonTextStyle.smallTextStyle,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  }).toList(),
                  underline: Container(),
                  onChanged: (val) {
                    bookController.pickTime.value=val.toString();
                  },
                ),
            ),
          ),
          Container(
            width: App.getDeviceWidthPercent(40, context),
            height: 40,
            decoration: BoxDecoration(
                color: App.grey,
                border: Border.all(
                  color: !bookController.dropOffValidate.value && bookController.dropTime.value=="non"? Colors.red : App.grey,
                ),
                borderRadius: BorderRadius.circular(15)
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                dropdownMaxHeight: 200,
                isExpanded: true,
                dropdownDecoration: BoxDecoration(
                  color: App.grey,
                ),
                buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                hint: Text(App_Localization.of(context).translate("dropOff_time"),
                  style: TextStyle(
                      color: App.lightGrey,
                      fontSize: CommonTextStyle.mediumTextStyle,
                      fontWeight: FontWeight.normal
                  ),
                ),
                iconEnabledColor: App.lightGrey,
                value: bookController.dropTime.value=="non"? null : bookController.dropTime.value,
                items: Global.pickUpTime.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                      style: TextStyle(
                          color: App.lightGrey,
                          fontSize: CommonTextStyle.smallTextStyle,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  );
                }).toList(),
                underline: Container(),
                onChanged: (val) {
                  bookController.dropTime.value=val.toString();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  textFields(BuildContext context) {
    return Column(
      children: [
        normalTextField(
          context: context,
          textStyle: CommonTextStyle.textStyleForMediumWhiteNormal,
          width: App.getDeviceWidthPercent(90, context),
          controller: bookController.name,
          validate: bookController.nameValidate.value,
          hintText: "name",
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: CommonTextStyle.mediumTextStyle
          ),
          errorText: App_Localization.of(context).translate("this_field_is_required"),
        ),
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: App.getDeviceWidthPercent(90, context),
                child: IntlPhoneField(
                  style: CommonTextStyle.textStyleForMediumWhiteNormal,
                  controller: bookController.phone,
                  cursorColor: Colors.white,
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
                    errorText: bookController.phoneValidate.value ? App_Localization.of(context).translate("this_field_is_required") : null,
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
        normalTextField(
          context: context,
          textStyle: CommonTextStyle.textStyleForMediumWhiteNormal,
          width: App.getDeviceWidthPercent(90, context),
          controller: bookController.email,
          validate: bookController.emailValidate.value,
          hintText: "email",
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: CommonTextStyle.mediumTextStyle
          ),
          errorText: App_Localization.of(context).translate("this_field_is_required"),
        ),
      ],
    );
  }
  babySeat(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextApp(
              text: App_Localization.of(context).translate("baby_seat"),
              textStyle: CommonTextStyle.textStyleForMediumWhiteNormal
          ),
          TextApp(
              text: "25 AED - " + App_Localization.of(context).translate("per_day"),
              textStyle: CommonTextStyle.textStyleForMediumOrangeNormal
          ),
          CupertinoSwitch(
            activeColor: App.orange,
            thumbColor: Colors.white,
            value: bookController.babySeatValue.value ,
            onChanged: (bool value) {
              bookController.babySeatValue.value = value;
            },
            trackColor: App.grey,
          ),
        ],
      ),
    );
  }
  additionalDriver(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextApp(
              text: App_Localization.of(context).translate("additional_driver").toUpperCase(),
              textStyle: CommonTextStyle.textStyleForMediumWhiteNormal
          ),
          TextApp(
              text: App_Localization.of(context).translate("free").toUpperCase(),
              textStyle: CommonTextStyle.textStyleForMediumOrangeNormal
          ),
          CupertinoSwitch(
            activeColor: App.orange,
            thumbColor: Colors.white,
            value: bookController.driverValue.value ,
            onChanged: (bool value) {
              bookController.driverValue.value = value;
            },
            trackColor: App.grey,
          ),
        ],
      ),
    );
  }
  payNowLater(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("pay_later"),
                style: CommonTextStyle.textStyleForMediumWhiteNormal,
              ),
              GestureDetector(
                onTap: () {
                  bookController.selectPay.value = 1;
                },
                child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white,width: 2)
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: bookController.selectPay.value == 1 ? Colors.white : Colors.transparent
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("pay_now"),
                style: CommonTextStyle.textStyleForMediumWhiteNormal,
              ),
              GestureDetector(
                onTap: () {
                  bookController.selectPay.value = 0;
                },
                child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white,width: 2)
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: bookController.selectPay.value == 0 ? Colors.white : Colors.transparent
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  subTotalVatTotal(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("sub_total:"),
                style: CommonTextStyle.textStyleForMediumWhiteNormal,
              ),
              Text("2250",
                style: CommonTextStyle.textStyleForMediumOrangeNormal,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("vat:"),
                style: CommonTextStyle.textStyleForMediumWhiteNormal,
              ),
              Text("10",
                style: CommonTextStyle.textStyleForMediumOrangeNormal,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("total:"),
                style: CommonTextStyle.textStyleForMediumWhiteNormal,
              ),
              Text("10",
                style: CommonTextStyle.textStyleForMediumOrangeNormal,
              ),
            ],
          ),
        ],
      ),
    );
  }


  /// static widget
  normalTextField({required BuildContext context, required TextStyle textStyle,required double width,
    double? height, TextAlignVertical? textAlignVertical,required TextEditingController controller,
    required String hintText,required TextStyle hintStyle, required bool validate,required String errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              hintText: App_Localization.of(context).translate(hintText),
              hintStyle: hintStyle,
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
              errorText: validate ? errorText : null,
            ),
          ),
        ),
      ],
    );
  }
}