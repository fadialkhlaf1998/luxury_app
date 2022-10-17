import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/payment_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/all-cars.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:tuple/tuple.dart';

class BookController extends GetxController {

  PaymentController paymentController = Get.put(PaymentController());
  RxInt activeCurrentStep = 0.obs;
  Car? car;
  RxBool loading = false.obs;
  RxInt selectRentalModel = 0.obs;
  RxString range = ''.obs;
  RxBool saveDate = false.obs;
  RxBool dateValidate = true.obs;
  var pickUpValidate = true.obs;
  Rx<String> pickTime ="non".obs;
  var dropOffValidate = true.obs;
  Rx<String> dropTime ="non".obs;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  RxBool nameValidate = false.obs;
  RxBool emailValidate = false.obs;
  RxBool phoneValidate = false.obs;
  RxBool babySeatValue = false.obs;
  RxBool driverValue = false.obs;
  /// payment
  RxInt selectPay = 0.obs; /// 0 pay later | 1 pay now
  RxDouble subTotal = 0.0.obs;
  RxDouble vat = 0.0.obs;
  RxDouble total = 0.0.obs;
  RxBool openDialog = false.obs;
  RxString rentalNumber = "".obs;

  List<Tuple2> tuples = [
    const Tuple2(Icons.date_range_sharp, StepState.indexed, ),
    const Tuple2(Icons.person_outline_outlined, StepState.editing, ),
    const Tuple2(Icons.monetization_on, StepState.complete, ),
  ];

