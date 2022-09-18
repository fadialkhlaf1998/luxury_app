import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/product_details_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/all-cars.dart';
import 'package:luxury_app/model/car-info.dart';
import 'package:luxury_app/view/book.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/custom_button.dart';
import 'package:luxury_app/widgets/drawer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProductDetails extends StatelessWidget {

  CarDetail? car;
  ProductDetails(int id) {
    API.checkInternet().then((internet) {
      if(internet) {
        productDetailsController.loading.value = true;
        API.getCarsById(id.toString()).then((value) {
          if(value == null){
            Get.back();
          }
          car = value!.data!.car!;
          productDetailsController.loading.value = false;
        });
      }
    });
  }

  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: App.darkGrey,
        key: productDetailsController.key,
        drawer: CustomDrawer(),
        body: productDetailsController.loading.value || car == null?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: App.grey,
          child: const Center(
            child: CircularProgressIndicator(color: App.orange),
          ),
        ) :
        SafeArea(
          child: Stack(
            children: [
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.darkGrey,
              ),
              productDetails(context),
              header(context),
            ],
          ),
        )
    ));
  }

  productDetails(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 85),
          body(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  header(BuildContext context) {
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
                Get.back();
                homeController.searchIcon.value = true;
                homeController.search.clear();
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
                homeController.selectNavDrawer.value = 0;
                Get.back();
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
  body(BuildContext context) {
    return Column(
      children: [
        titleAndPrice(context),
        SizedBox(height: 15),
        images(context),
        SizedBox(height: 15),
        CustomButton(
            width: App.getDeviceWidthPercent(90, context),
            height: 40,
            text: App_Localization.of(context).translate("book_now").toUpperCase(),
            onPressed: () {
              var bookedCar = Car(id: car!.id, typeId: car!.typeId, brandId: car!.brandId, bodyId: car!.bodyId, slug: car!.slug,
                  slugGroup: car!.slugGroup, model: car!.model, year: car!.year, innerColor: car!.innerColor,
                  outerColor: car!.outerColor, seats: car!.seats, oldDailyPrice: car!.oldDailyPrice, dailyPrice: car!.dailyPrice,
                  oldHourlyPrice: car!.oldHourlyPrice, hourlyPrice: car!.hourlyPrice, descriptionEn: car!.descriptionEn,
                  descriptionAr: car!.descriptionAr, imgs: car!.imgs, metaTitleEn: car!.metaTitleEn,
                  metaTitleAr: car!.metaTitleAr, metaKeywordsEn: car!.metaKeywordsEn,
                  metaKeywordsAr: car!.metaKeywordsAr, metaDescriptionEn: car!.metaDescriptionEn,
                  metaDescriptionAr: car!.metaDescriptionAr, metaImage: car!.metaImage,
                  brands: car!.brandsList!, types: null, bodies: car!.bodiesList);
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => Book(bookedCar),
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
            color: App.orange,
          borderRadius: 10,
          textStyle: CommonTextStyle.textStyleForMediumWhiteNormal,
        ),
        SizedBox(height: 15),
        carDetails(context),
      ],
    );
  }
  titleAndPrice(BuildContext context) {
    return Column(
      children: [
        Text(car!.slug,
            style: const TextStyle(
              fontSize: CommonTextStyle.xlargeTextStyle,
              color: App.orange,
              fontWeight: FontWeight.bold,
            ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            car!.hourlyPrice == -1 ?
            const Center() :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(" AED " +  car!.hourlyPrice.toString(),
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
                SizedBox(height: car!.oldHourlyPrice == 0 ? 0 : 5),
                car!.oldHourlyPrice == 0 ?
                Center() :
                Row(
                  children: [
                    Text(" AED " + car!.oldHourlyPrice.toString(),
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        color: App.lightGrey,
                        fontSize: CommonTextStyle.smallTextStyle,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(((100 - (car!.hourlyPrice * 100)/car!.oldHourlyPrice).round().toString()) + " % " +" OFF",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: CommonTextStyle.smallTextStyle,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ],
                ),
              ],
            ),
            car!.hourlyPrice == -1 || car!.dailyPrice == -1 ?
            const Center() :
            Container(
              height: 60,
              child: VerticalDivider(
                color: App.orange,
                thickness: 1,
                endIndent: car!.oldHourlyPrice != 0 ? 8 : 12,
                indent: car!.oldHourlyPrice != 0 ? 8 : 12,
              ),
            ),
            car!.dailyPrice == -1 ?
            Center() :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(" AED " + car!.dailyPrice.toString(),
                        style: CommonTextStyle.textStyleForMediumWhiteNormal
                    ),
                    Text(" "+App_Localization.of(context).translate("day"),
                      style: TextStyle(
                          color: App.lightGrey,
                          fontSize: CommonTextStyle.mediumTextStyle,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ],
                ),
                SizedBox(height: car!.oldDailyPrice == 0 ? 0 : 5),
                car!.oldDailyPrice == 0 ?
                Center() :
                Row(
                  children: [
                    Text(" AED " + car!.oldDailyPrice.toString(),
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        color: App.lightGrey,
                        fontSize: CommonTextStyle.smallTextStyle,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(((100 - (car!.dailyPrice * 100)/car!.oldDailyPrice).round().toString()) + " % " +" OFF",
                      style: TextStyle(
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
      ],
    );
  }
  images(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(90, context),
              height: App.getDeviceHeightPercent(20, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CarouselSlider.builder(
                carouselController: productDetailsController.carouselController,
                options: CarouselOptions(
                    height: App.getDeviceHeightPercent(20, context),
                    autoPlay: false,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    enlargeStrategy:
                    CenterPageEnlargeStrategy.height,
                    autoPlayInterval: const Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      productDetailsController.setIndex(index);
                    }),
                itemCount: car!.imgs.split(",").length,
                itemBuilder: (BuildContext context,int photoIndex, int realIndex) {
                  return Container(
                    width: App.getDeviceWidthPercent(90, context),
                    height: App.getDeviceHeightPercent(20, context),
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(API.url + "/" + car!.imgs.split(",")[photoIndex]),
                            fit: BoxFit.cover
                        )
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 15,
              top: App.getDeviceHeightPercent(20, context) / 2 - 10,
              child: GestureDetector(
                onTap: () {
                  // productDetailsController.carouselController.previousPage(duration: Duration(milliseconds: 400));
                  if(productDetailsController.activeIndex.value>0){
                    productDetailsController.setIndex(productDetailsController.activeIndex.value-1);
                  }

                },
                child: Container(
                  child: Icon(Icons.arrow_circle_left_outlined,size: 25,color: App.orange,),
                ),
              ),
            ),
            Positioned(
              right: 15,
              top: App.getDeviceHeightPercent(20, context) / 2 - 10,
              child: GestureDetector(
                onTap: () {
                  if(productDetailsController.activeIndex.value<car!.imgs.length){
                    productDetailsController.setIndex(productDetailsController.activeIndex.value+1);
                  }
                },
                child: Container(
                  child: Icon(Icons.arrow_circle_right_outlined,size: 25,color: App.orange,),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10,),
        Container(
            width: App.getDeviceWidthPercent(92, context),
            height: App.getDeviceHeightPercent(10, context),
            child: ScrollablePositionedList.builder(
              itemScrollController: productDetailsController.itemScrollController,
              itemCount: car!.imgs.split(",").length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: () {
                    productDetailsController.setIndex(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: App.getDeviceWidthPercent(40, context),
                      height: App.getDeviceHeightPercent(10, context),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(API.url + "/" + car!.imgs.split(",")[index]),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  )
                );
              },
            )
        ),
      ],
    );
  }
  carDetails(BuildContext context) {
    return Column(
      children: [
        Container(
          width: App.getDeviceWidthPercent(95, context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/brand.svg",fit: BoxFit.cover,width: 40,height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(App_Localization.of(context).translate("brand").toUpperCase(),
                            style: const TextStyle(
                              fontSize: CommonTextStyle.smallTextStyle + 1,
                              color: App.lightGrey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: App.getDeviceWidthPercent(35, context),
                            child: Text(car!.brandsList!.name,
                              style: TextStyle(
                                fontSize: CommonTextStyle.smallTextStyle,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/MODEL.svg",fit: BoxFit.cover,width: 40,height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(App_Localization.of(context).translate("model").toUpperCase(),
                            style: const TextStyle(
                              fontSize: CommonTextStyle.smallTextStyle + 1,
                              color: App.lightGrey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: App.getDeviceWidthPercent(35, context),
                            child: Text(car!.model,
                              style: const TextStyle(
                                fontSize: CommonTextStyle.smallTextStyle,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: App.getDeviceWidthPercent(95, context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/year.svg",fit: BoxFit.cover,width: 40,height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(App_Localization.of(context).translate("year").toUpperCase(),
                            style: const TextStyle(
                              fontSize: CommonTextStyle.smallTextStyle + 1,
                              color: App.lightGrey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: App.getDeviceWidthPercent(35, context),
                            child: Text(car!.year.toString(),
                              style: const TextStyle(
                                fontSize: CommonTextStyle.smallTextStyle + 1,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/seats.svg",fit: BoxFit.cover,width: 40,height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(App_Localization.of(context).translate("seats").toUpperCase(),
                            style: const TextStyle(
                              height: 1.3,
                              letterSpacing: 1,
                              fontSize: CommonTextStyle.mediumTextStyle,
                              color: App.lightGrey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ///listview later
                          Container(
                            width: App.getDeviceWidthPercent(35, context),
                            child: Text(car!.seats.toString(),
                              style: const TextStyle(
                                height: 1.3,
                                letterSpacing: 1,
                                fontSize: CommonTextStyle.smallTextStyle,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
