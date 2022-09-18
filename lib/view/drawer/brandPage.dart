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
        drawer: CustomDrawer(),
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
                    fontSize: CommonTextStyle.xlargeTextStyle,
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
                width: App.getDeviceWidthPercent(85, context),
                child: const Text("Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry's.",
                  style: TextStyle(
                    fontSize: CommonTextStyle.xSmallTextStyle,
                    color: App.lightGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          body(context),
          SizedBox(height: 20),
        ],
      ),
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
