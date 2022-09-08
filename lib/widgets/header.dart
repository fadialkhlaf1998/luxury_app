import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/helper/app.dart';


class Header extends StatelessWidget{

  final HomeController homeController;
  final Callback onTap;
  final Widget? child;

  Header({
    required this.homeController,
    required this.onTap,
    // required this.key,
    this.child,
});

  @override
  Widget build(BuildContext context) {
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
              onTap: onTap,
              child: Icon(Icons.menu,size: CommonTextStyle.headerIcons,color: App.orange),
            ),
            SizedBox(width: 15),
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
            child!
          ],
        ),
      ),
    );
  }


}