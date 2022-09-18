import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/controller/blog_controller.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/helper/global.dart';
import 'package:luxury_app/view/blogDetails.dart';
import 'package:luxury_app/widgets/drawer.dart';

class Blog extends StatelessWidget {
  Blog({Key? key}) : super(key: key);

  BlogController blogController = Get.put(BlogController());
  IntroductionController introductionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: blogController.key,
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            Container(
              width: App.getDeviceWidthPercent(100, context),
              height: App.getDeviceHeightPercent(100, context),
              color: App.darkGrey,
            ),
            blog(context),
          ],
        )
    );
  }

  blog(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 85),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: App.getDeviceWidthPercent(90, context),
                child: Text("LUXURY BLOGS CAR",
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
          SizedBox(height: 20),
          body(context),
          SizedBox(height: 20),
        ],
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
             Get.to(() => BlogDetails(introductionController.blogs!,index));
           },
           child: Column(
             children: [
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
                 child: Padding(
                   padding: const EdgeInsets.only(bottom: 15),
                   child: Align(
                     alignment: Alignment.bottomCenter,
                     child: Text(Global.languageCode == "en" ?
                     introductionController.blogs!.data!.blog[index].titleEn :
                     introductionController.blogs!.data!.blog[index].titleAr,
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: CommonTextStyle.smallTextStyle
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