  backwardStep() {
    if(activeCurrentStep.value == 0){
      clear();
      Get.back();
    }else{
      activeCurrentStep.value -= 1;
    }
  }
  forwardStep(context){
    if(activeCurrentStep.value == 0){
      if(range.value == '' ||  pickTime.value == "non" || dropTime.value == "non"){
        if(range.value == ''){
          dateValidate.value = false;
        } else {
          dateValidate.value = true;
        }
        if(pickTime.value == "non"){
          pickUpValidate.value = false;
        } else {
          pickUpValidate.value = true;
        }
        if(dropTime.value == "non"){
          dropOffValidate.value = false;
        } else {
          dropOffValidate.value = true;
        }
      }else {
        if(getTotal(context)){
          activeCurrentStep ++;
        }
      }
    } else if(activeCurrentStep.value == 1){
      if(name.text.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email.text) || phone.text.isEmpty || email.text.isEmpty || phone.text.length < 9) {
        if(email.text.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email.text)){
          emailValidate.value = true;
        }else {
          emailValidate.value = false;
        }
        if(phone.text.isEmpty || phone.text.length < 9){
          phoneValidate.value=true;
        }else{
          phoneValidate.value=false;
        }
        if(name.text.isEmpty){
          nameValidate.value = true;
        }else {
          nameValidate.value = false;
        }
      }else {
        activeCurrentStep ++;
        nameValidate.value = false;
        emailValidate.value = false;
        phoneValidate.value = false;
      }
      getTotal(context);
    } else{
      getTotal(context);
      DateTime begin = getDate(range.value.split("-")[0], pickTime.value);
      DateTime end = getDate(range.value.split("-")[1], dropTime.value);
      loading.value = true;
      API.book(selectRentalModel.value == 0 ? "daily" : "hourly",
          selectPay.value == 0 ? "POD" : "cash",
          car!.id.toString(), babySeatValue.value ? "1" : "0",
          driverValue.value ? "1" : "0", begin.toString(), end.toString(),
          name.text, phone.text, email.text).then((value) {
            if(value.rentalNumber!=-1){
              rentalNumber.value = value.rentalNumber.toString();
              loading.value = false;
              confirmReservation(context);
              if(selectPay.value == 1){
                print('later');
                paymentController.makePayment(context: context,amount: total.toString(), currency: "aed",newRentNumber:value.rentalNumber).then((value) {
                  clear().then((value) {
                    Get.back();
                    Get.back();
                  });
                });
              }
              print('now');
              clear().then((value) {
                Future.delayed(const Duration(seconds: 5)).then((value) {
                  Get.back();
                  Get.back();
                });
              });
            } else{
              loading.value = false;
              showTopSnackBar(context,
                  CustomSnackBar.error(
                      message: App_Localization.of(context).translate("something_went_wrong")));
              clear().then((value) {
                Get.back();
              });
            }
      });
    }
  }
  bool getTotal(BuildContext context){
    DateTime begin = getDate(range.value.split("-")[0], pickTime.value);
    DateTime end = getDate(range.value.split("-")[1], dropTime.value);
    DateTime fromCompare = getDate(range.value.split("-")[0], "00:00 AM");
    DateTime toCompare = getDate(range.value.split("-")[1], "00:00 AM");
    if(fromCompare.difference(toCompare).inMilliseconds == 0 &&
        (pickTime.value == dropTime.value || Global.hoursList.indexOf(dropTime.value)<= Global.hoursList.indexOf(pickTime.value))){
      // print('---------------------------');
      // print("pick Time" + pickTime.value);
      // print("dropoff Tome" + dropTime.value);
      showTopSnackBar(context,
          CustomSnackBar.error(
              message: App_Localization.of(context).translate("please_select_difference_time")));
      return false;
    }
    int comparDays=end.difference(begin).inDays;
    comparDays=comparDays+1;
    // print(comparDays);
    int pickIndex = Global.hoursList.indexOf(pickTime.value);
    int dropIndex = Global.hoursList.indexOf(dropTime.value);
    if(selectRentalModel.value == 0){
      if(dropIndex - pickIndex > 4 ){
        subTotal.value = (car!.dailyPrice * (comparDays+1)).toDouble();
      }else{
        subTotal.value = (car!.dailyPrice * comparDays).toDouble();
      }
    }else{
      int counter = dropIndex - pickIndex ;
      if(counter.isOdd) {
        subTotal.value = (counter + 1) * car!.hourlyPrice / 2;
      }else{
        subTotal.value = counter * car!.hourlyPrice / 2;
      }
    }
    if(babySeatValue.value){
      subTotal.value +=25;
    }
    vat.value = subTotal * 5 /100;
    total.value = subTotal.value + vat.value;
    return true;
  }
  getDate(String date,String hr){
    int hour = int .parse(hr.split(":")[0]);
    int min = int .parse(hr.split(":")[1].split(" ")[0]);
    String amPm = hr.split(":")[1].split(" ")[1].toLowerCase();
    if(amPm == "pm"){
      hour = hour + 12 ;
    }
    if(hour == 12 && amPm.toLowerCase() == "am"){
      hour = 0;
    }
    return DateTime(int.parse(date.split("/")[2]),
      int.parse(date.split("/")[1]),
      int.parse(date.split("/")[0]),
      hour,
      min
    );
  }
  void onSelectionDateChanges(var args) {
    if (args.value is PickerDateRange ) {
      saveDate.value = false;
      range.value = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      // selectedDate.value = args.value.toString();
    } else if (args.value is List<DateTime>) {
      // dateCount.value = args.value.length.toString();
    } else {
      // rangeCount.value = args.value.length.toString();
    }
  }
  Future clear() async{
    selectRentalModel.value = 0;
    range.value = '';
    saveDate.value = false;
    dateValidate.value = true;
    pickTime = "non".obs;
    dropTime = "non".obs;
    pickUpValidate.value = true;
    dropOffValidate.value = true;
    name.clear();
    email.clear();
    phone.clear();
    nameValidate.value = false;
    emailValidate.value = false;
    phoneValidate.value = false;
    babySeatValue.value = false;
    driverValue.value = false;
    selectPay = 0.obs;
    subTotal = 0.0.obs;
    vat = 0.0.obs;
    total = 0.0.obs;
  }
  confirmReservation(BuildContext context) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                backgroundColor: Colors.transparent,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(App_Localization.of(context).translate("reservation_confirmed"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: App.small,
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      const SizedBox(height: 30,),
                      SvgPicture.asset("assets/icons/check.svg",
                        width: Get.width,
                        height: 150,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 40,),
                      Text(App_Localization.of(context).translate("thank_for_trust"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: App.small,
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("LUXURY ${App_Localization.of(context).translate("car_rental")}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: App.large,
                            color: App.orange,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(App_Localization.of(context).translate("contact_you_shortly"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: App.small,
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      const SizedBox(height: 80),
                      Text("${App_Localization.of(context).translate("rental_number")} ${rentalNumber.value}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: App.small,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.forward) {
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
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

}

