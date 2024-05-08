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
        decoration: const BoxDecoration(color: Color.fromRGBO(229, 227, 221, 1.0)),
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Promotions", style: TextStyle(fontSize: 20.sp,color: Colors.white)),
        backgroundColor: const Color.fromRGBO(51, 110, 203, 1.0),
        toolbarHeight: 60.w,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 25.w,top:10.w),
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
    );
  }
}
