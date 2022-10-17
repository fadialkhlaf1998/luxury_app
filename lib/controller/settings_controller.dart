import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {

  var selectValue = 0.obs;
  String? languageValue = "non";

  List languages = [
    {
      "name":"English",
      "id":"en"},
    {
      "name":"Arabic",
      "id":"ar"}
  ].obs;

  void openMap() async {
    String googleUrl = 'https://goo.gl/maps/jXEstan2qA8kfdxF9';
    await launchUrl(Uri.parse(googleUrl));
  }

}