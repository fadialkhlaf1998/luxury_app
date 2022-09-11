import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/all-cars.dart';
import 'package:luxury_app/view/home.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';


class BookController extends GetxController {

  IntroductionController introductionController = Get.find();
  RxInt activeCurrentStep = 0.obs;
  Car? car ;
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

      if(name.text.isEmpty || phone.text.isEmpty || email.text.isEmpty) {
        if(name.text.isEmpty){
          nameValidate.value = true;
        }else {
          nameValidate.value = false;
        }
        if(phone.text.isEmpty){
          phoneValidate.value = true;
        }else {
          phoneValidate.value = false;
        }
        if(email.text.isEmpty){
          emailValidate.value = true;
        }else {
          emailValidate.value = false;
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
      // activeCurrentStep ++;
      // clear();
      book(selectRentalModel.value == 0 ? "daily" : "hourly",
          selectPay.value == 0 ? "POD" : "cash",
          car!.id.toString(), babySeatValue.value ? "1" : "0",
          driverValue.value ? "1" : "0", pickTime.value, dropTime.value,
          name.text, phone.text, email.text);
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
  
  Future<bool> book(String rental_type,String payment_method,String car_id,
      String has_babyseat, String has_driver , String from_date, String to_date ,
      String customer_name,String customer_phone,String customer_email)async{
    bool res = await API.book(rental_type, payment_method, car_id, has_babyseat, has_driver, from_date, to_date, customer_name, customer_phone, customer_email);
    if(res){
      print('0000000000000000000');
      print(res);
      return true;
    }else{
      return true;
      return book(rental_type, payment_method, car_id, has_babyseat, has_driver, from_date, to_date, customer_name, customer_phone, customer_email);
    }
  }

  void onSelectionDateChanges(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      saveDate.value = false;
      range.value = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
      // ignore: lines_longer_than_80_chars
          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      selectedDate.value = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount.value = args.value.length.toString();
    } else {
      rangeCount.value = args.value.length.toString();
    }
  }
  clear() {
    selectRentalModel.value = 0;
    selectedDate.value = '';
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
    subTotal = 0.0.obs;
    vat = 0.0.obs;
    total = 0.0.obs;
    activeCurrentStep.value = 0;
    Get.back();

  }

}