import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealsdry/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DealsdryController _dealsdryController = Get.put(DealsdryController());
  TextEditingController _searchcontroller = TextEditingController();
  List Images = [
    "images/homepage1.jpg",
    "images/homepage2.jpg",
    "images/homepage3.jpg"
  ];

  @override
  void initState() {
    initSharedpreferences();
    _dealsdryController;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _dealsdryController.dispose;
    // TODO: implement dispose
    super.dispose();
  }

  void initSharedpreferences() async {
    _dealsdryController.fetchproducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                      hintText: "Search here",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              Icon(Icons.search),
              SizedBox(
                width: 10,
              )
            ],
          ),
          height: 35,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Divider(
            thickness: 1,
            height: 4,
          ),
        CarouselSlider.builder(
            itemCount:Images.length,
            itemBuilder: (context, index, realIndex) {
             return Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 250,
                  width: 380,
                  child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(15),
                      child: Image.asset(Images[index],)),
                ),
              );
            },
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1,
            )
        ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 115,
            width: 260,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "KYC Pending",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You need to provide the required\n documents for your account activation. ",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Click here",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.mobile_screen_share,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Mobile"),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.laptop,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Laptop"),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.redAccent,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Camera"),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("LED"),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Row(
                      children: [
                        Text(
                          "EXCLUSIVE FOR YOU",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 180,
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  CarouselSlider.builder(
                      itemCount: 10,
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 40, top: 25),
                          child: Container(
                            // height: 220,
                            width: 120,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                        );
                      },
                      options:
                          CarouselOptions(height: 220, viewportFraction: 0.5))
                ],
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _currentPage,
        selectedItemColor: Colors.redAccent,
        showUnselectedLabels: true,
        unselectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.black,
        selectedLabelStyle: GoogleFonts.poppins(color: Colors.yellow[800]),
        // onTap: (index) {
        //   setState(() {
        //     _currentPage = index;
        //   });
        // },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'category'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'deals'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          isExtended: true,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Chat",
                style: GoogleFonts.poppins(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
