import 'package:dealsdry/homepage.dart';
import 'package:dealsdry/otppage.dart';
import 'package:dealsdry/registerpage.dart';
import 'package:dealsdry/server.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepagemodel.dart';

class DioClient {
  @override
  final Dio _dio = Dio(BaseOptions(
      baseUrl: Api.baseurl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60)));
  Options options = Options(
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
  );

  errorMessage(e) {
    if (e.response != null) {
      print("Dio error!");
      print("DATA = ${e.response.data}");
      print("STATUS =${e.response.status}");
      print("HEADERS = ${e.response.headers}");
    } else {
      print("error sending request!");
      print(e.message);
    }
  }

  userlogin({required String phonenumber}) async {
    try {
      final url = "${Api.baseurl}otp";
      _dio.options.headers["Content-Type"] = "application/json";
      Map<String, dynamic> data = {
        "mobileNumber": phonenumber
        //9011470243
        //   9879
      };
      print("loginurl = $url");
      print('data=$data');
      var response = await _dio.post(url, data: data);
      print("response = $response");
      if (response.data["status"]==1) {
        Get.to(OtpPage());
        var data = await response.data["data"]["deviceId"];
        print(data);
        // UserDetailes user = UserDetailes();
        //  user = UserDetailes.fromJson(data);
        return data;
      } else {
        print("error");
      }
    } on DioException catch (e) {
      errorMessage(e);
      print("error");
    }
  }

  Future<void> userloginotp({
    required String otp,
    String? userId,
    String? deviceId,
  }) async {
    try {
      final url = "${Api.baseurl}otp/verification";
      _dio.options.headers["Content-Type"] = "application/json";
      Map<String, dynamic> data = {
        "otp": otp,
        if (userId != null) "userId": userId,
        if (deviceId != null) "deviceId": deviceId,
      };

      print("loginurl = $url");
      print('data = $data');
      final response = await _dio.post(url, data: data);
      print("response = $response");
      if (response.data["status"] == 1) {
        Get.to(() => HomePage());
      } else {
        Get.to(() => Registerpage());
        print("Error: ${response.data["data"]["message"]}");
      }
    } on DioException catch (e) {
      errorMessage(e);
      print("Dio error: $e");
    } catch (e) {
      print("Unexpected error: $e");
    }
  }

  void errormessage(DioException e) {
    print("Error occurred: ${e.message}");
  }

  Registeruser(
      {required String email,
      required String password,
      required String referralCode}) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        Get.showSnackbar(GetSnackBar(
          duration: Duration(seconds: 2),
          messageText: Text(
            "Please fill in all the below fields!",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          padding: EdgeInsets.only(left: 95, top: 10, bottom: 10),
          borderRadius: 20,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          snackStyle: SnackStyle.FLOATING,
        ));
        return null;
      }

      if (email.isEmpty || !isValidEmail(email)) {
        Get.showSnackbar(GetSnackBar(
          duration: Duration(seconds: 2),
          messageText: Text(
            "Please enter a valid email address!",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          padding: EdgeInsets.only(left: 95, top: 10, bottom: 10),
          borderRadius: 20,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          snackStyle: SnackStyle.FLOATING,
        ));
        return null;
      }
      if (password.isEmpty || !isValidPassword(password)) {
        Get.showSnackbar(GetSnackBar(
          duration: Duration(seconds: 2),
          messageText: Center(
            child: Text(
              "Password must be at least 8 characters long! and "
              "must contain one uppercase ans lowercase",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
          padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
          borderRadius: 20,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          snackStyle: SnackStyle.FLOATING,
        ));
        return null;
      }

      final url = "${Api.baseurl}email/referral";
      _dio.options.headers["Content-Type"] = "application/json";
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
        "referralCode": referralCode
      };
      print("url = $url");
      print("data= $data");
      var response = await _dio.post(url, data: data);
      print(response);
      if (response.data["status"] == 1) {
        print("user register successfully completed");
      } else {
        print("failed");
      }
    } on DioException catch (e) {
      errorMessage(e);
      print("register unsuccessfully");
    }
  }

  bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (!email.contains('@')) {
      Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 2),
        messageText: Text(
          "Email must contain @ symbol.",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        padding: EdgeInsets.only(left: 95, top: 10, bottom: 10),
        borderRadius: 20,
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        snackStyle: SnackStyle.FLOATING,
      ));
      return false;
    }
    int atIndex = email.indexOf('@');
    if (!email.substring(atIndex).contains('.')) {
      Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 2),
        messageText: Text(
          "Missing dot (.) after @ symbol.",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        padding: EdgeInsets.only(left: 95, top: 10, bottom: 10),
        borderRadius: 20,
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        snackStyle: SnackStyle.FLOATING,
      ));
      return false;
    }
    return true;
  }

  bool isValidPhoneNumber(String phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  bool isValidPassword(String password) {
    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  Future<List<Homepagemodel>> fetchProducts() async {
    try {
      final url = "${Api.baseurl}home/withoutPrice";
      _dio.options.headers["Content-Type"] = "application/json";
      var response = await _dio.get(url);
      print(url);
      print("response=$response");
      if (response.data["status"] == 1) {
        var data = response.data["data"];
        var productsData = data["products"];
        if (productsData is List) {
          List<Homepagemodel> products = productsData.map((item) {
            return Homepagemodel.fromJson(item as Map<String, dynamic>);
          }).toList();
          return products;
        } else {
          print("Products data is not a list or is null");
          return [];
        }
      } else {
        print("Response status is not successful");
        return [];
      }
    } on DioException catch (e) {
      errorMessage(e);
      print("Error occurred: ${e.message}");
      return [];
    }
  }
}
