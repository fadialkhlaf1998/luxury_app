import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/widgets/custom_button.dart';

class Filter extends StatelessWidget {

  Filter(){
    homeController.initializePrice(introductionController);
  }

  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: App.grey,
      body: SafeArea(
        child: Container(
            width: App.getDeviceWidthPercent(100, context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/filter.webp"),
                    fit: BoxFit.cover
                )
            ),
            child: introductionController.loading.value ?
            SizedBox(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              child: const Center(
                child: CupertinoActivityIndicator(
                  color: App.orange,
                ),
              ),
            ) :
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox( height: Get.height * 0.1),
                      Container(
                        width: App.getDeviceWidthPercent(100, context),
                        height: App.getDeviceHeightPercent(20, context),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/filter-background.png"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      const SizedBox(height: 10),
                      _rentalModel(context),
                      const SizedBox(height: 10),
                      _price(context),
                      const SizedBox(height: 10),
                      _brands(context),
                      const SizedBox(height: 50),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: _header(context),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: App.getDeviceWidthPercent(100, context),
                    height: 60,
                    child: _applyButton(context),
                  ),
                )
              ],
            )
        )
      ),
    ));
  }

  _header(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      height: Get.height * 0.1,
      decoration: const BoxDecoration(
          color: App.lightDarkGrey,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
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
                // homeController.clearFilter();
                homeController.initializePrice(introductionController);
                introductionController.clearFilter();
              },
              child: const Icon(Icons.arrow_back,color: Colors.white,size: App.iconSize,)
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                homeController.selectNavBar.value = 0;
                homeController.key.currentState!.openEndDrawer();
              },
              child: SvgPicture.asset("assets/icons/logo.svg",
              width: Get.height * 0.2,
              ),
            ),
            GestureDetector(
                onTap: () {
                  // homeController.clearFilter();
                  homeController.initializePrice(introductionController);
                  introductionController.clearFilter();
                },
                child: SvgPicture.asset("assets/icons/delete.svg",color: Colors.white,)
            ),
          ],
        ),
      ),
    );
  }
  _rentalModel(BuildContext context) {
    return SizedBox(
      width: App.getDeviceWidthPercent(90, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("rental_model").toUpperCase(),
            style: const TextStyle(
                fontSize: App.big,
                color: App.orange,
                fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 10),
          // Row(
          //   children: [
          //     Row(
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             homeController.selectRentalModel.value = 0;
          //           },
          //           child: Container(
          //               width: 20,
          //               height: 20,
          //               decoration: BoxDecoration(
          //                 color: App.grey,
          //                   shape: BoxShape.circle,
          //                   border: Border.all(color: Colors.white,width: 1)
          //               ),
          //               child: Center(
          //                 child: Container(
          //                   width: 8,
          //                   height: 8,
          //                   decoration: BoxDecoration(
          //                       shape: BoxShape.circle,
          //                       color: homeController.selectRentalModel.value == 0 ? App.orange : Colors.transparent
          //                   ),
          //                 ),
          //               )
          //           ),
          //         ),
          //         const SizedBox(width: 8),
          //         Text(App_Localization.of(context).translate("per_day"),
          //           style: const TextStyle(
          //               fontSize: App.medium,
          //               color: Colors.white,
          //               fontWeight: FontWeight.normal
          //           )
          //         ),
          //       ],
          //     ),
          //     const SizedBox(width: 15),
          //     Row(
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             homeController.selectRentalModel.value = 1;
          //           },
          //           child: Container(
          //               width: 20,
          //               height: 20,
          //               decoration: BoxDecoration(
          //                 color: App.grey,
          //                   shape: BoxShape.circle,
          //                   border: Border.all(color: Colors.white,width: 1)
          //               ),
          //               child: Center(
          //                 child: Container(
          //                   width: 8,
          //                   height: 8,
          //                   decoration: BoxDecoration(
          //                       shape: BoxShape.circle,
          //                       color: homeController.selectRentalModel.value != 0 ? App.orange : Colors.transparent
          //                   ),
          //                 ),
          //               )
          //           ),
          //         ),
          //         const SizedBox(width: 8),
          //         Text(App_Localization.of(context).translate("per_hour"),
          //             style: const TextStyle(
          //                 fontSize: App.medium,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.normal
          //             )
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          Row(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      homeController.selectRentalModel.value = 1;
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: App.grey,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white,width: 1)
                        ),
                        child: Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: homeController.selectRentalModel.value == 1 ? App.orange : Colors.transparent
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(App_Localization.of(context).translate("per_day"),
                      style: const TextStyle(
                          fontSize: App.medium,
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                      )
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      homeController.selectRentalModel.value = 0;
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: App.grey,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white,width: 1)
                        ),
                        child: Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: homeController.selectRentalModel.value == 0 ? App.orange : Colors.transparent
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(App_Localization.of(context).translate("per_hour"),
                      style: const TextStyle(
                          fontSize: App.medium,
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                      )
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  _price(BuildContext context) {
    return AnimatedContainer(
      width: App.getDeviceWidthPercent(95, context),
      duration: const Duration(milliseconds: 300),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RangeSlider(
                divisions: 22,
                min: 0,
                max: homeController.maxPrice.value,
                onChanged: (value){
                  homeController.price.value = value;
                  homeController.priceLabel.value = RangeLabels(
                      value.start.toStringAsFixed(2),
                      value.end.toStringAsFixed(2)
                  );
                },
                values: homeController.price.value,
                labels: homeController.priceLabel.value,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                        child: Text("AED ${homeController.priceLabel.value.start}",
                            style: const TextStyle(
                                fontSize: App.small,
                                color: Colors.white,
                                fontWeight: FontWeight.normal
                            )
                        )
                    ),
                    Center(
                        child: Text("AED ${homeController.priceLabel.value.end}",
                            style: const TextStyle(
                                fontSize: App.small,
                                color: Colors.white,
                                fontWeight: FontWeight.normal
                            )
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  _brands(BuildContext context) {
    return SizedBox(
      width: App.getDeviceWidthPercent(90, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("brand"),
            style: const TextStyle(
                fontSize: App.big,
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: App.getDeviceWidthPercent(90, context),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 15,
              children: introductionController.homeData!.data!.brandsWithAll.map((e) =>
                  SizedBox(
                    width: 100,
                    height: 35,
                    child: GestureDetector(
                      onTap: (){
                        ///select multi items
                        // print(e.selected.value);
                        if(e.id == -1){
                          e.selected.value = true;
                          homeController.selectedBrands.clear();
                          introductionController.homeData!.data!.brandsWithAll.first.selected.value = true;
                          for(int i=1 ; i<= introductionController.homeData!.data!.brands.length;i++){
                            introductionController.homeData!.data!.brandsWithAll[i].selected.value = false;
                          }
                        }else{
                          introductionController.homeData!.data!.brandsWithAll.first.selected.value = false;
                          if(e.selected.value){
                            homeController.selectedBrands.remove(e.id);
                            e.selected.value = false;
                          }else{
                            homeController.selectedBrands.add(e.id);
                            e.selected.value = true;
                          }
                        }
                        // print(List<int>.from(homeController.selectedBrands.map((x) => x)).toString());
                      },
                      child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: e.selected.value ? App.orange : App.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                              e.name,textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: App.xSmall,
                                  color: e.selected.value ? App.grey :  Colors.white ,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                        ),
                      )),
                    ),
                  )
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
  _applyButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          width: App.getDeviceWidthPercent(90, context),
          height: 50,
          text: App_Localization.of(context).translate("apply").toUpperCase(),
          onPressed: () {
            print(double.parse(homeController.priceLabel.value.start));
            print(double.parse(homeController.priceLabel.value.end));
              introductionController.filterProduct(3,homeController.selectRentalModel.value,
                homeController.minPrice.value,
                homeController.maxPrice.value,
                homeController.selectedBrands);
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
}