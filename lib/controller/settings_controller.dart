import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {

  RxInt openLang = (-1).obs;
  RxInt openContact = (-1).obs;

  void openMap() async {
    String googleUrl = 'https://goo.gl/maps/jXEstan2qA8kfdxF9';
    await launchUrl(Uri.parse(googleUrl));
  }

}