import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';


class BookController extends GetxController {


  /// date & time section
  RxInt selectRentalModel = 0.obs;
  RxString selectedDate = ''.obs;
  RxString dateCount = ''.obs;
  RxString range = ''.obs;
  RxString rangeCount = ''.obs;
  RxBool saveDate = false.obs;
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
    pickTime = "non".obs;
    dropTime = "non".obs;
    pickUpValidate.value = true;
    dropOffValidate.value = true;
    name.clear();
    email.clear();
    phone.clear();
    nameValidate = false.obs;
    emailValidate = false.obs;
    phoneValidate = false.obs;
    subTotal = 0.0.obs;
    vat = 0.0.obs;
    total = 0.0.obs;
  }

}