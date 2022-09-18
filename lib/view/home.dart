import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/home-data.dart';
import 'package:luxury_app/view/drawer/blogs.dart';
import 'package:luxury_app/view/drawer/FAQ.dart';
import 'package:luxury_app/view/drawer/about_us.dart';
import 'package:luxury_app/view/drawer/contact_us.dart';
import 'package:luxury_app/view/drawer/rent_terms.dart';
import 'package:luxury_app/view/settings.dart';
import 'package:luxury_app/view/book.dart';
import 'package:luxury_app/view/drawer/brandPage.dart';
import 'package:luxury_app/view/filter.dart';
import 'package:luxury_app/view/product_details.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/drawer.dart';
import 'package:luxury_app/widgets/image_and_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {

  HomeData homeData;
  HomeController homeController = Get.put(HomeController());
  IntroductionController introductionController = Get.find();

  Home(this.homeData) {
    homeController.selectNavDrawer.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: btnNavBar(context),
      backgroundColor: App.darkGrey,
        key: homeController.key,
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.darkGrey,
              ),
              homeController.selectNavDrawer.value == 0 ? home(context) :
              homeController.selectNavDrawer.value == 1 ? BrandPage() :
              homeController.selectNavDrawer.value == 2 ? Settings() :
              homeController.selectNavDrawer.value == 3 ? AboutUs() :
              homeController.selectNavDrawer.value == 4 ? RentTermsPage() :
              homeController.selectNavDrawer.value == 5 ? FAQ() :
              homeController.selectNavDrawer.value == 6 ? Blog() : ContactUs(),
              Positioned(
               child: Column(
                 children: [
                   header(context)
                 ],
               )
              ),
              introductionController.carsLoading.value ?
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.darkGrey,
                child: const Center(
                  child: CircularProgressIndicator(color: App.orange,),
                ),
              ) : const Center(),
            ],
          ),
        )
    ));
  }
  header(BuildContext context){
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      height: 70,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/top-nav.png"),
              fit: BoxFit.cover
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
              child: const Icon(Icons.menu,size: 25,color: App.orange),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                homeController.selectNavDrawer.value = 0;
                homeController.key.currentState!.openEndDrawer();
              },
              child: Container(
                child: SvgPicture.asset("assets/icons/logo.svg",
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            SizedBox(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => Filter(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0,0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                  child: const Icon(Icons.filter_alt_rounded,color: App.orange,size: 23),
                ),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: () {
                    introductionController.pressedOnSearch(context);
                  },
                  child: const Icon(Icons.search,color: App.orange,size: 23),
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
      color: App.darkGrey,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        ),
        child: BottomNavyBar(
          backgroundColor: App.grey,
          selectedIndex: homeController.selectNavDrawer.value,
          showElevation: true,
          itemCornerRadius: 20,
          curve: Curves.easeIn,
          onItemSelected: (index)  => homeController.selectNavDrawer.value = index,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.home,color: homeController.selectNavDrawer.value == 0 ? App.orange : App.lightGrey,size: 23,),
                title: Text(App_Localization.of(context).translate("home").toUpperCase(),
                  style: TextStyle(
                      color: homeController.selectNavDrawer.value == 0 ? App.orange : App.lightGrey,
                      fontSize: CommonTextStyle.xSmallTextStyle
                  ),
                ),
                activeColor: App.orange,
                textAlign: TextAlign.center
            ),
            BottomNavyBarItem(
              icon:  SvgPicture.asset("assets/icons/brand_nav_bar.svg",width: 27,height: 27,color: homeController.selectNavDrawer.value == 1 ? App.orange : App.lightGrey),
              title: Text(App_Localization.of(context).translate("brands").toUpperCase(),
                style: TextStyle(
                    color: homeController.selectNavDrawer.value == 1 ? App.orange : App.lightGrey,
                    fontSize: CommonTextStyle.xSmallTextStyle
                ),
              ),
              activeColor: App.orange,
              textAlign: TextAlign.center
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings,color: homeController.selectNavDrawer.value == 2 ? App.orange : App.lightGrey,size: 23),
              title: Text(App_Localization.of(context).translate("settings").toUpperCase(),
                style: TextStyle(
                    color: homeController.selectNavDrawer.value == 2 ? App.orange : App.lightGrey,
                    fontSize: CommonTextStyle.xSmallTextStyle
                ),
              ),
              activeColor: App.orange,
                textAlign: TextAlign.center
            ),
          ],
        ),
      ),
    );
  }
  home(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 85),
              superCategory(context,homeData, homeController.selectSuperCategory.value),
              const SizedBox(height: 15),
              homeData.data!.carType[homeController.selectSuperCategory.value].id != 3?
              noResultFound(context) : category(context),
              introductionController.loading.value ?
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(50, context),
                color: App.darkGrey,
                child: const Center(
                  child: CircularProgressIndicator(color: App.orange,),
                ),
              ) :
              homeData.data!.carType[homeController.selectSuperCategory.value].id !=
                  3 ? const Center() :
              products(context),
              homeData.data!.carType[homeController.selectSuperCategory.value].id !=
                  3 ? const Center() : (introductionController.lengthproductList.value == introductionController.allCars!.data!.cars.length)
                  || introductionController.loading.value == true
                  ? const Center() :
              GestureDetector(
                  onTap: () {
                    introductionController.viewAllProducts();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: App.getDeviceWidthPercent(35, context),
                        height: 35,
                        decoration: BoxDecoration(
                            color: App.orange,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_circle_down,color: Colors.white,size: 23,),
                            const SizedBox(width: 5),
                            Text(App_Localization.of(context).translate("see_more"),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: CommonTextStyle.mediumTextStyle,
                                  fontWeight: FontWeight.bold,
                                )
                            )
                          ],
                        )
                      )
                    ],
                  )
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }
  superCategory(BuildContext context,HomeData homeData,int index) {
    return Container(
        height: 35,
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
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: homeController.selectSuperCategory.value == index ?
                              App.orange : App.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.network(API.url + "/" + homeData.data!.carType[index].img,
                                      fit: BoxFit.cover,
                                      color: homeController.selectSuperCategory.value == index ? Colors.black : App.orange,
                                  )
                              ),
                              const SizedBox(width: 5),
                              Text(Global.languageCode == "en" ?
                              homeData.data!.carType[index].nameEn :
                              homeData.data!.carType[index].nameAr,
                                style: TextStyle(
                                    fontSize: CommonTextStyle.xSmallTextStyle,
                                    color:  homeController.selectSuperCategory.value == index ? Colors.black : Colors.white,
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
    return Container(
      height: 35,
      child: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context,int index) {
          return Obx(() => GestureDetector(
            onTap: () {
              homeController.selectCategory.value = index;
              homeController.selectAll.value = true;
              introductionController.loading.value = true;
              introductionController.allCars = introductionController.allCarsConst;
              Future.delayed(const Duration(seconds: 1)).then((value) {
                introductionController.loading.value = false;
              });
              introductionController.initProductCount();
              },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    width: 130,
                    decoration: BoxDecoration(
                        color: homeController.selectCategory.value == 0 && homeController.selectAll.value == true ?
                        App.orange : App.grey,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(App_Localization.of(context).translate("all").toUpperCase(),
                          style: CommonTextStyle.textStyleForSmallWhiteBold
                      ),
                    )
                  ),
                ),
                Container(
                    child: ListView.builder(
                        itemCount: homeData.data!.carBody.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Obx(() => GestureDetector(
                            onTap: () {
                              introductionController.getCarsById(context, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: homeController.selectCategory.value == index && homeController.selectAll.value  == false?
                                        App.orange : App.grey,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text(Global.languageCode == "en" ?
                                      homeData.data!.carBody[index].nameEn :
                                      homeData.data!.carBody[index].nameAr,
                                          style: CommonTextStyle.textStyleForSmallWhiteBold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                        })
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
  products(BuildContext context) {
    return introductionController.allCars!.data!.cars.isEmpty ?
       Column(
         children: [
           const SizedBox(height: 20),
           noResultFound(context)
         ],
       ) :
      Container(
        width: App.getDeviceWidthPercent(92, context),
        child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: introductionController.lengthproductList.value,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  homeController.selectNavDrawer.value = 0;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: App.getDeviceWidthPercent(92, context),
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
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    child: introductionController.allCars!.data!.cars[index].brands!.img == null ? Center() :
                                    SvgPicture.network(API.url + "/" + introductionController.allCars!.data!.cars[index].brands!.img,
                                        fit: BoxFit.fill),
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(height: 10,),
                        Expanded(
                          flex: 1,
                          child: Text(introductionController.allCars!.data!.cars[index].slug,
                              style: CommonTextStyle.textStyleForBigOrangeBold
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
                                      Text(" AED " +  introductionController.allCars!.data!.cars[index].hourlyPrice.toString(),
                                          style: CommonTextStyle.textStyleForMediumWhiteNormal
                                      ),
                                      Text(" "+App_Localization.of(context).translate("hour"),
                                        style: const TextStyle(
                                            color: App.lightGrey,
                                            fontSize: CommonTextStyle.mediumTextStyle,
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: introductionController.allCars!.data!.cars[index].oldHourlyPrice == 0 ? 0 : 5),
                                  introductionController.allCars!.data!.cars[index].oldHourlyPrice == 0 ?
                                  const Center() :
                                  Row(
                                    children: [
                                      Text(" AED " + introductionController.allCars!.data!.cars[index].oldHourlyPrice.toString(),
                                        style: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.red,
                                          color: App.lightGrey,
                                          fontSize: CommonTextStyle.smallTextStyle,
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(((100 - (introductionController.allCars!.data!.cars[index].hourlyPrice * 100)/introductionController.allCars!.data!.cars[index].oldHourlyPrice).round().toString()) + "%" +" OFF",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: CommonTextStyle.smallTextStyle,
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              introductionController.allCars!.data!.cars[index].hourlyPrice == -1 ||  introductionController.allCars!.data!.cars[index].dailyPrice == -1 ?
                              const Center() :
                              VerticalDivider(
                                color: App.orange,
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
                                      Text(" AED " + introductionController.allCars!.data!.cars[index].dailyPrice.toString(),
                                          style: CommonTextStyle.textStyleForMediumWhiteNormal
                                      ),
                                      Text(" "+App_Localization.of(context).translate("day"),
                                        style: const TextStyle(
                                            color: App.lightGrey,
                                            fontSize: CommonTextStyle.mediumTextStyle,
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: introductionController.allCars!.data!.cars[index].oldDailyPrice == 0 ? 0 : 5),
                                  introductionController.allCars!.data!.cars[index].oldDailyPrice == 0 ?
                                  const Center() :
                                  Row(
                                    children: [
                                      Text(" AED " + introductionController.allCars!.data!.cars[index].oldDailyPrice.toString(),
                                        style: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.red,
                                          color: App.lightGrey,
                                          fontSize: CommonTextStyle.smallTextStyle,
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(((100 - (introductionController.allCars!.data!.cars[index].dailyPrice * 100)/introductionController.allCars!.data!.cars[index].oldDailyPrice).round().toString()) + "%" +" OFF",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: CommonTextStyle.smallTextStyle,
                                            fontStyle: FontStyle.italic
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
                                          child1: Icon(Icons.whatsapp,color: Colors.green,size: 14,),
                                          text: "whatsapp",
                                          textStyle:  CommonTextStyle.textStyleForTinyWhiteNormal
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
                                          textStyle:  CommonTextStyle.textStyleForTinyWhiteNormal
                                      ),
                                    )
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(()=>ProductDetails(introductionController.allCars!.data!.cars[index].id));
                                  homeController.selectNavDrawer.value = 0;
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
                                          textStyle:  CommonTextStyle.textStyleForTinyWhiteNormal
                                      ),
                                    )
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => Book(introductionController.allCars!.data!.cars[index]),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(1.0,0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;
                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ));
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
                                          textStyle:  CommonTextStyle.textStyleForTinyWhiteNormal
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
    return Stack(
      children: [
        Container(
          width: App.getDeviceWidthPercent(100, context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: CarouselSlider.builder(
            carouselController: homeController.carouselController,
            options: CarouselOptions(
                height: App.getDeviceHeightPercent(23, context),
                autoPlay: false,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enlargeStrategy:
                CenterPageEnlargeStrategy.height,
                autoPlayInterval: Duration(seconds: 2),
                onPageChanged: (sliderindex, reason) {
                  introductionController.allCars!.data!.cars[index].index.value = sliderindex;
                }),
            itemCount: introductionController.allCars!.data!.cars[index].imgs.split(",").length,
            itemBuilder: (BuildContext context, int photoIndex, int realIndex) {
              return Container(
                width: App.getDeviceWidthPercent(100, context),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(API.url + "/" + introductionController.allCars!.data!.cars[index].imgs.split(",")[photoIndex]),
                        fit: BoxFit.cover
                    )
                ),
              );
            },
          ),
        ),
        Positioned(
            left: MediaQuery.of(context).size.width * 0.25,
            bottom: 10,
            child: Obx(() => Container(
              width: App.getDeviceWidthPercent(50, context),
              child: Center(
                child: AnimatedSmoothIndicator(
                  duration: Duration(milliseconds: 300),
                  activeIndex: introductionController.allCars!.data!.cars[index].index.value,
                  count: introductionController.allCars!.data!.cars[index].imgs.split(",").length,
                  effect: SlideEffect(
                      dotWidth: 6,
                      dotHeight: 6,
                      activeDotColor: App.orange,
                      dotColor: App.lightGrey,
                  ),
                ),
              ),
            ))
        )
      ],
    );
  }
  noResultFound(BuildContext context){
    return Column(
      children: [
        Container(
          width: App.getDeviceWidthPercent(40, context),
          height: 35,
          decoration: BoxDecoration(
              color: App.field,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              const SizedBox(width: 10,),
              Text(App_Localization.of(context).translate("no_results_found!"),
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: CommonTextStyle.smallTextStyle
                  )
              ),
            ],
          ),
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: App.getDeviceWidthPercent(90, context),
              child: const Text("LUXURY RENTAL CAR",
                style: TextStyle(
                  fontSize: CommonTextStyle.xlargeTextStyle,
                  color: App.orange,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: App.getDeviceWidthPercent(90, context),
              child: const Text("Live Your Life Luxuriously And Elegantly! Take A Graceful Drive With A Professional Driver From Our Chauffeur Services In DubaiFor Comfort And Ease.",
                style: TextStyle(
                    fontSize: CommonTextStyle.xSmallTextStyle,
                    color: App.lightGrey,
                    fontWeight: FontWeight.normal
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Container(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(28, context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/chauffeur.webp"),
                  fit: BoxFit.fill
              )
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: App.getDeviceWidthPercent(90, context),
              child: const Text("WHY OUR LUXURY CHAUFFEUR SERVICE?",
                style: TextStyle(
                  fontSize: CommonTextStyle.xlargeTextStyle,
                  color: App.orange,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: App.getDeviceWidthPercent(90, context),
              child: const Text("Let Go Of The Wheel And Have Your Troubles Fade Away As A Chauffeur Takes Over Your Drive. Whether You're Going To A Business Meeting, A Late Dinner Party, Or Picking Up A Friend, We Can Make It Easy For You. Have Our Professional Take You Where You Want To Go In The Dream Car Of Your Choice.",
                style: TextStyle(
                    fontSize: CommonTextStyle.xSmallTextStyle,
                    color: App.lightGrey,
                    fontWeight: FontWeight.normal
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

