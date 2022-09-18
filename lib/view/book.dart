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
import 'package:luxury_app/model/all-cars.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/custom_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class Book extends StatelessWidget {

  Book(Car car){
    bookController.car = car;
  }

  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();
  BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: App.darkGrey,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
            ),
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    SizedBox(height: 15),
                    _stepper(context),
                    SizedBox(height: 15),
                    _body(context),
                  ],
                ),
              ),
            ),
            bookController.loading.value ?
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.darkGrey,
                child: Center(
                  child: CircularProgressIndicator(
                    color: App.orange,
                  ),
                )
              ) : Center()
          ],
        )
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
              bookController.clear();
              Get.back();
            },
            child: ContainerWithImage(
                width: 28,
                height: 28,
                image: Global.languageCode == "en" ?
                "assets/icons/back-icon.svg" :
                "assets/icons/back-icon_arabic.svg",
                option: 0
            ),
          ),
          Text(App_Localization.of(context).translate("your_info"),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: CommonTextStyle.mediumTextStyle
            ),
          ),
          GestureDetector(
            onTap: () {
              bookController.clear();
              Get.back();
            },
            child: Container(
              child: Row(
                children: const [
                  Text("Clear",
                    style: TextStyle(
                        color: App.orange,
                        fontSize: CommonTextStyle.smallTextStyle + 1
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
  _stepper(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 20),
          Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: bookController.activeCurrentStep.value < 0 ? App.lightGrey : App.orange,
                      width: 2)
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:  bookController.activeCurrentStep.value < 0 ? App.lightGrey : App.orange,
                  ),
                ),
              )
          ),
          Expanded(child: Divider(
              color: bookController.activeCurrentStep.value < 1 ? App.lightGrey : App.orange, thickness: 1.2),),
          Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: bookController.activeCurrentStep.value < 1 ? App.lightGrey : App.orange,
                      width: 2)
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:  bookController.activeCurrentStep.value < 1 ? App.lightGrey : App.orange,
                  ),
                ),
              )
          ),
          Expanded(child: Divider(
              color: bookController.activeCurrentStep.value < 2 ? App.lightGrey : App.orange,thickness: 1.2),),
          Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: bookController.activeCurrentStep.value < 2 ? App.lightGrey : App.orange,
                      width: 2)
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:  bookController.activeCurrentStep.value < 2 ? App.lightGrey : App.orange,
                  ),
                ),
              )
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.22 - 24,
      width: App.getDeviceWidthPercent(100, context),
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: bookController.activeCurrentStep.value < 1 ? _date(context) :
            bookController.activeCurrentStep.value < 2 ? textFields(context) :
            Column(
              children: [
                babySeat(context),
                const SizedBox(height: 20),
                additionalDriver(context),
                const SizedBox(height: 20),
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
              ],
            ),
          ),
          MediaQuery.of(context).viewInsets.bottom == 0 ?
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  width: App.getDeviceWidthPercent(35, context),
                  height: 40,
                  text: App_Localization.of(context).translate("back").toUpperCase(),
                  onPressed: () {
                    bookController.backwardStep();
                  },
                  color: App.orange,
                  borderRadius: 10,
                  textStyle: CommonTextStyle.textStyleForMediumWhiteNormal,
                ),
                CustomButton(
                  width: App.getDeviceWidthPercent(35, context),
                  height: 40,
                  text: App_Localization.of(context).translate("next").toUpperCase(),
                  onPressed: () {
                    bookController.forwardStep(context);
                  },
                  color: App.orange,
                  borderRadius: 10,
                  textStyle: CommonTextStyle.textStyleForMediumWhiteNormal,
                ),
              ],
            ),
          ) : Text(''),
        ],
      )
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
            Text(App_Localization.of(context).translate("pick_date").toUpperCase(),
              style: CommonTextStyle.textStyleForMediumWhiteNormal
            ),
          ],
        ),
        const SizedBox(height: 20),
        perDayHour(context),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            dateDialog(context);
          },
          child: Container(
            width: App.getDeviceWidthPercent(90, context),
            height: 45,
            decoration: BoxDecoration(
              color: App.grey,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: !bookController.pickUpValidate.value && !bookController.saveDate.value ? Colors.red : App.grey,
              )
            ),
            child: Center(
              child: Text(
                bookController.saveDate.value ? bookController.range.value :
                App_Localization.of(context).translate("pickup_and_dropOff_date"),
                style: const TextStyle(
                  color: App.lightGrey,
                  fontSize: CommonTextStyle.smallTextStyle + 1
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
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
              style: CommonTextStyle.textStyleForSmallWhiteNormal,
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
              style: CommonTextStyle.textStyleForSmallWhiteNormal,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: App.getDeviceHeightPercent(100, context)/5),
            Dialog(
              shape: const RoundedRectangleBorder(
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
                            color: App.lightGrey,
                            fontSize: CommonTextStyle.smallTextStyle
                          ),
                          backgroundColor: App.lightGrey.withOpacity(0.3),
                        ),
                      ),
                      selectionTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: CommonTextStyle.smallTextStyle
                      ),
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(
                         color: Colors.white,
                         fontSize: CommonTextStyle.smallTextStyle,
                        ),
                        disabledDatesTextStyle: TextStyle(
                            color: App.lightGrey,
                            fontSize: CommonTextStyle.smallTextStyle,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                      yearCellStyle: const DateRangePickerYearCellStyle(
                        disabledDatesTextStyle: TextStyle(
                            color: App.lightGrey,
                            fontSize: CommonTextStyle.smallTextStyle,
                            decoration: TextDecoration.lineThrough
                        ),
                        todayTextStyle: TextStyle(
                          fontSize: CommonTextStyle.smallTextStyle
                        ),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: CommonTextStyle.smallTextStyle
                        ),
                      ),
                      rangeSelectionColor: App.lightGrey.withOpacity(0.3),
                      rangeTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: CommonTextStyle.smallTextStyle
                      ),
                      headerStyle: const DateRangePickerHeaderStyle(
                        textStyle: TextStyle(
                          color: App.orange,
                          fontSize: CommonTextStyle.smallTextStyle,
                        ),
                      ),
                    ),
                    CustomButton(
                      width: App.getDeviceWidthPercent(40, context),
                      height: 40,
                      text: App_Localization.of(context).translate("confirmation").toUpperCase(),
                      onPressed: () {
                        bookController.saveDate.value = true;
                        Get.back();
                      },
                      color: App.orange,
                      borderRadius: 15,
                      textStyle: CommonTextStyle.textStyleForMediumWhiteNormal,
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
                  iconSize: 23,
                  dropdownDecoration: const BoxDecoration(
                    color: App.grey,
                  ),
                  buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hint: Text(App_Localization.of(context).translate("pickup_time"),
                    style: const TextStyle(
                        color: App.lightGrey,
                        fontSize: CommonTextStyle.smallTextStyle + 1,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  iconEnabledColor: App.lightGrey,
                  value: bookController.pickTime.value=="non"? null : bookController.pickTime.value,
                  items: Global.pickUpTime.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: const TextStyle(
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
                iconSize: 23,
                dropdownDecoration: BoxDecoration(
                  color: App.grey,
                ),
                buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                hint: Text(App_Localization.of(context).translate("dropOff_time"),
                  style: const TextStyle(
                      color: App.lightGrey,
                      fontSize: CommonTextStyle.smallTextStyle + 1,
                      fontWeight: FontWeight.normal
                  ),
                ),
                iconEnabledColor: App.lightGrey,
                value: bookController.dropTime.value=="non"? null : bookController.dropTime.value,
                items: Global.pickUpTime.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                      style: const TextStyle(
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
        SizedBox(height: 20,),
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
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: App.getDeviceWidthPercent(90, context),
                child: IntlPhoneField(
                  style: CommonTextStyle.textStyleForMediumWhiteNormal,
                  controller: bookController.phone,
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
                        borderSide:  BorderSide(color: bookController.phoneValidate.value ? Colors.red : App.orange)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: bookController.phoneValidate.value ? Colors.red : App.textField)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: bookController.phoneValidate.value ? Colors.red : App.textField)
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
                    // print(phone.countryCode);
                  },
                )
            ),
          ],
        ),
        SizedBox(height: 20),
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
        ),
        const SizedBox(height: 20),
      ],
    );
  }
  babySeat(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(App_Localization.of(context).translate("baby_seat"),
            style: CommonTextStyle.textStyleForSmallWhiteNormal
          ),
          Text("25 AED - " + App_Localization.of(context).translate("per_day"),
              style: CommonTextStyle.textStyleForSmallOrangeNormal
          ),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              activeColor: App.orange,
              thumbColor: Colors.white,
              value: bookController.babySeatValue.value ,
              onChanged: (bool value) {
                bookController.babySeatValue.value = value;
                bookController.getTotal();
              },
              trackColor: App.grey,
            ),
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
          Text(App_Localization.of(context).translate("additional_driver").toUpperCase(),
              style: CommonTextStyle.textStyleForSmallWhiteNormal
          ),
          Text(App_Localization.of(context).translate("free").toUpperCase(),
              style: CommonTextStyle.textStyleForSmallOrangeNormal
          ),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              activeColor: App.orange,
              thumbColor: Colors.white,
              value: bookController.driverValue.value ,
              onChanged: (bool value) {
                bookController.driverValue.value = value;
              },
              trackColor: App.grey,
            ),
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
                style: CommonTextStyle.textStyleForSmallWhiteNormal,
              ),
              GestureDetector(
                onTap: () {
                  bookController.selectPay.value = 1;
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
                style: CommonTextStyle.textStyleForSmallWhiteNormal,
              ),
              GestureDetector(
                onTap: () {
                  bookController.selectPay.value = 0;
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
                style: CommonTextStyle.textStyleForSmallWhiteNormal,
              ),
              Text(bookController.subTotal.value.toStringAsFixed(2),
                style: CommonTextStyle.textStyleForSmallOrangeNormal,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("vat:"),
                style: CommonTextStyle.textStyleForSmallWhiteNormal,
              ),
              Text(bookController.vat.value.toStringAsFixed(2),
                style: CommonTextStyle.textStyleForSmallOrangeNormal,
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
              Text(bookController.total.value.toStringAsFixed(2),
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
    required String hintText,required TextStyle hintStyle, required bool validate}) {
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
                  borderSide:  BorderSide(color: validate ? Colors.red : App.orange)
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: validate ? Colors.red : App.textField)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: validate ? Colors.red :  App.textField)
              ),
            ),
          ),
        ),
      ],
    );
  }
}