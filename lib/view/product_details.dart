import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/product_details_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/model/all-cars.dart';
import 'package:luxury_app/model/car-info.dart';
import 'package:luxury_app/view/book.dart';
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
        backgroundColor: App.grey,
        key: productDetailsController.key,
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: App.lightDarkGrey,
              ),
              productDetailsController.loading.value || car == null ?
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: App.primary,
                child: const Center(
                  child: CupertinoActivityIndicator(color: App.orange),
                ),
              ) :
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.1),
                    body(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: header(context),
              )
            ],
          ),
        )
    ));
  }

  header(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      height: Get.height * 0.1,
      color: App.lightDarkGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back,color: Colors.white,size: App.iconSize,)
            ),
            Text(App_Localization.of(context).translate("car_details").toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: App.large,
                  fontWeight: FontWeight.w600
              ),
            ),
            const Icon(Icons.arrow_back,color: Colors.transparent,size: App.iconSize,)
          ],
        ),
      ),
    );
  }
  body(BuildContext context) {
    return Column(
      children: [
        title(context),
        const SizedBox(height: 10),
        images(context),
        const SizedBox(height: 10),
        price(context),
        const SizedBox(height: 10),
        carDetails(context),
        const SizedBox(height: 20),
        CustomButton(
            width: App.getDeviceWidthPercent(90, context),
            height: 50,
            text: App_Localization.of(context).translate("book_now").toUpperCase(),
            onPressed: () {
              var bookedCar = Car(id: car!.id,orderNumber: car!.orderNumber,orderBrandNumber: car!.orderBrandNumber,
                  orderCategoryNumber: car!.orderCategoryNumber,typeId: car!.typeId, brandId: car!.brandId,canonical: car!.canonical,slug: car!.slug,
                  slugGroup: car!.slugGroup, model: car!.model, year: car!.year, innerColor: car!.innerColor,
                  outerColor: car!.outerColor, seats: car!.seats, oldDailyPrice: car!.oldDailyPrice, dailyPrice: car!.dailyPrice,
                  oldHourlyPrice: car!.oldHourlyPrice, hourlyPrice: car!.hourlyPrice, descriptionEn: car!.descriptionEn,
                  descriptionAr: car!.descriptionAr, imgs: car!.imgs, metaTitleEn: car!.metaTitleEn,
                  metaTitleAr: car!.metaTitleAr, metaKeywordsEn: car!.metaKeywordsEn,
                  metaKeywordsAr: car!.metaKeywordsAr, metaDescriptionEn: car!.metaDescriptionEn,
                  metaDescriptionAr: car!.metaDescriptionAr, metaImage: car!.metaImage,
                  brands: car!.brandsList!, types: null, bodies: car!.bodies);
              Get.to(() => Book(bookedCar));
            },
            color: App.orange,
            borderRadius: 8,
            textStyle: const TextStyle(
                fontSize: App.medium,
                color: Colors.white,
                fontWeight: FontWeight.w600
            )
        ),
      ],
    );
  }
  title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: App.getDeviceWidthPercent( 90,context),
          child: Text(car!.slug.toUpperCase().replaceAll("-", " "),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: App.large + 2,
              color: App.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
  images(BuildContext context) {
    return Column(
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
                  // productDetailsController.setIndex(index);
                  if(reason == CarouselPageChangedReason.manual){
                    productDetailsController.setIndex(index);
                  }
                  print(reason);
                }),
            itemCount: car!.imgs.split(",").length,
            itemBuilder: (BuildContext context,int photoIndex, int realIndex) {
              return Container(
                width: App.getDeviceWidthPercent(90, context),
                height: App.getDeviceHeightPercent(20, context),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                    image: DecorationImage(
                        image: NetworkImage("${API.url}/${car!.imgs.split(",")[photoIndex]}"),
                        fit: BoxFit.cover
                    )
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: App.getDeviceWidthPercent(90, context),
          child: Text(App_Localization.of(context).translate("photo_car").toUpperCase(),
            style: const TextStyle(
              color: App.lightWhite,
              fontSize: App.medium,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
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
                        width: App.getDeviceWidthPercent(25, context),
                        height: App.getDeviceHeightPercent(25, context),
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: productDetailsController.activeIndex.value == index ?App.orange:App.grey),
                        ),
                        child: SizedBox(
                          child:  Image.network(
                            "${API.url}/${car!.imgs.split(",")[index]}",
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
                      ),
                    )
                );
              },
            )
        ),
      ],

    );
  }
  price(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: App.getDeviceWidthPercent(90, context),
          child: Text(App_Localization.of(context).translate("price").toUpperCase(),
            style: const TextStyle(
              color: App.lightWhite,
              fontSize: App.medium,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: App.getDeviceWidthPercent(90, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              car!.hourlyPrice == -1 ?
              const Center() :
              Container(
                width: car!.dailyPrice == -1 ?
                App.getDeviceWidthPercent(90, context):
                App.getDeviceWidthPercent(40, context),
                height: 60,
                decoration: BoxDecoration(
                    color: App.grey,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: App.orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(" AED ${car!.hourlyPrice} /",
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
                          SizedBox(height: car!.oldHourlyPrice == 0 ? 0 : 5),
                          car!.oldHourlyPrice == 0 ?
                          const Center() :
                          Row(
                            children: [
                              Text(" AED ${car!.oldHourlyPrice}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  color: App.lightWhite,
                                  fontSize: App.xSmall,
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Text("${(100 - (car!.hourlyPrice * 100)/car!.oldHourlyPrice).round()} %  OFF",
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
                    ],
                  ),
                ),
              ),
              car!.dailyPrice == -1 ?
              const Center() :
              Container(
                width: car!.hourlyPrice == -1 ?
                App.getDeviceWidthPercent(90, context):
                App.getDeviceWidthPercent(40, context),
                height: 60,
                decoration: BoxDecoration(
                    color: App.grey,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: App.orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(" AED ${car!.dailyPrice}00 /",
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
                          SizedBox(height: car!.oldDailyPrice == 0 ? 0 : 5),
                          car!.oldDailyPrice == 0 ?
                          const Center() :
                          Row(
                            children: [
                              Text(" AED ${car!.oldDailyPrice}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  color: App.lightWhite,
                                  fontSize: App.xSmall,
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Text("${(100 - (car!.dailyPrice * 100)/car!.oldDailyPrice).round()} %  OFF",
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
              )
            ],
          ),
        ),

      ],
    );
  }
  carDetails(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: App.getDeviceWidthPercent(90, context),
          child: Text(App_Localization.of(context).translate("car_details").toUpperCase(),
            style: const TextStyle(
              color: App.lightWhite,
              fontSize: App.medium,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: App.getDeviceWidthPercent(90, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${App_Localization.of(context).translate("brand")} : ",
                        style: const TextStyle(
                          fontSize: App.small,
                          color: App.orange,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        // width: App.getDeviceWidthPercent(35, context),
                        child: Text(car!.brandsList!.name,
                          style: const TextStyle(
                            fontSize: App.xSmall,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text("${App_Localization.of(context).translate("year")} : ",
                        style: const TextStyle(
                          fontSize: App.small,
                          color: App.orange,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        // width: App.getDeviceWidthPercent(35, context),
                        child: Text(car!.year.toString(),
                          style: const TextStyle(
                            fontSize: App.xSmall,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${App_Localization.of(context).translate("seats")} : ",
                        style: const TextStyle(
                          fontSize: App.small,
                          color: App.orange,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ///listview later
                      SizedBox(
                        // width: App.getDeviceWidthPercent(35, context),
                        child: Text(car!.seats.toString(),
                          style: const TextStyle(
                            fontSize: App.xSmall,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text("${App_Localization.of(context).translate("model")} : ",
                        style: const TextStyle(
                          fontSize: App.small,
                          color: App.orange,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        // width: App.getDeviceWidthPercent(35, context),
                        child: Text(car!.model,
                          style: const TextStyle(
                            fontSize: App.xSmall,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
