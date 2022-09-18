import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:luxury_app/helper/api.dart';

class PaymentController extends GetxController {
  String result_id = "";
  int rent_number = -1;
  Map<String, dynamic>? paymentIntentData;
  String secrit = "sk_test_51LWbmmAcwyDDMKEjxgxy53HBNi44DWy9nZ756qgO624uomQ6pm7D1odNvMzqQ57MuEBdczmMcuWyt4CtcVJ1Dur000dsVfoOgF";
  Future<void> makePayment(
      {required String amount, required String currency,required int newRentNumber}) async {
    try {
      rent_number = newRentNumber;
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        print('Init Payment Sheet Successfully');
       var result = await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              applePay: PaymentSheetApplePay(merchantCountryCode: "AE"),
              googlePay: PaymentSheetGooglePay(currencyCode: "UAD",merchantCountryCode: 'AE',testEnv: true),
              // style: ThemeMode.dark,
              merchantDisplayName: 'Prospects',
              customerId: paymentIntentData!['customer'],
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            ));

        await displayPaymentSheet();
      }else{
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      print('---------------------');
      await Stripe.instance.presentPaymentSheet();
      print('---------------------');
      // Get.snackbar('Payment', 'Payment Successful',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //     margin: const EdgeInsets.all(10),
      //     duration: const Duration(seconds: 2));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
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
      // log(response.body);
      var data = json.decode(response.body);
      print('*****************');
      print(data["id"]);
      result_id = data["id"];
      addState(rent_number.toString(), data["id"]);
      return data;
    } catch (err) {
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
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}