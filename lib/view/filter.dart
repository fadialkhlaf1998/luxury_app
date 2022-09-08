import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/widgets/container_with_image.dart';
import 'package:luxury_app/widgets/custom_button.dart';

class Filter extends StatelessWidget {

  Filter();

  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Container(
          width: App.getDeviceWidthPercent(100, context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/filter-bg.webp"),
                  fit: BoxFit.cover
              )
          ),
          child: introductionController.loading.value ?
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.darkGrey,
                child: Center(
                  child: CircularProgressIndicator(

                    color: App.orange,
                  ),
                ),
              ) :
          SingleChildScrollView(
            child: Column(
              children: [
                ///header
                _header(context),
                ///Image
                ContainerWithImage(
                    width: App.getDeviceWidthPercent(100, context),
                    height: App.getDeviceHeightPercent(25, context),
                    image: "assets/images/ad.webp",
                    option: 1
                ),
                const SizedBox(height: 15),
                ///Rental Model
                _rentalModel(context),
                const SizedBox(height: 20),
                ///Price,
                _price(context),
                const SizedBox(height: 25),
                ///Brands
                _brands(context),
                const SizedBox(height: 40),
                Container(
                  width: App.getDeviceWidthPercent(90, context),
                  child: _applyClearButtos(context),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              homeController.clearFilter();
              introductionController.clearFilter();
              introductionController.homeData!.data!.brandsWithAll.first.selected.value = true;
              for(int i=1 ; i< introductionController.homeData!.data!.brandsWithAll.length;i++){
                introductionController.homeData!.data!.brandsWithAll[i].selected.value = false;
              }
            },
            child: ContainerWithImage(
                width: 30,
                height: 30,
                image: Global.languageCode == "en" ?
                "assets/icons/back-icon.svg" :
                "assets/icons/back-icon_arabic.svg",
                option: 0
            ),
          ),
        ],
      ),
    );
  }
  _rentalModel(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("rental_model"),
            style: CommonTextStyle.textStyleForLargeWhiteBold,
          ),
          const SizedBox(height: 15),
          _applyClearButtos(context),
          const SizedBox(height: 15),
          Row(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      homeController.selectRentalModel.value = 0;
                    },
                    child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white,width: 2)
                        ),
                        child: Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: homeController.selectRentalModel.value == 0 ? Colors.white : Colors.transparent
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(App_Localization.of(context).translate("per_day"),
                    style: CommonTextStyle.textStyleForMediumWhiteNormal,
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      homeController.selectRentalModel.value = 1;
                    },
                    child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white,width: 2)
                        ),
                        child: Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: homeController.selectRentalModel.value != 0 ? Colors.white : Colors.transparent
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(App_Localization.of(context).translate("per_hour"),
                    style: CommonTextStyle.textStyleForMediumWhiteNormal,
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
                max: 2200,
                onChanged: (value){
                  homeController.minPrice.value = value.start;
                  homeController.maxPrice.value = value.end;
                  homeController.price.value = value;
                  homeController.priceLabel.value = RangeLabels("AED "+value.start.toStringAsFixed(2), "AED "+value.end.toStringAsFixed(2));
                },
                values: homeController.price.value,
                labels: homeController.priceLabel.value,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const[
                    Center(
                        child: Text("0 AED", style: CommonTextStyle.textStyleForMediumWhiteNormal)
                    ),
                    Center(
                        child: Text("2200 AED", style: CommonTextStyle.textStyleForMediumWhiteNormal)
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
    return Container(
      width: App.getDeviceWidthPercent(90, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("brands").toUpperCase(),
            style: CommonTextStyle.textStyleForLargeWhiteBold,
          ),
          const SizedBox(height: 15),
          Container(
            width: App.getDeviceWidthPercent(90, context),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 15,
              children: introductionController.homeData!.data!.brandsWithAll.map((e) =>
                  Container(
                    width: 100,
                    height: 35,
                    child: GestureDetector(
                      onTap: (){
                        ///select multi items
                        print(e.selected.value);
                        if(e.id == -1){
                          e.selected.value = true;
                          homeController.selectedBrands.clear();

                          for(int i=1 ; i< introductionController.homeData!.data!.brands.length;i++){
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
                        print(List<int>.from(homeController.selectedBrands.map((x) => x)).toString());
                      },
                      child: Obx(() => Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: e.selected.value?Colors.white:App.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                              e.name,textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  color: e.selected.value ? App.grey :  Colors.white ,
                                  fontWeight: FontWeight.w500
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
  _applyClearButtos(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(
            child: Container(
              height: 45,
              width: App.getDeviceWidthPercent(40, context),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: App.grey,
                  onPrimary:  App.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: FittedBox(
                    child: Row(
                      children: [
                        Icon(Icons.delete,color: App.orange),
                        Text(App_Localization.of(context).translate("clear"),
                            style: TextStyle(
                                fontSize: CommonTextStyle.bigTextStyle,
                                color: Colors.white,
                                fontWeight: FontWeight.normal
                            )
                        ),
                      ],
                    )
                ),
                onPressed: () {
                  homeController.clearFilter();
                  introductionController.clearFilter();
                  introductionController.homeData!.data!.brandsWithAll.first.selected.value = true;
                  for(int i=1 ; i< introductionController.homeData!.data!.brandsWithAll.length;i++){
                    introductionController.homeData!.data!.brandsWithAll[i].selected.value = false;
                  }
                },
              ),
            ),
          ),
        ),
        CustomButton(
          width: App.getDeviceWidthPercent(40, context),
          height: 45,
          text: App_Localization.of(context).translate("apply"),
          onPressed: () {
            ///apply
            introductionController.filterProduct(3,homeController.selectRentalModel.value,
                homeController.minPrice.value,homeController.maxPrice.value,homeController.selectedBrands);
          },
          color: App.orange,
          borderRadius: 10,
          textStyle: CommonTextStyle.textStyleForBigWhiteNormal,
        ),
      ],
    );
  }
}