import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/controller/payment_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/all-cars.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class BookController extends GetxController {

  IntroductionController introductionController = Get.find();
  PaymentController paymentController = Get.put(PaymentController());
  RxInt activeCurrentStep = 0.obs;
  Car? car ;
  RxBool loading = false.obs;
  /// date & time section
  RxInt selectRentalModel = 0.obs;
  RxString selectedDate = ''.obs;
  RxString dateCount = ''.obs;
  RxString range = ''.obs;
  RxString rangeCount = ''.obs;
  RxBool saveDate = false.obs;
  RxBool dateValidate = true.obs;
  var pickUpValidate = true.obs;
  Rx<String> pickTime ="non".obs;
  var dropOffValidate = true.obs;
  Rx<String> dropTime ="non".obs;
  /// information
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  RxBool nameValidate = false.obs;
  RxBool emailValidate = false.obs;
  RxBool phoneValidate = false.obs;
  ///baby seat & driver
  RxBool babySeatValue = false.obs;
  RxBool driverValue = false.obs;
  /// pay
  RxInt selectPay = 0.obs; /// 0 pay later | 1 pay now
  RxDouble subTotal = 0.0.obs;
  RxDouble vat = 0.0.obs;
  RxDouble total = 0.0.obs;

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
          dateValidate.value = true;
        } else {
          dateValidate.value = false;
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
        activeCurrentStep ++;
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
          showTopSnackBar(context,
              CustomSnackBar.error(
                message: App_Localization.of(context).translate("phone_number_wrong"),
              ));
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
      getTotal();
    } else{
      getTotal();
      DateTime begin = getDate(range.value.split("-")[0], pickTime.value);
      DateTime end = getDate(range.value.split("-")[1], dropTime.value);
      loading.value = true;
      API.book(selectRentalModel.value == 0 ? "daily" : "hourly",
          selectPay.value == 0 ? "POD" : "cash",
          car!.id.toString(), babySeatValue.value ? "1" : "0",
          driverValue.value ? "1" : "0", begin.toString(), end.toString(),
          name.text, phone.text, email.text).then((value) {
            if(value.rentalNumber!=-1){
              loading.value = false;
              showTopSnackBar(context,
                  CustomSnackBar.success(
                    message: App_Localization.of(context).translate("success_book"),
                    backgroundColor: App.orange,
                  ));
              if(selectPay.value == 1){
                print('later');
                paymentController.makePayment(amount: total.toString(), currency: "aed",newRentNumber:value.rentalNumber).then((value) {
                  clear().then((value) {
                    Get.back();
                    Get.back();
                  });
                });
              }
              print('now');
              clear().then((value) {
                Get.back();
              });
            }else{
              loading.value = false;
              CustomSnackBar.error(
                message: App_Localization.of(context).translate("something_went_wrong"));
              clear().then((value) {
                Get.back();
              });
            }
      });
    }
  }
  getTotal(){
    DateTime begin = getDate(range.value.split("-")[0], pickTime.value);
    DateTime end = getDate(range.value.split("-")[1], dropTime.value);
    int comparDays=end.difference(begin).inDays;
    comparDays=comparDays+1;
    print(comparDays);
    int pickIndex = Global.dropOffTime.indexOf(pickTime.value);
    int dropIndex = Global.dropOffTime.indexOf(dropTime.value);
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
  }
  getDate(String date,String hr){
    int hour = int .parse(hr.split(":")[0]);
    int min = int .parse(hr.split(":")[1].split(" ")[0]);
    String amPm = hr.split(":")[1].split(" ")[1].toLowerCase();
    if(amPm == "pm"){
      hour = hour + 12 ;
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
      selectedDate.value = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount.value = args.value.length.toString();
    } else {
      rangeCount.value = args.value.length.toString();
    }
  }
  Future clear() async{
    selectRentalModel.value = 0;
    selectedDate.value = '';
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
    activeCurrentStep.value = 0;
  }

}

