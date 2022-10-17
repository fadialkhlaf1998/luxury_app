import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';

class BrandPage extends StatelessWidget {
  BrandPage({Key? key}) : super(key: key);

  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.primary,
            ),
            brands(context),
            const SizedBox(height: 20),
          ],
        )
    );
  }

  brands(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 80),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: App.getDeviceWidthPercent(100, context),
          //       child: const Text("LUXURY BRANDS CAR",
          //         style: TextStyle(
          //           fontSize: App.large,
          //           color: App.orange,
          //           fontWeight: FontWeight.bold,
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 30),
          brandList(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  brandList(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: App.getDeviceWidthPercent(90, context),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.8,
                mainAxisSpacing: 25
              ),
              itemCount: introductionController.homeData!.data!.brands.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index) {
                return GestureDetector(
                  onTap: () {
                    introductionController.carsByBrand(context,
                        introductionController.homeData!.data!.brands[index].id,index);
                  },
                  child: SizedBox(
                      child: SvgPicture.network(
                        "${API.url}/${introductionController.homeData!.data!.brands[index].img}",
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
