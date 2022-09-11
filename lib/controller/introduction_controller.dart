import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/model/about.dart';
import 'package:luxury_app/model/all-cars.dart';
import 'package:luxury_app/model/blog.dart';
import 'package:luxury_app/model/brands.dart';
import 'package:luxury_app/model/faq.dart';
import 'package:luxury_app/model/home-data.dart';
import 'package:luxury_app/model/terms.dart';
import 'package:luxury_app/view/cars_by_brand.dart';
import 'package:luxury_app/view/home.dart';
import 'package:luxury_app/view/no_Internet.dart';
import 'package:luxury_app/view/product_details.dart';
import 'package:luxury_app/view/searchDelgate.dart';


class IntroductionController extends GetxController{

  final ScrollController scrollController = ScrollController(initialScrollOffset: 50.0);
  HomeController homeController = Get.put(HomeController());
  HomeData? homeData;
  AllCars? allCars;
  AllCars? allCarsConst;
  RxBool loading = false.obs;
  Rx<int> lengthproductList = 6.obs;
  AllBrands ? allBrands;
  RxBool carsLoading = false.obs;
  RxInt selectBrand = 0.obs;
  AboutUs? aboutUs;
  RentTerms? terms;
  Faq? faq;
  BLOG? blogs;

  @override
  void onInit(){
    super.onInit();
    getData();
  }

  getData() async {
    API.checkInternet().then((internet) async {
       if(internet) {
         API.getHome().then((value) async{
           if(value != null) {
             allCars = await API.getAllCars();
             allCarsConst = await API.getAllCars();
             homeData = value;
             homeData!.data!.brandsWithAll.insert(0,Brand(id: -1, name: "ALL", titleEn: "ALL", titleAr: "جميع", img: "", cover: "", descriptionEn: "", descriptionAr: "", slug: "all", orderNum: -1,
                     metaTitleEn: "", metaTitleAr: "", metaKeywordsEn: "", metaKeywordsAr: "", metaDescriptionEn: "", metaDescriptionAr: "", metaImage: ""));
             Get.offAll(() => Home(homeData!));
           }
         });
         API.getAboutUs().then((value) {
           if(value != null) {
             aboutUs = value;
           }
         });
         API.getTerms().then((value) {
           if(value != null) {
             terms = value;
           }
         });
         API.getFAQ().then((value) {
           if(value != null) {
             faq = value;
           }
         });
         API.getBlogs().then((value) {
           if(value != null) {
             blogs = value;
           }
         });
       }else {
         Get.to(() => NoInternet())!.then((value) {
           getData();
         });
       }
    });
  }
  viewAllProducts() {
    if(lengthproductList.value + 6 > allCars!.data!.cars.length){
      lengthproductList.value =  allCars!.data!.cars.length;
    }else{
      lengthproductList.value = lengthproductList.value+6;
    }
  }
  initProductCount() {
    if(allCars!.data!.cars.length > 6){
      lengthproductList.value = 6;
    }else{
      lengthproductList.value = allCars!.data!.cars.length;
    }
    // print(lengthproductList.value);
    // print("lengthproductList.value");
    // print(allCarsConst!.data!.cars.length);
  }
  getCarsById(BuildContext context,index) async{
    API.checkInternet().then((internet){
      loading.value = true;
      if(internet){
        homeController.selectCategory.value = index;
        homeController.selectAll.value = false;
        API.filter("","0","","",[],homeData!.data!.carBody[homeController.selectCategory.value].id.toString()).then((value) {
          if(value != null) {
            allCars = value;
            initProductCount();
            loading.value = false;
            // print(allCars!.data!.cars.length);
          }
        });
      }else {
        Get.to(()=>NoInternet())!.then((value) {
          getCarsById(context,index);
        });
      }
    });
  }
  pressedOnSearch(BuildContext context) async {
    final result = await showSearch(
        context: context,
        delegate: SearchTextField(introController: this));
  }
  search(BuildContext context,String query,int index){
    if(query.isNotEmpty){
      API.search(query).then((value) {
        if(value != null){
          Get.to(()=>ProductDetails(allCars!.data!.cars[index].id));
        }
      });
    }
  }
  carsByBrand(BuildContext context,int brandID,int index){
    carsLoading.value = true;
    API.getCarsByBrand(brandID).then((value) {
      carsLoading.value = false;
      if(value != null){
        allBrands = value;
        Get.to(() => CarsByBrand(allBrands!,index));
      }else{
        App.errorTopBar(context, "This brand has no cars");
      }
    });
  }
  filterProduct(int vehicleType,int rentType,double minPrice,double maxPrice ,List<int> brands){
    loading.value = true;
    API.filter(vehicleType.toString(), rentType.toString(), minPrice.toString(), maxPrice.toString(), brands, "0").then((value) {
      loading.value = false;
      allCars = value;
      homeController.selectNavDrawer.value = 0;
      Get.back();
    });
  }
  clearFilter(){
    allCars =allCarsConst;
    loading.value = true;
    homeController.selectCategory.value = 0;
    loading.value = false;
    Get.back();
  }
}