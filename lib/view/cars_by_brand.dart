import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';


class CarsByBrand extends StatelessWidget {

  AllCarsBrands allCarsBrands;
  int index;

  CarsByBrand(this.allCarsBrands,this.index);

  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.grey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: App.grey,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/filter.webp"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.18),
                    products(context,index),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: _header(context),
            )
          ],
        ),
      )
    );
  }

  _header(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      height: Get.height * 0.18,
      decoration: BoxDecoration(
          color: App.lightDarkGrey,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
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
      child: Column(
        children: [
          Container(
            width: App.getDeviceWidthPercent(100, context),
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
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      homeController.selectNavBar.value = 1;
                    },
                    child: SvgPicture.asset("assets/icons/logo.svg",
                    width: Get.width * 0.4),
                  ),
                  const Icon(Icons.arrow_back,color: Colors.transparent,size: App.iconSize,)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: App.getDeviceWidthPercent(100, context),
            color: App.lightDarkGrey,
            child: Center(
              child: Text(
                Global.languageCode == "en" ?
                introductionController.homeData!.data!.brands[index].titleEn :
                introductionController.homeData!.data!.brands[index].titleAr ,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: App.large,
                  color: App.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
  products(BuildContext context,int photoIndex) {
    return Column(
      children: [
        SizedBox(
            width: App.getDeviceWidthPercent(90, context),
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
                                        child: Image.network(
                                            "${API.url}/${introductionController.homeData!.data!.brands[photoIndex].img}",
                                            fit: BoxFit.fill),
                                      ),
                                    )
                                  ],
                                )
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Center(
                                  child: Text(allCarsBrands.brand.brands![index].slug.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: App.big,
                                          color: App.orange,
                                          fontWeight: FontWeight.bold
                                      )
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
                                  const Center() :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: Center(
                                              child: Text(" AED ${allCarsBrands.brand.brands![index].hourlyPrice} /",
                                                  style: const TextStyle(
                                                      fontSize: App.medium,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold
                                                  )
                                              ),
                                            ),
                                          ),
                                          Text(App_Localization.of(context).translate("hour"),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: App.xSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: allCarsBrands.brand.brands![index].oldHourlyPrice == 0 ? 0 : 5),
                                      allCarsBrands.brand.brands![index].oldHourlyPrice == 0 ?
                                      const Center() :
                                      Row(
                                        children: [
                                          Text(" AED ${allCarsBrands.brand.brands![index].oldHourlyPrice}",
                                            style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                              color: App.lightWhite,
                                              fontSize: App.small,
                                            ),
                                          ),
                                          const SizedBox(width: 5,),
                                          Text("${(100 - (allCarsBrands.brand.brands![index].hourlyPrice * 100)/allCarsBrands.brand.brands![index].oldHourlyPrice).round()}% OFF",
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: App.small,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  allCarsBrands.brand.brands![index].hourlyPrice == -1 ||  allCarsBrands.brand.brands![index].dailyPrice == -1 ?
                                  const Center() :
                                  VerticalDivider(
                                    color: App.white,
                                    thickness: 1,
                                    endIndent: allCarsBrands.brand.brands![index].oldHourlyPrice != 0 ? 8 : 12,
                                    indent: allCarsBrands.brand.brands![index].oldHourlyPrice != 0 ? 8 : 12,
                                  ),
                                  allCarsBrands.brand.brands![index].dailyPrice == -1 ?
                                  const Center() :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(" AED ${allCarsBrands.brand.brands![index].dailyPrice} /",
                                            style: const TextStyle(
                                                fontSize: App.medium,
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
                                      SizedBox(height: allCarsBrands.brand.brands![index].oldDailyPrice == 0 ? 0 : 5),
                                      allCarsBrands.brand.brands![index].oldDailyPrice == 0 ?
                                      const Center() :
                                      Row(
                                        children: [
                                          Text(" AED ${allCarsBrands.brand.brands![index].oldDailyPrice}",
                                            style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                              color: App.lightWhite,
                                              fontSize: App.small,
                                            ),
                                          ),
                                          const SizedBox(width: 5,),
                                          Text("${(100 - (allCarsBrands.brand.brands![index].dailyPrice * 100)/allCarsBrands.brand.brands![index].oldDailyPrice).round()}% OFF",
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: App.small,
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
                                                  fontSize: App.tiny + 1,
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
                                                  fontSize: App.tiny + 1,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              )
                                          ),
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=>ProductDetails(allCarsBrands.brand.brands![index].id));
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
                                                  fontSize: App.tiny + 1,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              )
                                          ),
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => Book(introductionController.allCars!.data!.cars[index]));
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
                                                  fontSize: App.tiny + 1,
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
        ),
        introductionController.homeData!.data!.brands[index].descriptionEn == "" ?
            const Center() :
        SizedBox(
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
                              fontSize: const FontSize(App.small),
                              fontWeight: FontWeight.normal,
                              color: App.lightWhite,
                            ),
                            "h2" : Style(
                              color: App.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: const FontSize(App.large)
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
        isLoop: false,
        children: allCarsBrands.brand.brands![index].imgs.split(",").map((e) => Container(
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
}
