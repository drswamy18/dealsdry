import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:dealsdry/controller.dart';
import 'package:dealsdry/splashscreen.dart';
import 'otppage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DealsdryController _dealsdryController = Get.put(DealsdryController());
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _selectedToggleIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back(result: Splashscreen());
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 135, top: 60),
                child: Image.asset(
                  "images/dealsdryicon.jpeg",
                  height: 100,
                  width: 100,
                  filterQuality: FilterQuality.low,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 110, bottom: 15),
                child: Text(
                  "DealsDry",
                  style: GoogleFonts.podkova(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 130),
                child: ToggleSwitch(
                  totalSwitches: 2,
                  initialLabelIndex: _selectedToggleIndex,
                  radiusStyle: true,
                  minHeight: 29,
                  activeBgColor: [Colors.red],
                  labels: ["Phone", "Email"],
                  onToggle: (index) {
                    setState(() {
                      _selectedToggleIndex = index ?? 0;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 20),
                child: Text(
                  "Glad to see you!",
                  style: GoogleFonts.podkova(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, top: 8),
                child: Text(
                  _selectedToggleIndex == 0
                      ? "Please provide your phone number"
                      : "Please provide your email address",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40, top: 30),
                child: _selectedToggleIndex == 0
                    ? TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("+91"),
                          ),
                          hintText: "Phone",
                          contentPadding: EdgeInsets.only(left: 10),
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      )
                    : TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding: EdgeInsets.only(left: 10),
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0, top: 30),
                child: GestureDetector(
                  onTap: () {
                    String phonenumber = _phoneController.text;
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_selectedToggleIndex == 0) {
                        // Handle phone login
                        if (phonenumber.length != 10) {
                          Get.showSnackbar(GetSnackBar(
                            duration: Duration(seconds: 2),
                            messageText: Text(
                              "Enter a valid 10-digit number!",
                              style: GoogleFonts.poppins(
                                  color: Colors.white
                              ),
                            ),
                            padding: EdgeInsets.only(left: 95, top: 10, bottom: 10),
                            borderRadius: 20,
                            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            snackStyle: SnackStyle.FLOATING,
                          ));
                        } else if(phonenumber.length<10){
                          Get.showSnackbar(GetSnackBar(
                            duration: Duration(seconds: 2),
                            messageText: Text(
                              "Enter a valid 10-digit number!",
                              style: GoogleFonts.poppins(
                                  color: Colors.white
                              ),
                            ),
                            padding: EdgeInsets.only(left: 95, top: 10, bottom: 10),
                            borderRadius: 20,
                            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            snackStyle: SnackStyle.FLOATING,
                          ));
                        }else{
                          var data = _dealsdryController.userlogin(
                              phoneNumber: phonenumber);
                          print(data);
                          Future.delayed(Duration(seconds: 1), () {
                            _phoneController.clear();

                          });
                          Get.to(OtpPage(mobile: phonenumber,));
                        }
                      } else {}
                    }
                  },
                  child: Container(
                    height: 55,
                    width: 180,
                    child: Center(
                      child: Text(
                        "Send Code",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
