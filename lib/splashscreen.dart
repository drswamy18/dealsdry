import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1500),() {
      Get.to(LoginScreen());
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            "images/splashscreen.jpg",
            height: 500,
            width: 500,
          ),
          Image.asset(
            "images/dealsdryicon.jpeg",
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "DealsDry",
            style: GoogleFonts.podkova(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          )
        ],
      ),
    );
  }
}
