import 'package:flutter/material.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/widgets/text_app.dart';


class ImageAndText extends StatelessWidget {
  final Widget child1;
  final String text;
  final TextStyle textStyle;

  ImageAndText({
    required this.child1,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child1,
        SizedBox(width: 5),
        TextApp(text: App_Localization.of(context).translate(text),
            textStyle: textStyle
        ),
      ],
    );
  }
}