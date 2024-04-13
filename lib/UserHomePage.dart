import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_mall_flutter/UserChatPage.dart';
import 'package:shopping_mall_flutter/UserContactPage.dart';
import 'package:shopping_mall_flutter/UserShopPage.dart';
import 'package:shopping_mall_flutter/main.dart';

import 'UserPromotionsPage.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key,}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePage();
}

class _UserHomePage extends State<UserHomePage> {
  late CarouselController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  final List<Widget> imageAddress = [
    Container(
      margin: EdgeInsets.only(left: 10.w),
      color: Colors.blue,
      child: Center(
        child: Text("ad1",style:TextStyle(
          fontSize: 25.w
        )),
      ),
    ),
    Container(
      margin: EdgeInsets.only(left: 10.w),
      color: Colors.indigoAccent,
      child: Center(
        child: Text("ad2",style:TextStyle(
            fontSize: 25.w
        )),
      ),
    ),
    Container(
      margin: EdgeInsets.only(left: 10.w),
      color: Colors.lightBlue,
      child: Center(
        child: Text("ad3",style:TextStyle(
            fontSize: 25.w
        )),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Return false to disable back button
          return false;
        },
        child:ScreenUtilInit(
          minTextAdapt: true,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Home",style: TextStyle(
                color: Colors.indigo
              )),
              toolbarHeight: 65.w,
              backgroundColor:Color.fromRGBO(255, 255, 255, 1.0) ,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right:10.w),
                  child: InkWell(
                    onTap: () {
                      Fluttertoast.showToast(msg: "Share button");
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        shape:  BoxShape.circle,
                        color: Color.fromRGBO(9, 52, 117, 1.0),
                      ),
                      child: const Icon(
                        Icons.star_rate_outlined,
                        // color: Color.fromRGBO(9, 75, 75, 1.0),
                        color: Color.fromRGBO(253, 253, 253, 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right:20.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SelectUserPage()), (route) => false);
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(9, 52, 117, 1.0),
                      ),
                      child: const Icon(
                        Icons.logout,
                        // color: Color.fromRGBO(9, 75, 75, 1.0),
                        color: Color.fromRGBO(253, 253, 253, 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor:Color.fromRGBO(236, 230, 230, 1.0) ,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Color.fromRGBO(236, 230, 230, 1.0) ,
                    child: Center(
                      child: CarouselSlider(
                        carouselController: controller,
                        items: imageAddress,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 2.4.h,
                            autoPlay: true,
                            autoPlayInterval: Duration(milliseconds: 1800),
                            autoPlayAnimationDuration:
                            const Duration(milliseconds: 500)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30.w, 10.w, 25.w, 0),
                      //color: Colors.blue,
                      //const Color.fromRGBO(33, 160, 164, 1.0),
                      height: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height / 1.6.w),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:2,
                            childAspectRatio: MediaQuery.of(context).size.width < 700 ? (1.1):(1.5),
                            mainAxisSpacing: 20.w,
                            crossAxisSpacing: 20.w),
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserShopPage()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [
                                      0.1.w,
                                      0.4.w,
                                      0.6.w,
                                      0.9.w,
                                    ],
                                    colors: const [
                                      Color.fromRGBO(20, 72, 140, 1.0),
                                      Color.fromRGBO(7, 121, 222, 1.0),
                                      Color.fromRGBO(7, 121, 222, 1.0),
                                      Color.fromRGBO(20, 72, 140, 1.0),
                                    ],
                                  ),
                                  //  color: Color.fromRGBO(188, 197, 197, 1.0),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.w),
                                      topLeft: Radius.circular(20.w),
                                      bottomRight: Radius.circular(20.w),
                                      bottomLeft: Radius.circular(20.w))),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Column(
                                children: [
                                  Padding(
                                      padding:
                                      EdgeInsets.only(top: 20.w, bottom: 10.w),
                                      child: Icon(
                                        Icons.shop,
                                        color: Colors.white,
                                        size: 45.h,
                                      )),
                                  Center(
                                      child: Text(
                                        "Shops",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 15.w,color: Colors.white),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserPromotionPage()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [
                                      0.1.w,
                                      0.4.w,
                                      0.6.w,
                                      0.9.w,
                                    ],
                                    colors: const [
                                      Color.fromRGBO(20, 72, 140, 1.0),
                                      Color.fromRGBO(7, 121, 222, 1.0),
                                      Color.fromRGBO(7, 121, 222, 1.0),
                                      Color.fromRGBO(20, 72, 140, 1.0),
                                    ],
                                  ),
                                  //color: Color.fromRGBO(188, 197, 197, 1.0),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.w),
                                      topLeft: Radius.circular(20.w),
                                      bottomRight: Radius.circular(20.w),
                                      bottomLeft: Radius.circular(20.w))),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Column(
                                children: [
                                  Padding(
                                      padding:
                                      EdgeInsets.only(top: 20.w, bottom: 10.w),
                                      child: Icon(
                                        Icons.discount_rounded,
                                        color: Colors.white,
                                        size: 45.h,
                                      )),
                                  Center(
                                      child: Text(
                                        "Promotions",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 15.w,color: Colors.white,),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserContactPage()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  // color: Color.fromRGBO(188, 197, 197, 1.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      stops: [
                                        0.1.w,
                                        0.4.w,
                                        0.6.w,
                                        0.9.w,
                                      ],
                                      colors: const [
                                        Color.fromRGBO(20, 72, 140, 1.0),
                                        Color.fromRGBO(7, 121, 222, 1.0),
                                        Color.fromRGBO(7, 121, 222, 1.0),
                                        Color.fromRGBO(20, 72, 140, 1.0),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w),
                                        topLeft: Radius.circular(20.w),
                                        bottomRight: Radius.circular(20.w),
                                        bottomLeft: Radius.circular(20.w))),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 20.w, bottom: 10.w),
                                      child: Icon(
                                        Icons.perm_contact_cal,
                                        color: Colors.white,
                                        size: 40.h,
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                          "Contact us",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.w,color: Colors.white,),
                                        )),
                                  ],
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserChatPage()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      stops: [
                                        0.1.w,
                                        0.4.w,
                                        0.6.w,
                                        0.9.w,
                                      ],
                                      colors: const [
                                        Color.fromRGBO(20, 72, 140, 1.0),
                                        Color.fromRGBO(7, 121, 222, 1.0),
                                        Color.fromRGBO(7, 121, 222, 1.0),
                                        Color.fromRGBO(20, 72, 140, 1.0),
                                      ],
                                    ),
                                    //color: Color.fromRGBO(188, 197, 197, 1.0),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w),
                                        topLeft: Radius.circular(20.w),
                                        bottomRight: Radius.circular(20.w),
                                        bottomLeft: Radius.circular(20.w))),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 20.w, bottom: 10.w),
                                      child: Icon(
                                        Icons.chat,
                                        color: Colors.white,
                                        size: 40.h,
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                          "Chat with us",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.w,color: Colors.white,),
                                        )),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(flex:1,child: Padding(
                  padding:  EdgeInsets.only(bottom:20.w),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("Copyrights reserved"),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}