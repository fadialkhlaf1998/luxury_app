import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {

  CarouselController buttonCarouselController = CarouselController();
  RxInt activeIndex = 0.obs;

  setIndex(int index) {
    activeIndex.value = index;
  }


}