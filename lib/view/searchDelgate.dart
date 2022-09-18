import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/controller/introduction_controller.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';



class SearchTextField extends SearchDelegate<String> {

  IntroductionController introController;

  SearchTextField({required this.introController});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty ?
      const Visibility(
        child: Text(''),
        visible: false
      ) : IconButton(
        icon: const Icon(Icons.close, color: App.orange,size: 23),
        onPressed: () {
          query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back,size: 23,color: App.field),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
      appBarTheme: const AppBarTheme(
        color: App.darkGrey,
        elevation: 0,
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: App.orange
      ),
      hintColor: App.field,
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: CommonTextStyle.mediumTextStyle,
          color: App.field,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    final suggestions = introController.allCars!.data!.cars.where((elm) {
      return elm.slug.toLowerCase().contains(query.toLowerCase());
    });
    return suggestions.isEmpty ?
    Container(
        height: App.getDeviceHeightPercent(100, context),
        width: App.getDeviceWidthPercent(100, context),
        color: App.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(App_Localization.of(context).translate("no_results_matched"),
              style: const TextStyle(
                fontSize: CommonTextStyle.mediumTextStyle,
                color: App.orange,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        )
    ) :
    Container(
        height: App.getDeviceHeightPercent(100, context),
        width: App.getDeviceWidthPercent(100, context),
        color: App.grey,
        child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: (){
                        query = suggestions.elementAt(index).slug;
                        introController.search(context, query,index);
                      },
                      onDoubleTap: () {
                        introController.search(context, query,index);
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            API.url + "/" + suggestions.elementAt(index).imgs.split(",").first,
                                          ),
                                          fit: BoxFit.contain
                                      )
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 4,
                                child: Text(suggestions.elementAt(index).slug,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: CommonTextStyle.smallTextStyle,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = introController.allCars!.data!.cars.where((elm) {
      return elm.slug.toLowerCase().contains(query.toLowerCase());
    });
    return suggestions.isEmpty ?
        Container(
          height: App.getDeviceHeightPercent(100, context),
          width: App.getDeviceWidthPercent(100, context),
          color: App.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("no_results_matched"),
                style: const TextStyle(
                  fontSize: CommonTextStyle.mediumTextStyle,
                  color: App.orange,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          )
        ) :
      Container(
          height: App.getDeviceHeightPercent(100, context),
          width: App.getDeviceWidthPercent(100, context),
          color: App.grey,
          child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (BuildContext context, int index) {
           return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    query = suggestions.elementAt(index).slug;
                    introController.search(context, query,index);
                  },
                  onDoubleTap: () {
                    introController.search(context, query,index);
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        API.url + "/" + suggestions.elementAt(index).imgs.split(",").first,
                                      ),
                                      fit: BoxFit.contain
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Text(suggestions.elementAt(index).slug,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          );
        },
      )
    );
  }
}