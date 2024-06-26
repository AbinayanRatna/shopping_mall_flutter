import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class UserContactPage extends StatefulWidget {
  const UserContactPage({super.key});

  @override
  State<UserContactPage> createState() => _UserShopPage();
}

class _UserShopPage extends State<UserContactPage> {
  late Query dbQuery;

  @override
  void initState() {
    super.initState();
    dbQuery = FirebaseDatabase.instance.ref().child('Contact_Details');
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget listItem({required Map thisPerson}) {
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                      elevation: (0),
                      padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                      backgroundColor: Color.fromRGBO(201, 169, 101, 1.0)),
                  onPressed: () {},
                  child: Container(
                      child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                      child: Text(
                        thisPerson['name'],
                        style: TextStyle(fontSize: 15.w, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.w),
                      child: Text(
                        thisPerson['contact'],
                        style: TextStyle(fontSize: 15.w, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.w),
                      child: Text(
                        thisPerson['job'],
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                      padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                      backgroundColor: Color.fromRGBO(229, 227, 221, 1.0)),
                  onPressed: () {

                    setState(() {
                      _makePhoneCall('tel:${thisPerson['contact'].toString()}');
                    });
                  },
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Contact Us", style: TextStyle(fontSize: 20.sp,color: Colors.white)),
        backgroundColor: const Color.fromRGBO(51, 110, 203, 1.0),
        toolbarHeight: 60.w,
      ),
      body: Container(
        child: Padding(
          padding:  EdgeInsets.only(top:10.w),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.w),
            child: FirebaseAnimatedList(
              query: dbQuery,
              defaultChild: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 35.w,
                  width: 35.w,
                  child: const CircularProgressIndicator(
                    backgroundColor: Color.fromRGBO(25, 56, 133, 1.0),
                    valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
                    strokeWidth: 10,
                  ),
                ),
              ),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map persons = snapshot.value as Map;
                persons['key'] = snapshot.key;
                return listItem(thisPerson: persons);
              },
            ),
          ),
        ),
      ),
    );
  }
}
