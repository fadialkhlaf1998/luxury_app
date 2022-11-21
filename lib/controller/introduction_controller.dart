import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/helper/api.dart';
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
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class IntroductionController extends GetxController{

  final scrollController = ScrollController();
  HomeController homeController = Get.put(HomeController());
  HomeData? homeData;
  AllCars? allCars;
  AllCars? allCarsConst;
  RxBool loading = false.obs;
  Rx<int> lazyProductsList = 0.obs;
  AllCarsBrands? allCarsBrands;
  RxBool carsLoading = false.obs;
  RxInt selectBrand = 0.obs;
  AboutUs? aboutUs;
  RentTerms? terms;
  Faq? faq;
  Blogs? blogs;

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
             initLazyProductsList();
             homeData = value;
              if(homeData !=null){
                if(homeData!.data!=null){
                  if(homeData!.data!.carBody.isNotEmpty){
                    getCarsById(0);
                  }
                }
              }
             homeData!.data!.brandsWithAll.insert(0,Brand(id: -1, name: "ALL", titleEn: "ALL", titleAr: "جميع", img: "", cover: "", descriptionEn: "", descriptionAr: "", slug: "all", canonical: "",orderNum: -1,
                     metaTitleEn: "", metaTitleAr: "", metaKeywordsEn: "", metaKeywordsAr: "", metaDescriptionEn: "", metaDescriptionAr: "", metaImage: ""));
             Get.offAll(() => Home(homeData!));
             homeData!.data!.brandsWithAll.first.selected.value = true;
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
    if(lazyProductsList.value + 6 >= allCars!.data!.cars.length){
      lazyProductsList.value =  allCars!.data!.cars.length;
    }else{
      lazyProductsList.value = lazyProductsList.value + 6;
    }
  }
  initLazyProductsList() {
    if(allCars!.data!.cars.length > 6){
      lazyProductsList.value = 6;
    }else{
      lazyProductsList.value = allCars!.data!.cars.length;
    }
  }
  getCarsById(index) async{
    API.checkInternet().then((internet){
      loading.value = true;
      if(internet){
        homeController.selectCategory.value = index;
        // homeController.selectAll.value = false;
        API.filter("","1","","",[],homeData!.data!.carBody[homeController.selectCategory.value].id.toString()).then((value) {
          if(value != null) {
            allCars = value;
            initLazyProductsList();
            loading.value = false;

          }
        });
      }else {
        Get.to(()=>NoInternet())!.then((value) {
          getCarsById(index);
        });
      }
    });
  }
  search(BuildContext context,String query,int index){
    // print('Begin');
    API.search(query).then((value) {
      // print('END');
      if(value != null) {
        // Get.to(()=>ProductDetails(value.data!.cars[0].id));
      }
    });
  }
  carsByBrand(BuildContext context,int brandID,int index){
    carsLoading.value = true;
    API.getCarsByBrand(brandID).then((value) {
      carsLoading.value = false;
      if(value != null){
        allCarsBrands = value;
        Get.to(() => CarsByBrand(allCarsBrands!,index));
      }else{
        showTopSnackBar(context,
            CustomSnackBar.error(
              message: App_Localization.of(context).translate("no_cars_in_brand"),)
        );
      }
    });
  }
  filterProduct(int vehicleType,int rentType,double minPrice,double maxPrice ,List<int> brands){
    loading.value = true;
    API.filter(vehicleType.toString(), rentType.toString(), minPrice.toString(), maxPrice.toString(), brands, "0").then((value) {
      loading.value = false;
      allCars = value;
      initLazyProductsList();
      homeController.selectNavDrawer.value = -1;
      homeController.selectNavBar.value = 0;
      Get.back();
      homeData!.data!.brandsWithAll.first.selected.value = true;
      for(int i=1 ; i< homeData!.data!.brandsWithAll.length;i++){
        homeData!.data!.brandsWithAll[i].selected.value = false;
      }
    });
  }
  clearFilter(){
    allCars =allCarsConst;
    loading.value = true;
    homeController.selectCategory.value = 0;
    loading.value = false;
    // Get.back();
  }
}