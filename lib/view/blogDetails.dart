import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/blog_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/model/blog.dart';

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
            ///
          }
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: App.grey,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: App.getDeviceWidthPercent(100, context),
                height: App.getDeviceHeightPercent(100, context),
                color: App.primary,
              ),
              blogController.loading.value ?
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
          )
        )
    ));
  }

  header(BuildContext context){
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      height: 70,
      decoration: BoxDecoration(
          color: App.grey,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
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
            Text(App_Localization.of(context).translate("blog_details").toUpperCase(),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: App.getDeviceWidthPercent(90, context),
              child: Text(
                Global.languageCode == "en" ?
                introductionController.blogs!.data!.blog[index].titleEn :
                introductionController.blogs!.data!.blog[index].titleAr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: App.large,
                  color: App.orange,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: App.getDeviceWidthPercent(100, context),
          height: App.getDeviceHeightPercent(25, context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "${API.url}/${introductionController.blogs!.data!.blog[index].cover}"
                  ),
                  fit: BoxFit.cover
              )
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(Global.languageCode == "en" ?
            introductionController.blogs!.data!.blog[index].titleEn :
            introductionController.blogs!.data!.blog[index].titleAr,
            style: const TextStyle(
                color: App.lightWhite,
                fontSize: App.small
            ),
          ),
        )
      ],
    );
  }
}
