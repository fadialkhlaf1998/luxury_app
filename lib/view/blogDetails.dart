import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/blog_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/blog.dart';
import 'package:luxury_app/widgets/container_with_image.dart';

class BlogDetails extends StatelessWidget {

  Blogs blogs;
  int index;
  BlogController blogController = Get.find();
  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();

  BlogDetails(this.blogs,this.index) {
    API.checkInternet().then((internet) {
      if(internet) {
        blogController.loading.value = true;
        API.getBlogById(blogs.data!.blog[index].id.toString()).then((value) {
          blogController.loading.value = false;
          if(value != null){
            Get.to(() => BlogDetails(blogs,index));
          }
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
            ),
            blogController.loading.value ?
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: App.darkGrey,
              child: Center(
                child: CupertinoActivityIndicator(color: App.orange),
              ),
            ) :
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    SizedBox(height: 15),
                    _body(context),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        )
    ));
  }


  _header(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(100, context),
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
  _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: App.getDeviceWidthPercent(100, context),
          child: Text(
            Global.languageCode == "en" ?
            introductionController.blogs!.data!.blog[index].titleEn :
            introductionController.blogs!.data!.blog[index].titleAr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: CommonTextStyle.xlargeTextStyle,
              color: App.orange,
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(30, context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      API.url + "/" + introductionController.blogs!.data!.blog[index].cover
                  ),
                  fit: BoxFit.cover
              )
          ),
        ),
        SizedBox(height: 20),
        Padding(
         padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(Global.languageCode == "en" ?
          introductionController.blogs!.data!.blog[index].titleEn :
          introductionController.blogs!.data!.blog[index].titleAr,
            style: TextStyle(
                color: Colors.white,
                fontSize: CommonTextStyle.smallTextStyle
            ),
          ),
        )
      ],
    );
  }
}
