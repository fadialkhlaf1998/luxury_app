import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/brands_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/widgets/drawer.dart';


class BrandPage extends StatelessWidget {
  BrandPage({Key? key}) : super(key: key);

  BrandsController brandsController = Get.put(BrandsController());
  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(homeController: homeController),
        body: Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
            ),
            SizedBox(height: 85,),
            brands(context),
          ],
        )
    );
  }

  brands(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 85),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Text("LUXURY BRANDS CAR",
                  style: TextStyle(
                    letterSpacing: 1,
                    height: 1.3,
                    fontSize: CommonTextStyle.xXlargeTextStyle,
                    color: App.orange,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Text("Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry's.",
                  style: TextStyle(
                    letterSpacing: 0.3,
                    height: 1.3,
                    fontSize: CommonTextStyle.mediumTextStyle,
                    color: App.lightGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          body(context),
          // brandsImages(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  brandsImages(BuildContext context) {
    return Container(
        width: App.getDeviceWidthPercent(100, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: CarouselSlider(
          carouselController: brandsController.buttonCarouselController,
          options: CarouselOptions(
            height: App.getDeviceHeightPercent(40, context),
            viewportFraction: 0.7,
            autoPlayAnimationDuration: Duration(milliseconds: 700),
            autoPlay: false,
            enlargeCenterPage: true,
          ),
          items: introductionController.homeData!.data!.brands.map((item) =>
              GestureDetector(
                onTap: () {
                  introductionController.carsByBrand(context,
                      item.id,introductionController.homeData!.data!.brands.indexOf(item));
                },
                child: Column(
                  children: [
                    Container(
                      width: App.getDeviceWidthPercent(100, context),
                      height: App.getDeviceHeightPercent(28, context),
                      child: Card(
                        child: SvgPicture.network(
                          API.url + "/" + item.img,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(item.name,
                      style: TextStyle(
                          color: App.lightGrey,
                          fontSize: CommonTextStyle.xXlargeTextStyle,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
          ).toList(),
        )
    );
  }
  body(BuildContext context) {
    return Column(
      children: [
        Container(
          width: App.getDeviceWidthPercent(95, context),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.4,
                mainAxisSpacing: 20
              ),
              itemCount: introductionController.homeData!.data!.brands.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index) {
                return GestureDetector(
                  onTap: () {
                    introductionController.carsByBrand(context,
                        introductionController.homeData!.data!.brands[index].id,index);
                  },
                  child: Container(
                      child: SvgPicture.network(
                        API.url + "/" + introductionController.homeData!.data!.brands[index].img,
                        fit: BoxFit.contain,
                      ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
