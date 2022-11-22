import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/book_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/all-cars.dart';
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
      backgroundColor: App.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: App.lightDarkGrey,
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.primary,
            ),
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.primary,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    _stepper(context),
                    const SizedBox(height: 20),
                    backNextButton(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            bookController.loading.value ?
            Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.primary,
                child: const Center(
                  child: CupertinoActivityIndicator(
                    color: App.orange,
                  ),
                )
              ) : const Center(),
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
            child: const Icon(Icons.arrow_back,color: Colors.white,size: App.iconSize)
          ),
          Text(App_Localization.of(context).translate("your_info"),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: App.medium
            ),
          ),
          GestureDetector(
            onTap: () {
              bookController.clear();
              Get.back();
            },
            child: SvgPicture.asset("assets/icons/delete.svg",color: Colors.white,)
          )
        ],
      ),
    );
  }
  _stepper(BuildContext context) {
    return EnhanceStepper(
        stepIconSize: 30,
        type: StepperType.vertical,
        horizontalTitlePosition: HorizontalTitlePosition.bottom,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: bookController.activeCurrentStep.value,
        physics: const ClampingScrollPhysics(),
        steps: bookController.tuples.map((e) => EnhanceStep(
          icon: Icon(e.item1, color:
          bookController.activeCurrentStep.value == bookController.tuples.indexOf(e) ?
          App.orange : Colors.white, size: 30),
          state: StepState.values[bookController.tuples.indexOf(e)],
          isActive: bookController.activeCurrentStep.value == bookController.tuples.indexOf(e),
          title: const Text(""),
          content: bookController.activeCurrentStep.value == 0 ?
              _step1(context) : bookController.activeCurrentStep.value == 1 ?
              _step2(context) : _step3(context)
        )).toList(),
        controlsBuilder: (context,controlDetails) {
          return const Center();
        },
    );
  }
  _step1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: !bookController.dateValidate.value && !bookController.saveDate.value ? Colors.red : App.grey,
                )
            ),
            child: Center(
              child: Text(
                bookController.saveDate.value ? bookController.range.value :
                App_Localization.of(context).translate("pickup_and_dropOff_date"),
                style: const TextStyle(
                    color: App.lightWhite,
                    fontSize: App.small
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        pickUpDropOffTime(context),
      ],
    );
  }
  _step2(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        normalTextField(
          height: 45,
          context: context,
          textStyle: const TextStyle(
              fontSize: App.medium,
              color: Colors.white,
              fontWeight: FontWeight.normal
          ),
          textAlignVertical: TextAlignVertical.top,
          width: App.getDeviceWidthPercent(90, context),
          controller: bookController.name,
          validate: bookController.nameValidate.value,
          text: "name",

        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${App_Localization.of(context).translate("phone")}*",
              style: const TextStyle(
                  fontSize: App.small,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
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
                  controller: bookController.phone,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: App.textField,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:  BorderSide(color: bookController.phoneValidate.value ? Colors.red : Colors.transparent)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: bookController.phoneValidate.value ? Colors.red : Colors.transparent)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: bookController.phoneValidate.value ? Colors.red : Colors.transparent)
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
                    if(bookController.phone.text.length > max){
                      bookController.phone.text = bookController.phone.text.substring(0,max);
                    }
                  },
                )
            ),
          ],
        ),
        const SizedBox(height: 20),
        normalTextField(
          height: 45,
          context: context,
          textStyle: const TextStyle(
              fontSize: App.medium,
              color: Colors.white,
              fontWeight: FontWeight.normal
          ),
          width: App.getDeviceWidthPercent(90, context),
          controller: bookController.email,
          validate: bookController.emailValidate.value,
          text: "email",
          textAlignVertical: TextAlignVertical.top
        ),
        const SizedBox(height: 20),
      ],
    );
  }
  _step3(BuildContext context) {
    return Column(
      children: [
        babySeat(context),
        const SizedBox(height: 15),
        additionalDriver(context),
        const SizedBox(height: 15),
        payNowLater(context),
        const SizedBox(height: 30),
        subTotalVat(context),
        const SizedBox(height: 20),
        total(context)
      ],
    );
  }

  /// step 1
  perDayHour(BuildContext context) {
    return SizedBox(
      width: App.getDeviceWidthPercent(55, context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/year.svg",fit: BoxFit.cover,width: 45,height: 45,color: Colors.white,),
              Text(App_Localization.of(context).translate("pick_date").toUpperCase(),
                  style: const TextStyle(
                      fontSize: App.medium,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                  )
              ),
              SvgPicture.asset("assets/icons/year.svg",fit: BoxFit.cover,width: 20,height: 20,color: Colors.transparent,),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      bookController.selectRentalModel.value = 0;
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
                                color: bookController.selectRentalModel.value == 0 ? App.orange : Colors.transparent
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(App_Localization.of(context).translate("daily"),
                      style: const TextStyle(
                          fontSize: App.small,
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      bookController.selectRentalModel.value = 1;
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
                                color: bookController.selectRentalModel.value != 0 ? App.orange : Colors.transparent
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(App_Localization.of(context).translate("hour"),
                      style: const TextStyle(
                          fontSize: App.small,
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                      )
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  dateDialog(BuildContext context) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              backgroundColor: App.grey,
              child: Container(
                width: App.getDeviceWidthPercent(90, context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.close,color: Colors.white,size: App.iconSize,)
                          ),
                        )
                      ],
                    ),
                    SfDateRangePicker(
                      onSelectionChanged: bookController.onSelectionDateChanges,
                      selectionMode: DateRangePickerSelectionMode.range,
                      minDate: DateTime.now(),
                      view: DateRangePickerView.month,
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: const TextStyle(
                            color: App.lightWhite,
                            fontSize: App.small
                          ),
                          backgroundColor: App.field.withOpacity(0.1),
                        ),
                      ),
                      selectionTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: App.small
                      ),
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(
                         color: Colors.white,
                         fontSize: App.small,
                        ),
                        disabledDatesTextStyle: TextStyle(
                            color: App.white,
                            fontSize: App.small,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white
                        ),
                      ),
                      yearCellStyle: const DateRangePickerYearCellStyle(
                        disabledDatesTextStyle: TextStyle(
                            color: App.lightWhite,
                            fontSize: App.small,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white
                        ),
                        todayTextStyle: TextStyle(
                          fontSize: App.small,
                          color: Colors.white,
                        ),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: App.small,
                        ),
                      ),
                      rangeSelectionColor: App.field.withOpacity(0.3),
                      rangeTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: App.small,
                      ),
                      headerStyle: const DateRangePickerHeaderStyle(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: App.medium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Center(
                        child: SizedBox(
                          width: App.getDeviceWidthPercent(60, context),
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: App.orange,
                              onPrimary: App.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: FittedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(App_Localization.of(context).translate("confirmation").toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: App.medium,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                      )
                                  ),
                                  const SizedBox(width: 8),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Icon(Icons.arrow_forward,color: Colors.white,size: App.iconSize,),
                                  )
                                ],
                              )
                            ),
                            onPressed: () {
                              bookController.saveDate.value = true;
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,)
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
    return SizedBox(
      width: App.getDeviceWidthPercent(90, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: App.getDeviceWidthPercent(38, context),
            height: 40,
            decoration: BoxDecoration(
                color: App.grey,
                border: Border.all(
                  color: !bookController.pickUpValidate.value && bookController.pickTime.value=="non"? Colors.red : App.grey,
                ),
                borderRadius: BorderRadius.circular(8)
            ),
            child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownDecoration: const BoxDecoration(
                    color: App.grey
                  ),
                  iconEnabledColor: Colors.transparent,
                  dropdownMaxHeight: 200,
                  isExpanded: true,
                  hint: Center(
                    child: Text(App_Localization.of(context).translate("pickup_time"),
                      style: const TextStyle(
                          color: App.lightWhite,
                          fontSize: App.small,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                  value: bookController.pickTime.value=="non"? null : bookController.pickTime.value,
                  items: Global.hoursList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                        child: Text(value,
                          style: const TextStyle(
                              color: App.lightWhite,
                              fontSize: App.small,
                              fontWeight: FontWeight.bold
                          ),
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
            width: App.getDeviceWidthPercent(38, context),
            height: 40,
            decoration: BoxDecoration(
                color: App.grey,
                border: Border.all(
                  color: !bookController.dropOffValidate.value && bookController.dropTime.value=="non"? Colors.red : App.grey,
                ),
                borderRadius: BorderRadius.circular(8)
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                dropdownDecoration: const BoxDecoration(
                    color: App.grey
                ),
                iconEnabledColor: Colors.transparent,
                dropdownMaxHeight: 200,
                isExpanded: true,
                buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                hint: Center(
                  child: Text(App_Localization.of(context).translate("dropOff_time"),
                    style: const TextStyle(
                        color: App.lightWhite,
                        fontSize: App.small,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                value: bookController.dropTime.value=="non"? null : bookController.dropTime.value,
                items: Global.hoursList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      child: Text(value,
                        style: const TextStyle(
                            color: App.lightWhite,
                            fontSize: App.small,
                            fontWeight: FontWeight.bold
                        ),
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

  /// step 3
  babySeat(BuildContext context) {
    return SizedBox(
      width: App.getDeviceWidthPercent(90, context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(App_Localization.of(context).translate("baby_seat").toUpperCase(),
                  style: const TextStyle(
                      fontSize: App.small,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                  )
              ),
              const SizedBox(height: 5,),
              Text("25 AED - ${App_Localization.of(context).translate("per_day")}",
                  style: const TextStyle(
                      fontSize: App.small,
                      color: App.orange,
                      fontWeight: FontWeight.normal
                  )
              ),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              activeColor: App.orange,
              thumbColor: Colors.white,
              value: bookController.babySeatValue.value ,
              onChanged: (bool value) {
                bookController.babySeatValue.value = value;
                bookController.getTotal(context);
              },
              trackColor: App.grey,
            ),
          ),
        ],
      ),
    );
  }
  additionalDriver(BuildContext context) {
    return SizedBox(
      width: App.getDeviceWidthPercent(90, context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(App_Localization.of(context).translate("additional_driver").toUpperCase(),
                  style: const TextStyle(
                      fontSize: App.small,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                  )
              ),
              const SizedBox(height: 5,),
              Text(App_Localization.of(context).translate("free"),
                  style: const TextStyle(
                      fontSize: App.small,
                      color: App.orange,
                      fontWeight: FontWeight.normal
                  )
              ),
            ],
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
    return SizedBox(
      width: App.getDeviceWidthPercent(90, context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("pay_later").toUpperCase(),
                style: const TextStyle(
                    fontSize: App.small,
                    color: Colors.white,
                    fontWeight: FontWeight.normal
                )
              ),
              GestureDetector(
                onTap: () {
                  bookController.selectPay.value = 1;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      width: 22,
                      height: 22,
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
                              color: bookController.selectPay.value == 1 ? App.orange : Colors.transparent
                          ),
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("pay_now").toUpperCase(),
                style: const TextStyle(
                    fontSize: App.small,
                    color: Colors.white,
                    fontWeight: FontWeight.normal
                )
              ),
              GestureDetector(
                onTap: () {
                  bookController.selectPay.value = 0;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      width: 22,
                      height: 22,
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
                              color: bookController.selectPay.value == 0 ? App.orange : Colors.transparent
                          ),
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  subTotalVat(BuildContext context) {
    return SizedBox(
      width: App.getDeviceWidthPercent(90, context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${App_Localization.of(context).translate("sub_total:")}  ",
                style: const TextStyle(
                    fontSize: App.xSmall,
                    color: Colors.white,
                    fontWeight: FontWeight.normal
                )
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints constraints) {
                    final boxWidth = constraints.constrainWidth();
                    const dashWidth = 4.0;
                    const dashHeight = 1.5;
                    final dashCount =
                    (boxWidth / (2 * dashWidth)).floor();
                    return Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: List.generate(dashCount, (_) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: dashWidth,
                            height: dashHeight,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Text("  AED ${bookController.subTotal.value.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: App.small,
                      color: App.orange,
                      fontWeight: FontWeight.normal
                  )
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${App_Localization.of(context).translate("vat:")}  ",
                  style: const TextStyle(
                      fontSize: App.xSmall,
                      color: Colors.white,
                      fontWeight: FontWeight.normal

                  )
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints constraints) {
                    final boxWidth = constraints.constrainWidth();
                    const dashWidth = 4.0;
                    const dashHeight = 1.5;
                    final dashCount =
                    (boxWidth / (2 * dashWidth)).floor();
                    return Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: List.generate(dashCount, (_) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: dashWidth,
                            height: dashHeight,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Text("  AED ${bookController.vat.value.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: App.small,
                      color: App.orange,
                      fontWeight: FontWeight.normal
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
  total(BuildContext context){
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      height: 50,
      decoration: BoxDecoration(
        color: App.textField,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(App_Localization.of(context).translate("total:").toUpperCase(),
                style: const TextStyle(
                    fontSize: App.small,
                    color: App.lightWhite,
                    fontWeight: FontWeight.bold
                )
            ),
            Text("AED ${bookController.total.value.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: App.medium,
                    color: App.orange,
                    fontWeight: FontWeight.bold
                )
            ),
          ],
        ),
      ),
    );
  }
  backNextButton(BuildContext context) {
    return SizedBox(
      width: App.getDeviceWidthPercent(100, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
              child: Container(
                width: App.getDeviceWidthPercent(35, context),
                height: 40,
                color: App.grey,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                            color: App.orange
                        )
                    ),
                  ),
                  child: FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(App_Localization.of(context).translate("back").toUpperCase(),
                              style: const TextStyle(
                                  fontSize: App.medium,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                        ],
                      )
                  ),
                  onPressed: () {
                    bookController.backwardStep();
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
              child: SizedBox(
                width: App.getDeviceWidthPercent(35, context),
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: App.orange,
                    onPrimary: App.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(App_Localization.of(context).translate("next").toUpperCase(),
                              style: const TextStyle(
                                  fontSize: App.medium,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                        ],
                      )
                  ),
                  onPressed: () {
                    bookController.forwardStep(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static normalTextField({required String text,required BuildContext context, required TextStyle textStyle,required double width,
    double? height, TextAlignVertical? textAlignVertical,required TextEditingController controller, required bool validate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${App_Localization.of(context).translate(text)}*",
          style: const TextStyle(
              fontSize: App.small,
              color: Colors.white,
              fontWeight: FontWeight.w600
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
          ),
        ),
      ],
    );
  }
}