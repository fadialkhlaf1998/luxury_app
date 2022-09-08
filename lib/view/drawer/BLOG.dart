import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/blog_controller.dart';
import 'package:luxury_app/controller/home_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/view/blogDetails.dart';
import 'package:luxury_app/widgets/drawer.dart';


class Blog extends StatelessWidget {
  Blog({Key? key}) : super(key: key);


  BlogController blogController = Get.put(BlogController());
  HomeController homeController = Get.find();
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        key: blogController.key,
        drawer: CustomDrawer(homeController: homeController),
        body: blogController.loading.value ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: App.grey,
          child: Center(
            child: CircularProgressIndicator(color: App.orange),
          ),
        ) :
        Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
            ),
            faq(context),
          ],
        )
    ));
  }

  faq(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // header(context),
          SizedBox(height: 70),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Text("LUXURY BLOGS CAR",
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
          SizedBox(height: 20),
          body(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  header(BuildContext context) {
    return Container(
      width: App.getDeviceWidthPercent(100, context),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/top-nav.png"),
              fit: BoxFit.cover
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                blogController.key.currentState!.openDrawer();
              },
              child: Icon(Icons.menu,size: CommonTextStyle.headerIcons,color: App.orange),
            ),
            GestureDetector(
              onTap: () {
                homeController.selectNavDrawer.value = 0;
                homeController.key.currentState!.openEndDrawer();
              },
              child: Container(
                child: SvgPicture.asset("assets/icons/logo.svg",
                  width: 28,
                  height: 28,
                ),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
  body(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: introductionController.blogs!.data!.blog.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,index) {
         return GestureDetector(
           onTap: () {
             API.checkInternet().then((internet) {
               if(internet) {
                 blogController.loading.value = true;
                 API.getBlogById(introductionController.blogs!.data!.blog[index].id.toString()).then((value) {
                   blogController.loading.value = false;
                   if(value != null){
                     Get.to(() => BlogDetails(index));
                   }
                 });
               }
             });
           },
           child: Column(
             children: [
               Container(
                 width: App.getDeviceWidthPercent(90, context),
                 height: App.getDeviceHeightPercent(30, context),
                 decoration: BoxDecoration(
                     image: DecorationImage(
                         image: NetworkImage(
                             API.url + "/" + introductionController.blogs!.data!.blog[index].cover
                         ),
                         fit: BoxFit.cover
                     )
                 ),
                 child: Padding(
                   padding: const EdgeInsets.only(bottom: 15),
                   child: Align(
                     alignment: Alignment.bottomCenter,
                     child: Text(Global.languageCode == "en" ?
                     introductionController.blogs!.data!.blog[index].titleEn :
                     introductionController.blogs!.data!.blog[index].titleAr,
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: CommonTextStyle.mediumTextStyle
                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 10),
               Container(
                 child: Divider(
                   color: App.field.withOpacity(0.5),
                   thickness: 1,
                   indent: 15,
                   endIndent: 15,
                 ),
               ),
             ],
           ),
         );
        },
      ),
    );
  }
}
