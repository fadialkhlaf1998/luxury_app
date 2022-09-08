import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  RxBool loading = false.obs;

}