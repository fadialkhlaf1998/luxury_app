import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';

class ContactUsController extends GetxController {

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
  RxBool nameValidate = false.obs;
  RxBool emailValidate = false.obs;
  RxBool phoneValidate = false.obs;
  RxBool loading = false.obs;

  send(BuildContext context,String name,String phone,String email,String message) {
    if(name.isEmpty || email.isEmpty || phone.isEmpty) {
      if(name.isEmpty) {
        nameValidate.value= true;
      } else {
        nameValidate.value= false;
      }
      if(email.isEmpty) {
        emailValidate.value= true;
      }else{
        emailValidate.value= false;
      }
      if(phone.isEmpty) {
        phoneValidate.value= true;
      }else{
        phoneValidate.value= false;
      }
    }
    else {
      API.checkInternet().then((internet) {
        if(internet){
          loading.value = true;
          API.contactUs(name, email, phone, message).then((value) {
            loading.value = false;
            if(value) {
              App.successTopBar(context, App_Localization.of(context).translate("success"));
              clearTextField();
            }else {
              App.successTopBar(context, App_Localization.of(context).translate("something_went_wrong"));
            }
          });
        }
      });
    }
  }

  clearTextField() {
    name.clear();
    email.clear();
    phone.clear();
    message.clear();
    nameValidate = false.obs;
    emailValidate = false.obs;
    phoneValidate = false.obs;
  }
}