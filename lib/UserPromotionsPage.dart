import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPromotionPage extends StatefulWidget {
  const UserPromotionPage({super.key});

  @override
  State<UserPromotionPage> createState() => _UserPromotionPage();
}

class _UserPromotionPage extends State<UserPromotionPage> {
  late Query dbQuery;

  @override
  void initState() {
    super.initState();
    dbQuery = FirebaseDatabase.instance.ref().child('promotions');
  }

  Widget listItem({required Map thisPromotion}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(229, 227, 221, 1.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.network(thisPromotion['image'],
              loadingBuilder:  (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },),
            ),
            Padding(
              padding: EdgeInsets.only(top:10.w,bottom: 20.w,left:20.w),
              child: Text("Shop : ${thisPromotion['name']}",style: TextStyle(
                fontSize: 15.w
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.w,left:20.w),
              child: Text("Description : ${thisPromotion['description']}",style: TextStyle(
                  fontSize: 15.w
              ),),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: (0),
                    padding: (EdgeInsets.only(top: 10.w, bottom: 10.w)),
                    backgroundColor: Color.fromRGBO(16, 36, 85, 1.0)),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.only(top:15.w,bottom: 15.w),
                  child: Text(
                    "Find shop",
                    style: TextStyle(fontSize: 15.w, color: Colors.white),
                  ),
                )),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        title: Text("Promotions", style: TextStyle(fontSize: 20.sp)),

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
                  return listItem(thisPromotion: promotions);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
