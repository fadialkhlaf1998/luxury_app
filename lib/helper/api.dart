import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:luxury_app/model/about.dart';
import 'package:luxury_app/model/all-cars.dart';
import 'package:luxury_app/model/blog-info.dart';
import 'package:luxury_app/model/blog.dart';
import 'package:luxury_app/model/brands.dart';
import 'package:luxury_app/model/car-info.dart';
import 'package:luxury_app/model/faq.dart';
import 'package:luxury_app/model/home-data.dart';
import 'package:luxury_app/model/terms.dart';

class API {

  static String url = "https://www.luxurycarrental.ae";
  // static String url = "https://new.luxurycarrental.ae";

  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static Future<HomeData?> getHome() async {
    var headers = {
      'accept-language': 'ar'
    };
    var request = http.Request('GET', Uri.parse( url +'/api/home'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      // print('!!!!!!!!!!!!!!!!!!!!!!!1');
      // print(data.length);
      return HomeData.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
    return null;
    }
  }

  static Future<AllCars?> getAllCars() async {
    var headers = {
      'accept-language': 'en'
    };
    var request = http.Request('GET', Uri.parse( url + '/api/getAllCars'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      // print(data);
      return AllCars.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
  }

  static Future<CarInfo?> getCarsById(String id) async {
    var headers = {
      'accept-language': 'en'
    };
    var request = http.Request('GET', Uri.parse( url +'/api/carDetails?id=$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      CarInfo carInfo = CarInfo.fromMap(jsonData);
      // print(carInfo.message);
      // print(carInfo.data!.car!.id);
      return carInfo;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
  }

  static Future<AllCars?> filter(String vehicleType,String rentType,String minPrice,String maxPrice,List<int> brand,String carBody)async{
    var headers = {
      'accept-language': 'en'
    };
    print(List<int>.from(brand.map((x) => x)).toString());
    var request = http.MultipartRequest('POST', Uri.parse(url + '/api/filter'));
    request.fields.addAll({
      'vehicle_type': vehicleType,
      'rent_type': rentType,
      'min_price': minPrice,
      'max_price': maxPrice,
      'brands': List<int>.from(brand.map((x) => x)).toString(),
      'car_body': carBody,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      AllCars allCars =  AllCars.fromMap(jsonData);

      print(allCars.data!.cars.length.toString()+"API");
      return allCars;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static Future<AllCars?> search(String query)async{
    var headers = {
      'accept-language': 'en'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url + '/api/search'));
    request.fields.addAll({
      'key': query
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 ||response.statusCode == 201 ||response.statusCode == 202) {
      var data = await response.stream.bytesToString();
      // print(data);
      var jsonData = json.decode(data);
      return AllCars.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static Future<AllCarsBrands?> getCarsByBrand(int carId) async {
    var headers = {
      'accept-language': 'en'
    };
    var request = http.Request('GET', Uri.parse(url + '/api/carsBrand?id=$carId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      AllCarsBrands allCarsBrands = AllCarsBrands.fromMap(jsonData);
      // print(allBrands.message);
      // print(allBrands.brand.brands!.length);
      return allCarsBrands;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
  }

  static Future<AboutUs?> getAboutUs() async {
    var headers = {
      'accept-language': 'en'
    };
    var request = http.Request('GET', Uri.parse(url + '/api/about'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      // print(data);
      return AboutUs.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  static Future<RentTerms?> getTerms() async {
    var headers = {
      'accept-language': 'en'
    };
    var request = http.Request('GET', Uri.parse(url + '/api/terms'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      // print(data);
      return RentTerms.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  static Future<Faq?> getFAQ() async {
    var headers = {
      'accept-language': 'en'
    };
    var request = http.Request('GET', Uri.parse(url + '/api/faq'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      // print(data);
      return Faq.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  static Future<Blogs?> getBlogs() async {
    var headers = {
      'accept-language': 'en'
    };
    var request = http.Request('GET', Uri.parse(url + '/api/blog'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      // print(data);
      return Blogs.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  static Future<BlogsInfo?> getBlogById(String id) async {
    var headers = {
      'accept-language': 'en'
    };
    var request = http.Request('GET', Uri.parse( url +'/api/blogDetails?id=$id'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      BlogsInfo blogsInfo = BlogsInfo.fromMap(jsonData);
      // print(blogsInfo.message);
      // print(blogsInfo.blogData!.blogInfo!.id);
      return blogsInfo;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
  }

  static Future<bool> contactUs(String name,String email,String phone,String message) async {
   try{
     var headers = {
       'accept-language': 'en'
     };
     var request = http.MultipartRequest('POST', Uri.parse(url + '/api/subscribe'));
     request.fields.addAll({
       'name': name,
       'email': email,
       'phone': phone,
       'message': message
     });
     request.headers.addAll(headers);
     http.StreamedResponse response = await request.send();
     if(response.statusCode == 200) {
       var data = await response.stream.bytesToString();
       // print(data);
       var newData = jsonDecode(data);
       print(newData);
       if(newData["code"] == 1){
         return true;
       }else{
         return false;
       }
     }else {
       return false;
     }
   }catch(err){
     return false;
   }
  }

  static Future<BookResult> book (String rental_type,String payment_method,String car_id,
      String has_babyseat, String has_driver , String from_date, String to_date ,
      String customer_name,String customer_phone,String customer_email)async{
    var headers = {
      'accept-language': 'en'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url + '/api/book'));
    request.fields.addAll({
      'rental_type': rental_type,
      'payment_method': payment_method,
      'car_id': car_id,
      'has_babyseat': has_babyseat,
      'has_driver': has_driver,
      'from_date': from_date,
      'to_date': to_date,
      'customer_name': customer_name,
      'customer_phone': customer_phone,
      'customer_email': customer_email
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201 ||response.statusCode == 202) {
      var data = await response.stream.bytesToString();
      print(data);
      var newData = jsonDecode(data);
      // print(newData);
      if(newData["code"] == 1){
        return BookResult.fromJson(newData["data"]);
      }else{
        return BookResult(rentalNumber: -1,totalPrice: -1);
      }
    }
    else {
    print(response.reasonPhrase);
    return BookResult(rentalNumber: -1,totalPrice: -1);
    }
  }

  static Future<bool> bookState(String rental_number , String invoice_id)async{
    var headers = {
      'accept-language': 'en'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url + '/api/bookState'));
    request.fields.addAll({
      'rental_number': rental_number,
      'invoice_id': invoice_id
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      // print(data);
      var newData = jsonDecode(data);
      // print(newData);
      if(newData["code"] == 1){
        return true;
      }else{
       return false;
      }
    }
    else {
    print(response.reasonPhrase);
    return false;
    }

  }
}

class BookResult {
  BookResult({
    required this.rentalNumber,
    required this.totalPrice,
  });

  int rentalNumber;
  double totalPrice;

  factory BookResult.fromJson(Map<String, dynamic> json) => BookResult(
    rentalNumber:  json["rental_number"],
    totalPrice:  double.parse(json["total_price"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "rental_number": rentalNumber == null ? null : rentalNumber,
    "total_price": totalPrice == null ? null : totalPrice,
  };
}