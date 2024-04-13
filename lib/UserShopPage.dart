import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserShopPage extends StatefulWidget {
  const UserShopPage({super.key});

  @override
  State<UserShopPage> createState() => _UserShopPage();
}

class _UserShopPage extends State<UserShopPage> {
  late DatabaseReference dbRef2;
  late Query dbQuery;

  @override
  void initState() {
    super.initState();
    dbQuery =  FirebaseDatabase.instance.ref().child('Shops');
  }

  Widget listItem({required Map thisPlayer}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(229, 227, 221, 1.0)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: (0),
                      padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                      backgroundColor: Color.fromRGBO(201, 169, 101, 1.0)),
                  onPressed: () {},
                  child: Container(
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                          child: Text(
                            thisPlayer['name'],
                            style: TextStyle(fontSize: 15.w, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.w),
                          child: Text(
                            thisPlayer['contact'],
                            style: TextStyle(fontSize: 15.w, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.w),
                          child: Text(
                            thisPlayer['job'],
                            style: TextStyle(fontSize: 15.w, color: Colors.black),
                          ),
                        )
                      ]))),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: (0),
                      padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                      backgroundColor: Color.fromRGBO(229, 227, 221, 1.0)),
                  onPressed: () {},
                  child: Text(
                    "Contact",
                    style: TextStyle(fontSize: 15.w, color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Find Shops", style: TextStyle(fontSize: 20.sp)),
        backgroundColor: const Color.fromRGBO(51, 110, 203, 1.0),
        toolbarHeight: 60.w,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, top: 20.w, right: 20.w, bottom: 20.w),
              child: Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.black87)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding:  EdgeInsets.only(left:10.w),
                        child: TextField(
                            style: TextStyle(fontSize: 15.w,color: Colors.black87),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: TextStyle(color: Colors.grey[700]))),
                      ),),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:  EdgeInsets.only(left:10.w),
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.search,color: Colors.black87,size: 25.h,),
                        ),
                      ),),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(bottom: 25.w),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text("No shop was added yet",style: TextStyle(
                    fontSize: 15.w,color: Colors.black
                ),),
              ),
          ),
      ),
    ]));
  }
}
