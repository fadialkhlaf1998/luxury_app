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
              color: App.primary,
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
          SizedBox(height: Get.height * 0.12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: App.getDeviceWidthPercent(90, context),
                child: const Text("LUXURY BLOGS CAR",
                  style: TextStyle(
                    fontSize: App.large,
                    color: App.orange,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          body(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  body(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: introductionController.blogs!.data!.blog.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,index) {
         return GestureDetector(
           onTap: () {
             Get.to(() => BlogDetails(introductionController.blogs!,index));
           },
           child: Column(
             children: [
               Container(
                 width: App.getDeviceWidthPercent(90, context),
                 height: App.getDeviceHeightPercent(30, context),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(15),
                     image: DecorationImage(
                         image: NetworkImage(
                             "${API.url}/${introductionController.blogs!.data!.blog[index].cover}"
                         ),
                         fit: BoxFit.cover
                     )
                 ),
                 child: Align(
                     alignment: Alignment.bottomCenter,
                     child: Container(
                       width: App.getDeviceWidthPercent(90, context),
                       height: 50,
                       decoration: BoxDecoration(
                           color: App.grey.withOpacity(0.7),
                           borderRadius: const BorderRadius.only(
                               bottomRight: Radius.circular(15),
                               bottomLeft: Radius.circular(15)
                           )
                       ),
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10),
                           child: Text(Global.languageCode == "en" ?
                           introductionController.blogs!.data!.blog[index].titleEn :
                           introductionController.blogs!.data!.blog[index].titleAr,
                             style: const TextStyle(
                                 color: Colors.white,
                                 fontSize: App.medium,
                                 overflow: TextOverflow.ellipsis
                             ),
                           ),
                         ),
                       ),
                     )
                 )
               ),
               const SizedBox(height: 15),
               SizedBox(
                 width: App.getDeviceWidthPercent(90, context),
                 child: Divider(
                   color: App.lightWhite.withOpacity(0.5),
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
