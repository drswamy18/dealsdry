import 'dart:async';

import 'package:dealsdry/controller.dart';
import 'package:dealsdry/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  // final String mobile;
  const OtpPage({
    super.key,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formkey = GlobalKey<FormState>();
  DealsdryController _dealsdryController = Get.put(DealsdryController());
  TextEditingController _otpcontroller = TextEditingController();
  String otp = '';
  Timer? _timer;
  int _countDown = 120;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _otpcontroller.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          _timer?.cancel();
          canResend = true;
        }
      });
    });
  }

  String get _formattedTime {
    final minutes = (_countDown / 60).floor();
    final seconds = _countDown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _resendotp() {
    if (canResend) {
      setState(() {
        _countDown = 120;
        canResend = false;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinPut = PinTheme(
        width: 45,
        height: 40,
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black)));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back(result: LoginScreen());
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formkey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80.0, top: 90),
                  child: Image.asset(
                    "images/otpimage.jpg",
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 89.0, top: 20),
                  child: Text(
                    "OTP Verification",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 33,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 89.0, top: 10),
                  child: Text(
                    "We have sent a unique OTP number",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 89.0,
                  ),
                  child: Text(
                    "to your mobile number +91 9008010415",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Container(
                    child: Pinput(
                      controller: _otpcontroller,
                      length: 4,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: defaultPinPut,
                      focusedPinTheme: defaultPinPut.copyWith(
                          decoration: defaultPinPut.decoration!.copyWith(
                              border:
                                  Border.all(width: 2, color: Colors.red!))),
                      onCompleted: (value) {
                        _dealsdryController.userloginotp(otp: _otpcontroller.text);
                      },
                    ),
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          '$_formattedTime',
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      canResend
                          ? InkWell(
                              onTap: () {
                                _resendotp();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 80),
                                child: Text(
                                  "SEND AGAIN",
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                          : Padding(
                              padding: const EdgeInsets.only(right: 80),
                              child: Text(
                                "SEND AGAIN",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ],
                  ),
                ),

              ]),
        )));
  }
}
