import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_mall_flutter/AdminShowQrPage.dart';

import 'AdminHome.dart';

class AdminAddShopsPage extends StatefulWidget {
  const AdminAddShopsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AdminAddShopsPage();
}

class _AdminAddShopsPage extends State<AdminAddShopsPage> {
  late DatabaseReference dbRef1;
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopDescriptionController = TextEditingController();
  TextEditingController shopFloorNumberController = TextEditingController();
  TextEditingController shopNumberFromRightController = TextEditingController();
  TextEditingController shopNumberFromLeftController = TextEditingController();
  String image_url = 'h';

  File? image;

  @override
  void initState() {
    super.initState();
    dbRef1 = FirebaseDatabase.instance.ref().child('shops');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Add shops",
            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.edit_note_rounded,
                size: 30.w,
                color: Colors.white,
              ),
            ),
          )
        ],
        backgroundColor: const Color.fromRGBO(82, 131, 210, 1.0),
        toolbarHeight: 55.w,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.purpleAccent,
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
                      padding: EdgeInsets.only(left: 30.w),
                      child: Text(
                        "Shop name:",
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
                        controller: shopNameController,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(157, 173, 203, 1.0)),
                            hintText: "eg:- Pizza bay"),
                        style:
                            (TextStyle(color: Colors.indigo, fontSize: 15.w)),
                      ),
                    ),
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
                  /*
                  if(shopNameController.text.trim() == ""){

                  }else if(shopFloorNumberController.text.trim()==""){

                  }else if(shopNumberFromRightController.text.trim()==""){

                  }else if(shopNumberFromLeftController.text.trim()==""){

                  }else if(shopDescriptionController.text.trim()==""){

                  }else{

                    Map<String,String> addShop={
                      "shop_name":shopNameController.text.trim(),
                      "description":shopDescriptionController.text.trim(),
                      "floor_number":shopFloorNumberController.text.trim(),
                      "number_from_right":shopNumberFromRightController.text.trim(),
                      "number_from_left":shopNumberFromLeftController.text.trim(),
                      "qr":""
                    };
                  }

                   */
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminShowQrPage(
                          shopName: shopNameController.text.trim(),
                        description: shopDescriptionController.text.trim(),
                        floorNumber: shopFloorNumberController.text.trim(),
                        shopsFromLeft: shopNumberFromLeftController.text.trim(),
                        shopsFromRight: shopNumberFromRightController.text.trim(),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                  child: Text(
                    "Add Shop",
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
