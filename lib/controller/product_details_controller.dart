import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProductDetailsController extends GetxController {

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  CarouselController carouselController = CarouselController();
  ItemScrollController itemScrollController = ItemScrollController();
  var activeIndex = 0.obs;
  Rx<bool> loading = false.obs;

  setIndex(int selected){
    activeIndex.value=selected;
    setPage(selected);
  }
  setPage(int p){
    carouselController.animateToPage(p,duration: const Duration(milliseconds: 400));
    itemScrollController.scrollTo(index: p,duration: const Duration(milliseconds: 400));
  }
}