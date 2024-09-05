import 'package:dealsdry/otppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  DealsdryController _dealsdryController = Get.put(DealsdryController());
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _codecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _obscuretext = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back(result: OtpPage());
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
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
                      fontSize: 35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 20),
                child: Text(
                  "Let's Begin!",
                  style: GoogleFonts.podkova(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, top: 8),
                child: Text(
                  "Plase enter your crendentials to proceed",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40, top: 30),
                child: TextFormField(

                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon:Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.email_outlined,color: Colors.red,size: 17,),
                    ) ,
                      hintText: "Your Email",
                      contentPadding: EdgeInsets.only(left: 10),
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40, top: 17),
                child: TextFormField(
                  controller: _passwordcontroller,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: _obscuretext,
                  decoration: InputDecoration(
                      hintText: "Create Password",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.security,color: Colors.red,size: 17,),
                      ),
                      suffixIcon:IconButton(onPressed: () {
                        setState(() {
                          _obscuretext=!_obscuretext;
                        });
                      },  icon:  Icon(
                        _obscuretext ? Icons.visibility_off : Icons.visibility,color: Colors.grey,
                      ),),
                      contentPadding: EdgeInsets.only(left: 10),
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40, top: 17),
                child: TextFormField(
                  controller: _codecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.room_preferences_outlined,color: Colors.red,size: 17,),
                    ),
                      hintText: "  Referral Code(Optional)",
                      contentPadding: EdgeInsets.only(left: 10),
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 280, top: 140),
                child: GestureDetector(
                  onTap: () {
                    String?email=_emailcontroller.text;
                    String? password= _passwordcontroller.text;

                    _dealsdryController.RegisterUser(
                        email: _emailcontroller.text,
                        password: _passwordcontroller.text,
                        referralCode: _codecontroller.text);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red
                    ),
                    child: Center(
                        child: Icon(Icons.arrow_forward, color: Colors.white,)),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
