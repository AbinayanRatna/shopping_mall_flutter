import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_mall_flutter/AdminEditShopsPage.dart';

class AdminShopsSelectPage extends StatefulWidget {
  const AdminShopsSelectPage({super.key});

  @override
  State<AdminShopsSelectPage> createState() => _AdminShopsSelectPage();
}

class _AdminShopsSelectPage extends State<AdminShopsSelectPage> {
   DatabaseReference dbRef2=FirebaseDatabase.instance.ref().child('shops');
  late Query dbQuery;

  @override
  void initState() {
    super.initState();
    dbQuery = FirebaseDatabase.instance.ref().child('shops');
  }

  Widget listItem({required Map thisPlayer}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromRGBO(229, 227, 221, 1.0)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: (0),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                    padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                    backgroundColor: const Color.fromRGBO(201, 169, 101, 1.0)),
                onPressed: () {},
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                        child: Text(
                          thisPlayer['name'],
                          style: TextStyle(
                              fontSize: 25.w,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.w),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            thisPlayer['description'],
                            style:
                                TextStyle(fontSize: 15.w, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: (0),
                        padding: (EdgeInsets.only(top:20.w,bottom: 20.w)),
                        backgroundColor:
                            const Color.fromRGBO(229, 227, 221, 1.0),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminEditShopsPage(
                            description: thisPlayer['description'],
                            floorNum: thisPlayer["floor_number"],
                            numberLeft: thisPlayer["from_left"],
                            numberRight: thisPlayer["from_right"],
                            qr: thisPlayer["qr"],
                            shopname: thisPlayer["name"],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(fontSize: 15.w, color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: (0),
                      padding: (EdgeInsets.only(top:20.w,bottom: 20.w)),
                      backgroundColor: const Color.fromRGBO(229, 227, 221, 1.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                    ),
                    onPressed: () {
                      dbRef2.child(thisPlayer['name']).remove();
                    },
                    child: Text(
                      "Remove",
                      style: TextStyle(fontSize: 15.w, color: Colors.black),
                    ),
                  ),
                ],
              ),
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Select Shops",
            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
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
              child: Container(),
            ),
          ),
          Expanded(
            flex: 15,
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
                  Map promotions = snapshot.value as Map;
                  promotions['key'] = snapshot.key;
                  return listItem(thisPlayer: promotions);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
