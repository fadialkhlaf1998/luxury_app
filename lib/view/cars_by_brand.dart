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
import 'package:luxury_app/model/brands.dart';
import 'package:luxury_app/view/book.dart';
import 'package:luxury_app/view/product_details.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/image_and_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';


class CarsByBrand extends StatelessWidget {

  AllCarsBrands allCarsBrands;
  int index;

  CarsByBrand(this.allCarsBrands,this.index) {
  }

  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.darkGrey,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
            ),
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 85),
                    Container(
                      width: App.getDeviceWidthPercent(90, context),
                      child: Text(
                        Global.languageCode == "en" ?
                        introductionController.homeData!.data!.brands[index].titleEn :
                        introductionController.homeData!.data!.brands[index].titleAr ,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: CommonTextStyle.xlargeTextStyle,
                          color: App.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    products(context,index),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            _header(context),
          ],
        ),
      )
    );
  }

  _header(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      height: 70,
      decoration: const BoxDecoration(
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
                Get.back();
              },
              child: ContainerWithImage(
                  width: 28,
                  height: 28,
                  image: Global.languageCode == "en" ?
                  "assets/icons/back-icon.svg" :
                  "assets/icons/back-icon_arabic.svg",
                  option: 0
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                homeController.selectNavDrawer.value = 0;
              },
              child: Container(
                child: SvgPicture.asset("assets/icons/logo.svg",
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                ///share
              },
              child: Container(
                child: SvgPicture.asset("assets/icons/share.svg",
                  width: 26,
                  height: 26,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  products(BuildContext context,int photoIndex) {
    return Column(
      children: [
        Container(
            width: App.getDeviceWidthPercent(92, context),
            child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: allCarsBrands.brand.brands!.length,
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
                      Get.to(()=>ProductDetails(allCarsBrands.brand.brands![index].id));
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
                                        child: SvgPicture.network(
                                            API.url + "/" + introductionController.homeData!.data!.brands[photoIndex].img,
                                            fit: BoxFit.fill),
                                      ),
                                    )
                                  ],
                                )
                            ),
                            SizedBox(height: 10,),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Center(
                                  child: Text(allCarsBrands.brand.brands![index].slug.toUpperCase(),
                                    style: CommonTextStyle.textStyleForBigOrangeBold,
                                  ),
                                ),
                              )
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  allCarsBrands.brand.brands![index].hourlyPrice == -1 ?
                                  Center() :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: Center(
                                              child: Text(" AED " +  allCarsBrands.brand.brands![index].hourlyPrice.toString(),
                                                style: CommonTextStyle.textStyleForMediumWhiteNormal,
                                              ),
                                            ),
                                          ),
                                          Text(" " + App_Localization.of(context).translate("hour"),
                                            style: TextStyle(
                                                color: App.lightGrey,
                                                fontSize: CommonTextStyle.mediumTextStyle,
                                                fontStyle: FontStyle.italic
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: allCarsBrands.brand.brands![index].oldHourlyPrice == 0 ? 0 : 5),
                                      allCarsBrands.brand.brands![index].oldHourlyPrice == 0 ?
                                      Center() :
                                      Row(
                                        children: [
                                          Text(" AED " + allCarsBrands.brand.brands![index].oldHourlyPrice.toString(),
                                            style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                              color: App.lightGrey,
                                              fontSize: CommonTextStyle.smallTextStyle,
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(((100 - (allCarsBrands.brand.brands![index].hourlyPrice * 100)/allCarsBrands.brand.brands![index].oldHourlyPrice).round().toString()) + "%" +" OFF",
                                            style:  const TextStyle(
                                                color: Colors.green,
                                                fontSize: CommonTextStyle.smallTextStyle,
                                                fontStyle: FontStyle.italic
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  allCarsBrands.brand.brands![index].hourlyPrice == -1 ||  allCarsBrands.brand.brands![index].dailyPrice == -1 ?
                                  Center() :
                                  VerticalDivider(
                                    color: App.orange,
                                    thickness: 1,
                                    endIndent: allCarsBrands.brand.brands![index].oldHourlyPrice != 0 ? 8 : 12,
                                    indent: allCarsBrands.brand.brands![index].oldHourlyPrice != 0 ? 8 : 12,
                                  ),
                                  allCarsBrands.brand.brands![index].dailyPrice == -1 ?
                                  Center() :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(" AED " + allCarsBrands.brand.brands![index].dailyPrice.toString(),
                                            style: CommonTextStyle.textStyleForMediumWhiteNormal
                                          ),
                                          Text(" " + App_Localization.of(context).translate("day"),
                                            style: const TextStyle(
                                                color: App.lightGrey,
                                                fontSize: CommonTextStyle.mediumTextStyle,
                                                fontStyle: FontStyle.italic
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: allCarsBrands.brand.brands![index].oldDailyPrice == 0 ? 0 : 5),
                                      allCarsBrands.brand.brands![index].oldDailyPrice == 0 ?
                                      Center() :
                                      Row(
                                        children: [
                                          Text(" AED " + allCarsBrands.brand.brands![index].oldDailyPrice.toString(),
                                            style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                              color: App.lightGrey,
                                              fontSize: CommonTextStyle.smallTextStyle,
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(((100 - (allCarsBrands.brand.brands![index].dailyPrice * 100)/allCarsBrands.brand.brands![index].oldDailyPrice).round().toString()) + "%" +" OFF",
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
                                        decoration: BoxDecoration(
                                          color: App.grey,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          child: ImageAndText(
                                              child1: Icon(Icons.call,color: Colors.red,size: 14,),
                                              text: "call",
                                              textStyle:  CommonTextStyle.textStyleForTinyWhiteNormal
                                          ),
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=>ProductDetails(allCarsBrands.brand.brands![index].id));
                                      homeController.selectNavDrawer.value = 0;
                                    },
                                    child: Container(
                                        width: App.getDeviceWidthPercent(92, context) / 5,
                                        decoration: BoxDecoration(
                                          color: App.grey,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          child: ImageAndText(
                                              child1: Icon(Icons.info_outline,color: Colors.orange,size: 14,),
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
        ),
        introductionController.homeData!.data!.brands[index].descriptionEn == "" ?
            Center() :
        Container(
            width: App.getDeviceWidthPercent(88, context),
            height: App.getDeviceHeightPercent(35, context),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                controller: scrollController,
                child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Html(
                          data: Global.languageCode == "en" ?
                          introductionController.homeData!.data!.brands[index].descriptionEn :
                          introductionController.homeData!.data!.brands[index].descriptionAr ,
                          style: {
                            "body": Style(
                              fontSize: FontSize(CommonTextStyle.smallTextStyle),
                              fontWeight: FontWeight.normal,
                              color: App.lightGrey,
                            ),
                            "h2" : Style(
                              color: App.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize(CommonTextStyle.xlargeTextStyle)
                            )
                          },
                        ),
                      ],
                    )
                ),
              ),
            )
        ),
      ],
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
            itemCount: allCarsBrands.brand.brands![index].imgs.split(",").length,
            itemBuilder: (BuildContext context, int photoIndex, int realIndex) {
              return Container(
                width: App.getDeviceWidthPercent(100, context),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(API.url + "/" + allCarsBrands.brand.brands![index].imgs.split(",")[photoIndex]),
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
}
