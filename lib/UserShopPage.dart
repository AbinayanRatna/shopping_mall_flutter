import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_mall_flutter/UserQRScanningPage.dart';

class UserShopPage extends StatefulWidget {
  const UserShopPage({super.key});

  @override
  State<UserShopPage> createState() => _UserShopPage();
}

class _UserShopPage extends State<UserShopPage> {
  late DatabaseReference dbRef2;
  late Query dbQuery;
  TextEditingController searchTextController=TextEditingController();

  @override
  void initState() {
    super.initState();
    dbQuery = FirebaseDatabase.instance.ref().child('shops');
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                    padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                    backgroundColor: Color.fromRGBO(201, 169, 101, 1.0)),
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
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: (0),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero)),
                      padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                      backgroundColor: Color.fromRGBO(229, 227, 221, 1.0)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QrScannerPage(
                                  DesctinationShop:
                                      thisPlayer['name'].toString(),
                              DesctinationFloor: thisPlayer['floor_number'].toString(),
                              DesctinationShopFromLeft: thisPlayer['from_left'].toString(),
                              DesctinationShopFromRIght: thisPlayer['from_right'].toString(),
                                )));
                  },
                  child: Text(
                    "Locate",
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
        title: Text("Find Shops",
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
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black87)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: TextField(
                          controller: searchTextController,
                            onChanged: (String value) {
                              setState(() {});
                            },
                            style: TextStyle(
                                fontSize: 15.w, color: Colors.black87),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: TextStyle(color: Colors.grey[700]))),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Colors.black87,
                            size: 25.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
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
                /*
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map promotions = snapshot.value as Map;
                  promotions['key'] = snapshot.key;
                  return listItem(thisPlayer: promotions);
                },
                 */
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {

                  final title = snapshot.child('name').value.toString();
                  if (searchTextController.text.isEmpty) {
                    Map promotions = snapshot.value as Map;
                    promotions['key'] = snapshot.key;
                    return listItem(thisPlayer: promotions);
                  }
                  //else if
                  else if (title.toLowerCase().contains(searchTextController.text.toLowerCase().toString())) {
                    Map promotions = snapshot.value as Map;
                    promotions['key'] = snapshot.key;
                    return listItem(thisPlayer: promotions);
                  }
                  else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
