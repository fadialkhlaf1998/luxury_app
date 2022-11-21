import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/view/product_details.dart';

class SearchTextField extends SearchDelegate<String> {

  IntroductionController introController = Get.find();

  SearchTextField();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty ?
      const Visibility(
        visible: false,
        child: Text('')
      ) : IconButton(
        icon: const Icon(Icons.close, color: Colors.white,size: App.iconSize),
        onPressed: () {
          query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back,size: App.iconSize,color: Colors.white),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
      appBarTheme: const AppBarTheme(
        color: App.primary,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: App.white
      ),
      hintColor: App.lightWhite,
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: App.medium,
          color: App.lightWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    final suggestions = introController.allCarsConst!.data!.cars.where((elm) {
      return elm.slug.toLowerCase().contains(query.toLowerCase());
    });
    return suggestions.isEmpty ?
    Container(
      height: App.getDeviceHeightPercent(100, context),
      width: App.getDeviceWidthPercent(100, context),
      color: App.primary,
      child: Center(
        child: Text(App_Localization.of(context).translate("no_results_found!"),
            style: const TextStyle(
                color: App.lightWhite,
                fontSize: App.small,
                fontWeight: FontWeight.w600
            )
        ),
      ),
    ) :
    Container(
        height: App.getDeviceHeightPercent(100, context),
        width: App.getDeviceWidthPercent(100, context),
        color: App.primary,
        child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                style: ListTileStyle.drawer,
                leading: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                            "${API.url}/${suggestions.elementAt(index).imgs.split(",").first}",
                          ),
                          fit: BoxFit.contain
                      )
                  ),
                ),
                title: Text(suggestions.elementAt(index).slug.replaceAll("-", " "),
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: App.medium,
                    color: App.lightWhite,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),
                onTap: (){
                  // query = suggestions.elementAt(index).slug;
                  print(suggestions.elementAt(index).slug);
                  introController.search(context, suggestions.elementAt(index).slug,index);
                  Get.to(()=>ProductDetails(suggestions.elementAt(index).id));
                },
              ),
            );
          },
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = introController.allCarsConst!.data!.cars.where((elm) {
      return elm.slug.toLowerCase().contains(query.toLowerCase());
    });
    return suggestions.isEmpty ?
    Container(
      height: App.getDeviceHeightPercent(100, context),
      width: App.getDeviceWidthPercent(100, context),
      color: App.primary,
      child: Center(
        child: Text(App_Localization.of(context).translate("no_results_found!"),
            style: const TextStyle(
                color: App.lightWhite,
                fontSize: App.small,
                fontWeight: FontWeight.w600
            )
        ),
      ),
    ) :
    Container(
        height: App.getDeviceHeightPercent(100, context),
        width: App.getDeviceWidthPercent(100, context),
        color: App.primary,
        child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                style: ListTileStyle.drawer,
                leading: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                            "${API.url}/${suggestions.elementAt(index).imgs.split(",").first}",
                          ),
                          fit: BoxFit.contain
                      )
                  ),
                ),
                title: Text(suggestions.elementAt(index).slug.replaceAll("-", " "),
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: App.medium,
                    color: App.lightWhite,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                onTap: (){
                  // query = suggestions.elementAt(index).slug;
                  print(suggestions.elementAt(index).slug);
                  introController.search(context, suggestions.elementAt(index).slug,index);
                  Get.to(()=>ProductDetails(suggestions.elementAt(index).id));
                },
              ),
          );
      },
    )
    );
  }
}