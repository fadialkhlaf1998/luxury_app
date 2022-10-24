import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/contact_us_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/controller/payment_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/home-data.dart';
import 'package:luxury_app/view/blogs.dart';
import 'package:luxury_app/view/FAQ.dart';
import 'package:luxury_app/view/about_us.dart';
import 'package:luxury_app/view/contact_us.dart';
import 'package:luxury_app/view/rent_terms.dart';
import 'package:luxury_app/view/searchDelgate.dart';
import 'package:luxury_app/view/settings.dart';
import 'package:luxury_app/view/book.dart';
import 'package:luxury_app/view/brandPage.dart';
import 'package:luxury_app/view/filter.dart';
import 'package:luxury_app/view/product_details.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/drawer.dart';
import 'package:luxury_app/widgets/image_and_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {

  HomeController homeController = Get.put(HomeController());
  ContactUsController contactUsController = Get.put(ContactUsController());

  HomeData homeData;

  Home(this.homeData);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.put(HomeController());
  IntroductionController introductionController = Get.find();
  ContactUsController contactUsController = Get.put(ContactUsController());

  @override
  void initState() {
    super.initState();
    homeController.scrollController = ScrollController();
    homeController.scrollController.addListener(() {
      if(homeController.scrollController.position.pixels == 0){
        setState(() {
           homeController.showAppbar = true;
        });
      }else{
        setState(() {
          homeController.showAppbar = false;
        });
      }
    });
  }

  @override
  void dispose() {
    homeController.scrollController.dispose();
    homeController.scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: App.grey,
        bottomNavigationBar: btnNavBar(context),
        key: homeController.key,
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.primary,
              ),
              homeController.selectNavDrawer.value == -1 ?
                homeController.selectNavBar.value == 0 ? home(context) :
                homeController.selectNavBar.value == 1 ? BrandPage() :
                Settings() :
                  homeController.selectNavDrawer.value == 0 ? AboutUs() :
                  homeController.selectNavDrawer.value == 1 ? FAQ() :
                  homeController.selectNavDrawer.value == 2 ? Blog() :
                  homeController.selectNavDrawer.value == 3 ?
                  RentTermsPage() : ContactUs(),
              Positioned(
                  top: 0,
                  child: header(context)
              ),
              introductionController.carsLoading.value ?
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.primary,
                child: const Center(
                  child: CupertinoActivityIndicator(color: App.orange,),
                ),
              ) : const Center(),
            ],
          ),
        )
    ));
  }

  header(BuildContext context){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      height: widget.homeData.data!.carType[homeController.selectSuperCategory.value].id != 3 && homeController.selectNavBar.value == 0 && homeController.selectNavDrawer.value == -1 ?
      Get.height * 0.23 :
      homeController.selectNavBar.value == 0 && homeController.selectNavDrawer.value == -1 ?
      homeController.showAppbar ?
      Get.height * 0.35 : Get.height * 0.3 : Get.height * 0.1,
      decoration: BoxDecoration(
        color: App.lightDarkGrey,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: Get.height * 0.1,
              decoration: const BoxDecoration(
                  color: App.lightDarkGrey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          homeController.key.currentState!.openDrawer();
                        },
                        child: SvgPicture.asset("assets/icons/menu.svg",color: App.orange)
                    ),
                    GestureDetector(
                      onTap: () {
                        homeController.selectNavBar.value = 0;
                        homeController.key.currentState!.openEndDrawer();
                      },
                      child: SvgPicture.asset("assets/icons/logo.svg",
                      width: Get.width * 0.4),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => Filter());
                        },
                        child: SvgPicture.asset("assets/icons/filter.svg",color: App.orange,)
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: SearchTextField());
                  },
                  child: Container(
                    width: App.getDeviceWidthPercent(90, context),
                    height: Get.height * 0.04,
                    decoration: BoxDecoration(
                      color: App.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.search,color: App.orange,size: App.iconSize),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(App_Localization.of(context).translate("choose_your_dream_car"),
                              style: const TextStyle(
                                  color: App.lightWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: App.medium
                              ),
                            ),
                          ),
                          const Icon(Icons.search,color: Colors.transparent,size: App.iconSize),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  height: homeController.showAppbar ? Get.height * 0.05 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  child: superCategory(context,widget.homeData, homeController.selectSuperCategory.value),
                ),
                SizedBox(
                  height: widget.homeData.data!.carType[homeController.selectSuperCategory.value].id != 3 ?
                  0 : Get.height * 0.16,
                  child: Column(
                    children: [
                      // SizedBox(height: homeController.showAppbar ? 10 : 0),
                      // widget.homeData.data!.carType[homeController.selectSuperCategory.value].id != 3?
                      // const Center() : SizedBox(
                      //   width: App.getDeviceWidthPercent(90, context),
                      //   child: Text(App_Localization.of(context).translate("car_classes"),
                      //     style: const TextStyle(
                      //       color: App.lightWhite,
                      //       fontSize: App.big,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      widget.homeData.data!.carType[homeController.selectSuperCategory.value].id != 3?
                      const Center() : category(context),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  btnNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: App.primary,
        border: Border.all(color: Colors.transparent)
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        ),
        child: BottomNavigationBar(
          iconSize: App.iconSize,
          backgroundColor: App.lightGrey,
          selectedLabelStyle: TextStyle(
            color: homeController.selectNavDrawer.value != -1 ?
            App.lightWhite :  App.orange,
            fontSize: App.small,
            fontWeight: FontWeight.w600
          ),
          unselectedLabelStyle: const TextStyle(
              color: App.lightWhite,
              fontSize: App.small,
              fontWeight: FontWeight.w600
          ),
          selectedItemColor: homeController.selectNavDrawer.value != -1 ?
          App.lightWhite : App.orange,
          unselectedItemColor: App.lightWhite,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: homeController.selectNavBar.value == 0
                  && homeController.selectNavDrawer.value == -1 ?
              Padding(
                padding: const EdgeInsets.all(3),
                child: SvgPicture.asset("assets/icons/home-Filled.svg",color: App.orange),
              ) :
              Padding(
                padding: const EdgeInsets.all(3),
                child: SvgPicture.asset("assets/icons/home-Bold.svg",color: App.lightWhite),
              ),
              label: App_Localization.of(context).translate("home").toUpperCase()
            ),
            BottomNavigationBarItem(
                icon: homeController.selectNavBar.value == 1
                    && homeController.selectNavDrawer.value == -1 ?
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: SvgPicture.asset("assets/icons/brand-filled.svg",color: App.orange),
                ) :
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: SvgPicture.asset("assets/icons/brand-bold.svg",color: App.lightWhite),
                ),
                label: App_Localization.of(context).translate("brand").toUpperCase()
            ),
            BottomNavigationBarItem(
                icon: homeController.selectNavBar.value == 2
                    && homeController.selectNavDrawer.value == -1 ?
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: SvgPicture.asset("assets/icons/settings-filled.svg",color: App.orange),
                ) :
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: SvgPicture.asset("assets/icons/settings-Bold.svg",color: App.lightWhite),
                ),
                label: App_Localization.of(context).translate("settings").toUpperCase()
            ),
          ],
          currentIndex: homeController.selectNavBar.value,
          onTap: (index) async {
            // if(index == 2){
            //   print('Payment');
            //   PaymentController paymentController = Get.put(PaymentController());
            //   paymentController.makePayment(context: context, amount: "2.00", currency: "aed", newRentNumber: 123546);
            // }
            homeController.selectNavBar.value = index;
            if(homeController.selectNavBar.value == 0){
              if (homeController.scrollController.hasClients) {
                await homeController.scrollController.animateTo(
                  0.0,
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 1500),
                );
              }
            }
            homeController.selectNavDrawer.value = -1;
            contactUsController.clearTextField();
            if(homeController.selectNavDrawer.value != -1) {
              contactUsController.clearTextField();
            }
          },
        ),
      ),
    );
  }
  home(BuildContext context) {
    return Stack(
      children: [
        LazyLoadScrollView(
          onEndOfPage: (){
            // print('------');
            introductionController.viewAllProducts();
          },
          isLoading: false,
          child: SingleChildScrollView(
            controller: homeController.scrollController,
            child: widget.homeData.data!.carType[homeController.selectSuperCategory.value].id != 3 ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: Get.height * 0.25
                    ),
                    noResult(context),
                    const SizedBox(height: 20,),
                  ],
                ) :
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:
                homeController.showAppbar?
                Get.height * 0.35 + 5 :
                Get.height * 0.3 + 5
                ),
                introductionController.loading.value ?
                Container(
                  width: App.getDeviceWidthPercent(100, context),
                  height: App.getDeviceHeightPercent(50, context),
                  color: App.primary,
                  child: const Center(
                    child: CupertinoActivityIndicator(color: App.orange,),
                  ),
                ) :
                widget.homeData.data!.carType[homeController.selectSuperCategory.value].id != 3 || introductionController.loading.value == true ?
                const Center() : products(context),
                introductionController.loading.value == true ?
                const Center() : const Center(),
              ],
            ),
          ),
        )
      ],
    );
  }
  superCategory(BuildContext context,HomeData homeData,int index) {
    return SizedBox(
        width: Get.width * 0.9,
        height: Get.height * 0.1,
        child: ListView.builder(
            itemCount: homeData.data!.carType.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(() => GestureDetector(
                onTap: () {
                  homeController.selectSuperCategory.value = index;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          decoration: BoxDecoration(
                              color: homeController.selectSuperCategory.value == index ?
                              App.orange : App.grey,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: SvgPicture.network("${API.url}/${homeData.data!.carType[index].img}",
                                      fit: BoxFit.cover,
                                      color: homeController.selectSuperCategory.value == index ? Colors.black : App.orange,
                                  )
                              ),
                              const SizedBox(width: 5),
                              Text(Global.languageCode == "en" ?
                              homeData.data!.carType[index].nameEn :
                              homeData.data!.carType[index].nameAr,
                                style: TextStyle(
                                    fontSize: App.xSmall,
                                    color: homeController.selectSuperCategory.value == index ?
                                    Colors.black : App.white,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                      ),
                    ],
                  ),
                ),
              ));
            })
    );
  }
  category(BuildContext context) {
    return SizedBox(
        width: App.getDeviceWidthPercent(90, context),
        height: Get.height * 0.13,
        child: ListView.builder(
            itemCount: widget.homeData.data!.carBody.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(() => GestureDetector(
                onTap: () {
                  introductionController.getCarsById(context, index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: App.grey,
                            border: Border.all(
                                color: homeController.selectCategory.value == index ?
                                App.orange : Colors.transparent,
                            ),
                           borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              width: 50,
                              child: SvgPicture.network("${API.url}/${widget.homeData.data!.carBody[index].img}",
                                fit: BoxFit.contain,
                                color: App.orange,
                              ),
                            )
                          )
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          child: Center(
                            child: Text(Global.languageCode == "en" ?
                            widget.homeData.data!.carBody[index].nameEn :
                            widget.homeData.data!.carBody[index].nameAr,
                              style: TextStyle(
                                color: homeController.selectCategory.value == index ?
                                App.orange : App.lightWhite,
                                fontSize: App.xSmall
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            })
    );
    // ListView.builder(
    //   itemCount: 1,
    //   shrinkWrap: true,
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (BuildContext context,int index) {
    //     return Obx(() => GestureDetector(
    //       onTap: () {
    //         homeController.selectCategory.value = index;
    //         homeController.selectAll.value = true;
    //         introductionController.loading.value = true;
    //         introductionController.allCars = introductionController.allCarsConst;
    //         Future.delayed(const Duration(seconds: 1)).then((value) {
    //           introductionController.loading.value = false;
    //         });
    //         introductionController.initProductCount();
    //         },
    //       child: Row(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 10,right: 10),
    //             child: Container(
    //               width: 130,
    //               decoration: BoxDecoration(
    //                   color: homeController.selectCategory.value == 0 && homeController.selectAll.value == true ?
    //                   App.orange : App.grey,
    //                   borderRadius: BorderRadius.circular(10)
    //               ),
    //               child: Center(
    //                 child: Text(App_Localization.of(context).translate("all").toUpperCase(),
    //                     style: CommonTextStyle.textStyleForSmallWhiteBold
    //                 ),
    //               )
    //             ),
    //           ),
    //           Container(
    //               child: ListView.builder(
    //                   itemCount: homeData.data!.carBody.length,
    //                   shrinkWrap: true,
    //                   physics: const NeverScrollableScrollPhysics(),
    //                   scrollDirection: Axis.horizontal,
    //                   itemBuilder: (context, index) {
    //                     return Obx(() => GestureDetector(
    //                       onTap: () {
    //                         introductionController.getCarsById(context, index);
    //                       },
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(horizontal: 10),
    //                         child: Row(
    //                           children: [
    //                             Container(
    //                               width: 130,
    //                               decoration: BoxDecoration(
    //                                   color: homeController.selectCategory.value == index && homeController.selectAll.value  == false?
    //                                   App.orange : App.grey,
    //                                   borderRadius: BorderRadius.circular(10)
    //                               ),
    //                               child: Center(
    //                                 child: Text(Global.languageCode == "en" ?
    //                                 homeData.data!.carBody[index].nameEn :
    //                                 homeData.data!.carBody[index].nameAr,
    //                                     style: CommonTextStyle.textStyleForSmallWhiteBold
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ));
    //                   })
    //           ),
    //         ],
    //       ),
    //     ));
    //   },
    // );
  }
  products(BuildContext context) {
    return introductionController.allCars!.data!.cars.isEmpty ?
    Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           SizedBox(height: Get.height * 0.15),
           SizedBox(
             width: App.getDeviceWidthPercent(40, context),
             height: Get.height * 0.05,
             child: Center(
               child: Text(App_Localization.of(context).translate("no_results_found!"),
                   style: const TextStyle(
                     color: App.lightWhite,
                     fontSize: App.small,
                     fontWeight: FontWeight.w600
                   )
               ),
             ),
           ),
         ],
       ) :
    SizedBox(
        width: App.getDeviceWidthPercent(90, context),
        child: GridView.builder(
          controller: introductionController.scrollController,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: introductionController.lazyProductsList.value,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 6/5,
                crossAxisSpacing: 10,
                crossAxisCount: 1
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
                  return GestureDetector(
                onTap: () {
                  Get.to(()=>ProductDetails(introductionController.allCars!.data!.cars[index].id));
                  homeController.selectNavBar.value = 0;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: App.getDeviceWidthPercent(100, context),
                    decoration: BoxDecoration(
                        color: App.lightDarkGrey,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Stack(
                              children: [
                                productImages(context,index),
                                Positioned(
                                  left: 15,
                                  top: 15,
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: introductionController.allCars!.data!.cars[index].brands!.img == "" ? const Center() :
                                    Image.network("${API.url}/${introductionController.allCars!.data!.cars[index].brands!.img}",
                                        fit: BoxFit.fill),
                                  ),
                                )
                              ],
                            )
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            child: Center(
                              child: Text(introductionController.allCars!.data!.cars[index].slug.replaceAll("-", " "),
                                  style: const TextStyle(
                                      fontSize: App.big,
                                      color: App.orange,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              introductionController.allCars!.data!.cars[index].hourlyPrice == -1 ?
                              const Center() :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(" AED ${introductionController.allCars!.data!.cars[index].hourlyPrice} /",
                                          style: const TextStyle(
                                              fontSize: App.small,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                      Text(App_Localization.of(context).translate("hour"),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: App.xSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: introductionController.allCars!.data!.cars[index].oldHourlyPrice == 0 ? 0 : 5),
                                  introductionController.allCars!.data!.cars[index].oldHourlyPrice == 0 ?
                                  const Center() :
                                  Row(
                                    children: [
                                      Text(" AED ${introductionController.allCars!.data!.cars[index].oldHourlyPrice}",
                                        style: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.red,
                                          color: App.lightWhite,
                                          fontSize: App.xSmall,
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Text("${(100 - (introductionController.allCars!.data!.cars[index].hourlyPrice * 100)/introductionController.allCars!.data!.cars[index].oldHourlyPrice).round()}% OFF",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: App.xSmall,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              introductionController.allCars!.data!.cars[index].hourlyPrice == -1 ||  introductionController.allCars!.data!.cars[index].dailyPrice == -1 ?
                              const Center() :
                              VerticalDivider(
                                color: Colors.white,
                                thickness: 1,
                                endIndent: introductionController.allCars!.data!.cars[index].oldHourlyPrice != 0 ? 8 : 12,
                                indent: introductionController.allCars!.data!.cars[index].oldHourlyPrice != 0 ? 8 : 12,
                              ),
                              introductionController.allCars!.data!.cars[index].dailyPrice == -1 ?
                              const Center() :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(" AED ${introductionController.allCars!.data!.cars[index].dailyPrice} /",
                                          style: const TextStyle(
                                              fontSize: App.small,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                      Text(App_Localization.of(context).translate("day"),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: App.xSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: introductionController.allCars!.data!.cars[index].oldDailyPrice == 0 ? 0 : 5),
                                  introductionController.allCars!.data!.cars[index].oldDailyPrice == 0 ?
                                  const Center() :
                                  Row(
                                    children: [
                                      Text(" AED ${introductionController.allCars!.data!.cars[index].oldDailyPrice}",
                                        style: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.red,
                                          color: App.lightWhite,
                                          fontSize: App.xSmall,
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Text("${(100 - (introductionController.allCars!.data!.cars[index].dailyPrice * 100)/introductionController.allCars!.data!.cars[index].oldDailyPrice).round()}% OFF",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: App.xSmall,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  App.lunchURL(context,"https://api.whatsapp.com/send?phone=");
                                },
                                child: Container(
                                  width: App.getDeviceWidthPercent(92, context) / 4,
                                    decoration: BoxDecoration(
                                        color: App.grey,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(Global.languageCode == "en" ? 15 : 0),
                                            bottomRight: Radius.circular(Global.languageCode == "en" ? 0 : 15)
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      child: ImageAndText(
                                          child1: const Icon(Icons.whatsapp,color: Colors.green,size: 14,),
                                          text: "whatsapp",
                                          textStyle: const TextStyle(
                                              fontSize: App.tiny,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    )
                                ),
                              ),
                              GestureDetector(
                                onTap: () async{
                                  if(await canLaunchUrl(Uri.parse('tel: +971 4 392 7704'))){
                                    await launchUrl (Uri.parse('tel: +971 4 392 7704'));
                                  }
                                },
                                child: Container(
                                    width: App.getDeviceWidthPercent(92, context) / 5,
                                    decoration: const BoxDecoration(
                                      color: App.grey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      child: ImageAndText(
                                          child1: const Icon(Icons.call,color: Colors.red,size: 14,),
                                          text: "call",
                                          textStyle: const TextStyle(
                                              fontSize: App.tiny,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    )
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(()=>ProductDetails(introductionController.allCars!.data!.cars[index].id));
                                  homeController.selectNavBar.value = 0;
                                },
                                child: Container(
                                    width: App.getDeviceWidthPercent(92, context) / 5,
                                    decoration: const BoxDecoration(
                                      color: App.grey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      child: ImageAndText(
                                          child1: const Icon(Icons.info_outline,color: Colors.orange,size: 14,),
                                          text: "detail",
                                          textStyle: const TextStyle(
                                              fontSize: App.tiny,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    )
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(()=> Book(introductionController.allCars!.data!.cars[index]));
                                },
                                child: Container(
                                    width: App.getDeviceWidthPercent(92, context) / 4,
                                    decoration: BoxDecoration(
                                        color: App.grey,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(Global.languageCode == "en" ? 15 : 0),
                                            bottomLeft: Radius.circular(Global.languageCode == "en" ? 0 : 15)
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      child: ImageAndText(
                                          child1: ContainerWithImage(
                                            width: 16,
                                            height: 16,
                                            image: "assets/icons/book.svg",
                                            option: 0,
                                            color: App.orange,
                                          ),
                                          text: "book",
                                          textStyle: const TextStyle(
                                              fontSize: App.tiny,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
      );
  }
  productImages(BuildContext context,int index) {
    return Container(
      width: Get.width,
      height: Get.height * 0.24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: ImageSlideshow(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.24,
        initialPage: 0,
        indicatorColor: App.orange,
        indicatorBackgroundColor: App.lightWhite,
        autoPlayInterval: 0,
        isLoop: true,
        children: introductionController.allCars!.data!.cars[index].imgs.split(",").map((e) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            child:  Image.network(
        "${API.url}/$e",
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
        ),
        )).toList(),
      ),
    );
  }
  noResult(BuildContext context){
    return SizedBox(
      width: App.getDeviceWidthPercent(100, context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: App.getDeviceWidthPercent(90, context),
              child: Column(
                children: [
                  SizedBox(
                    width: App.getDeviceWidthPercent(90, context),
                    child: const Text("LUXURY RENTAL CAR",
                      style: TextStyle(
                        fontSize: App.large,
                        color: App.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: App.getDeviceWidthPercent(90, context),
                    child: const Text("Live Your Life Luxuriously And Elegantly! Take A Graceful Drive With A Professional Driver From Our Chauffeur Services In DubaiFor Comfort And Ease.",
                      style: TextStyle(
                          fontSize: App.xSmall,
                          color: App.lightWhite,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(20, context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/noResult.png"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: App.getDeviceWidthPercent(90, context),
              child: Column(
                children: [
                  SizedBox(
                    width: App.getDeviceWidthPercent(90, context),
                    child: const Text("WHY OUR LUXURY CHAUFFEUR SERVICE?",
                      style: TextStyle(
                        fontSize: App.large,
                        color: App.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: App.getDeviceWidthPercent(90, context),
                    child: const Text("Let Go Of The Wheel And Have Your Troubles Fade Away As A Chauffeur Takes Over Your Drive. Whether You're Going To A Business Meeting, A Late Dinner Party, Or Picking Up A Friend, We Can Make It Easy For You. Have Our Professional Take You Where You Want To Go In The Dream Car Of Your Choice.",
                      style: TextStyle(
                          fontSize: App.xSmall,
                          color: App.lightWhite,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: App.getDeviceWidthPercent(90, context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      App.lunchURL(context,"https://api.whatsapp.com/send?phone=");
                    },
                    child: Container(
                      width: Get.width * 0.35,
                      decoration: BoxDecoration(
                          color: App.grey,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/whatsapp.svg",width: 20,height: 20,color: Colors.green,),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Text(App_Localization.of(context).translate("whatsapp"),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: App.medium,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      if(await canLaunchUrl(Uri.parse('tel: +971581296445'))){
                        await launchUrl (Uri.parse('tel: +971581296445'));
                      }
                    },
                    child: Container(
                      width: Get.width * 0.35,
                      decoration: BoxDecoration(
                          color: App.grey,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () async{
                                    if(await canLaunchUrl(Uri.parse('tel: +971581296445'))){
                                      await launchUrl (Uri.parse('tel: +971581296445'));
                                    }
                                  },
                                  child: const Icon(Icons.call,color: Colors.red,size: App.iconSize,)
                              ),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Text(App_Localization.of(context).translate("call_us"),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: App.medium,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

