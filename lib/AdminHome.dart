import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_mall_flutter/AdminAddPromotions.dart';
import 'package:shopping_mall_flutter/AdminContactDetails.dart';
import 'package:shopping_mall_flutter/AdminShopsAdd.dart';
import 'package:shopping_mall_flutter/main.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to disable back button
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        appBar: AppBar(
          title: Text(
            'Management page',
            style: TextStyle(color: Colors.white),
          ),
          toolbarHeight: 60.w,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color.fromRGBO(57, 142, 224, 1.0),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SelectUserPage()),
                    (route) => false);
              },
              icon: Icon(Icons.logout),
              padding: EdgeInsets.only(right: 20.w),
              iconSize: 30.w,
            )
          ],
        ),
        body: Container(
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
          )),
          child: Padding(
            padding: EdgeInsets.only(left: 80.w, right: 80.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20.w,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          print("1st options:profile ");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminAddPromotions()),
                          );
                        },
                        splashColor: Color.fromRGBO(61, 90, 161, 1.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.discount_rounded,
                                color: Colors.black,
                                size: 45.h,
                              ),
                              Text(
                                "Promotions",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20.w,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          print("2nd options:profile ");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminAddContacts()),
                          );
                        },
                        splashColor: Color.fromRGBO(61, 90, 161, 1.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.contact_phone,
                                color: Colors.black,
                                size: 45.h,
                              ),
                              Text(
                                "Contacts",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20.w,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          print("3nd options:shops ");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminAddShopsPage()));
                        },
                        splashColor: Color.fromRGBO(61, 90, 161, 1.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_filled,
                                color: Colors.black,
                                size: 45.h,
                              ),
                              Text(
                                "Shops",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
