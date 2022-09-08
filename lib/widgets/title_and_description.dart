import 'package:flutter/material.dart';
import 'package:luxury_app/helper/app.dart';

class TitleAndDescription extends StatelessWidget {
  final String title;
  final String description;


  TitleAndDescription({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: App.getDeviceWidthPercent(90, context),
          height: 45,
          decoration: const BoxDecoration(
              color: App.orange,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: CommonTextStyle.mediumTextStyle,
                    letterSpacing: 1,
                    height: 1.3,
                  ),),
              ],
            ),
          ),
        ),
        Container(
          width: App.getDeviceWidthPercent(90, context),
          decoration: BoxDecoration(
              color: App.grey,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(description,
                  style: TextStyle(
                      fontSize: CommonTextStyle.smallTextStyle,
                      color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}