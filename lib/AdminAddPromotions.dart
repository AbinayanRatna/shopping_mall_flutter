import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:shopping_mall_flutter/AdminHome.dart';
import 'package:uuid/uuid.dart';

import 'AdminSelectPromotionsPage.dart';

class AdminAddPromotions extends StatefulWidget {
  const AdminAddPromotions({super.key});

  @override
  State<AdminAddPromotions> createState() => _AdminAddPromotions();
}

class _AdminAddPromotions extends State<AdminAddPromotions> {
  late DatabaseReference dbRef2;
  TextEditingController shopNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String uuid = Uuid().v4();
  String image_url = 'h';

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print("failed to pick image : $e");
    }
    var imageFile = File(image!.path);
    String fileName = Path.basename(imageFile.path);

    FirebaseStorage storage  = FirebaseStorage.instance;

    Reference ref = storage.ref().child("Promotion_$fileName");
    UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask.whenComplete(() async {
      var url = await ref.getDownloadURL();
      image_url = url.toString();
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    dbRef2 = FirebaseDatabase.instance.ref().child('promotions').child(uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Add promotions",
            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AdminSelectPromotionsPage()));
              },
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
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 15,
            child: Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 25.w, left: 30.w),
                        child: Row(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 3,
                                child: (image == null)
                                    ? Image.asset(
                                        'assets/discount.jpg',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(image!, fit: BoxFit.cover)),
                            Padding(
                              padding: EdgeInsets.only(left: 30.w),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero)),
                                    backgroundColor: Colors.indigo),
                                onPressed: () {
                                  pickImage();
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.w, bottom: 10.w),
                                  child: Text("Select image",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.w)),
                                ),
                              ),
                            )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 25.w, left: 30.w),
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
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(157, 173, 203, 1.0)),
                            hintText:
                                "eg:- Give a brief description about the promotion."),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
                onPressed: () {
                  if (shopNameController.text.trim().isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Shop name is empty",
                        toastLength: Toast.LENGTH_SHORT);
                  } else if (descriptionController.text.trim().isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Description is empty",
                        toastLength: Toast.LENGTH_SHORT);
                  } else if (image_url == 'h') {
                    Fluttertoast.showToast(
                        msg: "Image is empty", toastLength: Toast.LENGTH_SHORT);
                  } else {
                    Map<String, String> promotions = {
                      'id': uuid,
                      'name': shopNameController.text.trim(),
                      'image': image_url,
                      'description': descriptionController.text.trim()
                    };
                    dbRef2.set(promotions).then((value) {
                      Fluttertoast.showToast(
                          msg: "Saved successfully",
                          toastLength: Toast.LENGTH_SHORT);
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(
                          msg: "Error occurred:Try again",
                          toastLength: Toast.LENGTH_SHORT);
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminHomePage()),
                        (route) => false);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                  child: Text(
                    "Add promotion",
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
