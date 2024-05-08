import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_mall_flutter/AdminShowQrPage.dart';

import 'AdminHome.dart';
import 'AdminShopsSelectPage.dart';

class AdminEditShopsPage extends StatefulWidget {
  final String shopname;
  final String floorNum;
  final String numberLeft;
  final String numberRight;
  final String description;
  final String qr;
  const AdminEditShopsPage({super.key, required this.shopname, required this.floorNum, required this.numberLeft, required this.numberRight, required this.qr, required this.description});

  @override
  State<StatefulWidget> createState() => _AdminEditShopsPage();
}

class _AdminEditShopsPage extends State<AdminEditShopsPage> {
  late DatabaseReference dbRef1;
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopDescriptionController = TextEditingController();
  TextEditingController shopFloorNumberController = TextEditingController();
  TextEditingController shopNumberFromRightController = TextEditingController();
  TextEditingController shopNumberFromLeftController = TextEditingController();


  @override
  void initState() {
    super.initState();
    shopDescriptionController = TextEditingController(text: widget.description);
     shopFloorNumberController = TextEditingController(text: widget.floorNum);
     shopNumberFromRightController = TextEditingController(text: widget.numberRight);
     shopNumberFromLeftController = TextEditingController(text: widget.numberLeft);
    dbRef1 = FirebaseDatabase.instance.ref().child('shops');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.shopname,
            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromRGBO(82, 131, 210, 1.0),
        toolbarHeight: 55.w,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
            ),
          ),
          Expanded(
            flex: 19,
            child: Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.w, left: 30.w),
                      child: Text(
                        "Floor number:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 2.w, left: 30.w, right: 30.w),
                      child: TextField(
                        controller: shopFloorNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(157, 173, 203, 1.0)),
                            hintText: "eg:- In which floor the shop is found"),
                        style:
                        (TextStyle(color: Colors.indigo, fontSize: 15.w)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.w, left: 30.w),
                      child: Text(
                        "Shop number from right:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 2.w, left: 30.w, right: 30.w),
                      child: TextField(
                        controller: shopNumberFromRightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(157, 173, 203, 1.0)),
                            hintText: "eg:- Mention the number from elevator"),
                        style:
                        (TextStyle(color: Colors.indigo, fontSize: 15.w)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.w, left: 30.w),
                      child: Text(
                        "Shop number from left:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 2.w, left: 30.w, right: 30.w),
                      child: TextField(
                        controller: shopNumberFromLeftController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(157, 173, 203, 1.0)),
                            hintText: "eg:- Mention the number from elevator"),
                        style:
                        (TextStyle(color: Colors.indigo, fontSize: 15.w)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.w, left: 30.w),
                      child: Text(
                        "Description :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 2.w, left: 30.w, right: 30.w),
                      child: TextField(
                        maxLength: 80,
                        controller: shopDescriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(157, 173, 203, 1.0)),
                            hintText:
                            "eg:- Give a brief description about the shop."),
                        style:
                        (TextStyle(color: Colors.indigo, fontSize: 15.w)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                  backgroundColor: const Color.fromRGBO(82, 131, 210, 1.0),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminHomePage(),
                      ),
                          (route) => false);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 15.w),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  // backgroundColor: const Color.fromRGBO(23, 64, 124, 1.0),
                  backgroundColor: const Color.fromRGBO(34, 54, 86, 1.0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
                onPressed: () {
                  Map<String,String> shops={
                    "name":(widget.shopname).toString(),
                    "floor_number":(shopFloorNumberController.text.trim()).toString(),
                    "from_right":(shopNumberFromRightController.text.trim()).toString(),
                    "from_left":(shopNumberFromLeftController.text.trim()).toString(),
                    "description":(shopDescriptionController.text.trim()).toString(),
                    "qr":widget.qr
                  };
                  dbRef1.child(widget.shopname).update(shops);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminHomePage()),
                          (route) => false);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                  child: Text(
                    "Edit Shop",
                    style: TextStyle(color: Colors.white, fontSize: 15.w),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
