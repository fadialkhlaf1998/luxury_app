import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:luxury_app/app_localization.dart';
import 'package:luxury_app/helper/api.dart';
import 'package:luxury_app/helper/app.dart';
import 'package:luxury_app/widgets/custom_button.dart';

class PaymentController extends GetxController {
  String result_id = "";
  int rent_number = -1;
  Map<String, dynamic>? paymentIntentData;
  String secrit = "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";
  Future<void> makePayment(
      {required BuildContext context,required String amount, required String currency,required int newRentNumber}) async {
    try {
      rent_number = newRentNumber;
      paymentIntentData = await createPaymentIntent(context,amount, currency);
      if (paymentIntentData != null) {
        print('Init Payment Sheet Successfully');
       // var result = await Stripe.instance.initPaymentSheet(
       //      paymentSheetParameters: SetupPaymentSheetParameters(
       //        applePay: PaymentSheetApplePay(merchantCountryCode: "+92"),
       //        googlePay: PaymentSheetGooglePay(currencyCode: "UAD",merchantCountryCode: '+92',testEnv: true),
       //        style: ThemeMode.dark,
       //        merchantDisplayName: 'Prospects',
       //        customerId: paymentIntentData!['customer'],
       //        paymentIntentClientSecret: paymentIntentData!['client_secret'],
       //        customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
       //      ));
       //  await displayPaymentSheet();
      }else{

      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  // displayPaymentSheet() async {
  //   try {
  //     print('---------------------');
  //     await Stripe.instance.presentPaymentSheet();
  //     print('---------------------');
  //   } on Exception catch (e) {
  //     if (e is StripeException) {
  //       print("Error from Stripe: ${e.error.localizedMessage}");
  //     } else {
  //       print("Unforeseen error: ${e}");
  //     }
  //   } catch (e) {
  //     print("exception:$e");
  //   }
  // }
  createPaymentIntent(BuildContext context,String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print('Begin Api');
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer '+secrit,
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(response.body);
      var data = json.decode(response.body);
      print('*****************');
      print(data["id"]);
      result_id = data["id"];
      addState(rent_number.toString(), data["id"]);
      return data;
    } catch (err) {
      confirmReservation(context);
      print('----------------------');
      print('err charging user: ${err.toString()}');
    }
  }
  addState(String rental_number, String invoice_id)async{
    bool succ = await API.bookState(rental_number, invoice_id);
    if(succ){
      return true;
    }else{
      return addState(rental_number,invoice_id);
    }
  }
  calculateAmount(String amount) {
    try{
      print('');
      // final a = ((double.parse(amount)) * 100).toInt();
      final a = ((double.parse("2.00")) * 100).toInt();
      print("amount"+a.toString());
      return a.toString();
    }catch(e) {
      // print('catttttttttttttttttttttttttttch');
      print(e);
    }
  }
  confirmReservation(BuildContext context) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                backgroundColor: Colors.transparent,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/close.svg",
                        width: Get.width,
                        height: 100,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                      Text(App_Localization.of(context).translate("error_payment_msg"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: App.small,
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 30,
                        child: Divider(
                          color: App.lightWhite,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SvgPicture.asset("assets/icons/check.svg",
                        width: Get.width,
                        height: 100,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 20,),
                      Text(App_Localization.of(context).translate("reservation_confirmed"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: App.small,
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(App_Localization.of(context).translate("rental_number"),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: App.small,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(" $rent_number",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: App.small,
                                color: App.orange,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                          width: App.getDeviceWidthPercent(50, context),
                          height: 45,
                          text: App_Localization.of(context).translate("close").toUpperCase(),
                          onPressed: () {
                            Get.back();
                            Get.back();
                          },
                          color: App.orange,
                          borderRadius: 8,
                          textStyle: const TextStyle(
                              fontSize: App.medium,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          )
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.forward) {
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}