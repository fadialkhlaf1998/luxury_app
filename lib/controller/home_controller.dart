import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/introduction_controller.dart';

class HomeController extends GetxController {

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  var selectNavBar = 0.obs;
  var searchIcon = true.obs;
  var selectAll = true.obs;
  TextEditingController search = TextEditingController();
  var selectSuperCategory = 0.obs;
  var selectCategory = 0.obs;
  ScrollController scrollController = ScrollController();
  bool showAppbar = true;
  var selectNavDrawer = (-1).obs;

  ///filter
  // RxInt selectRentalModel = 0.obs; /// 0 daily 1 hourly
  RxInt selectRentalModel = 0.obs; /// 1 daily 0 hourly
  Rx<RangeLabels> priceLabel = const RangeLabels("0", "2200").obs;
  Rx<double> minPrice= 0.0.obs, maxPrice= 2200.0.obs;
  List<int> selectedBrands = <int>[];
  Rx<RangeValues> price = const RangeValues(0,2200).obs;

  // clearFilter(){
  //   selectRentalModel = 0.obs;
  //   selectedBrands.clear();
  //   minPrice.value = 0.0;
  //   maxPrice.value = 5500.00;
  //   price.value = const RangeValues(0, 5500);
  //   priceLabel.value = const RangeLabels("AED 0", "AED 0");
  // }

  initializePrice(IntroductionController introductionController){
    selectRentalModel = 1.obs;
    selectedBrands.clear();
    priceLabel.value = RangeLabels("0", "${introductionController.homeData!.data!.maxPriceDaily}",
    );
    maxPrice.value = double.parse(introductionController.homeData!.data!.maxPriceDaily.toString());
    price.value = RangeValues(0,double.parse(introductionController.homeData!.data!.maxPriceDaily.toString()));
  }
}