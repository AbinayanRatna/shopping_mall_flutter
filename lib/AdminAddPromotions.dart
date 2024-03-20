import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AdminAddPromotions extends StatefulWidget {
  const AdminAddPromotions({super.key});

  @override
  State<AdminAddPromotions> createState() => _AdminAddPromotions();
}

class _AdminAddPromotions extends State<AdminAddPromotions> {
  late DatabaseReference dbRef2;
  TextEditingController shopNameController = TextEditingController();
  String uuid = Uuid().v4();
  late String image_url;

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
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("Promotion_" + fileName);
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
        title: Text("Add promotions", style: TextStyle(fontSize: 20.sp)),
        backgroundColor: const Color.fromRGBO(197, 139, 48, 1.0),
        toolbarHeight: 45.w,
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
                                child: (image == null)
                                    ? SvgPicture.asset(
                                  "assets/selectUser.svg",
                                  fit: BoxFit.cover,
                                )
                                    : Image.file(image!, fit: BoxFit.cover),
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 3),
                            Padding(
                              padding: EdgeInsets.only(left: 30.w),
                              child: ElevatedButton(
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
                        style: TextStyle(color: Colors.black, fontSize: 15.w),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 2.w, left: 30.w, right: 30.w),
                      child: TextField(
                        controller: shopNameController,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(194, 173, 129, 1.0)),
                            hintText: "eg:- Chennai Super Kings"),
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
                  backgroundColor: const Color.fromRGBO(117, 90, 41, 1.0),
                ),
                onPressed: () {
                  /*
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminSelectTournamentPage(),
                      ),
                          (route) => false);

                   */
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
                  backgroundColor: const Color.fromRGBO(107, 75, 3, 1.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
                onPressed: () {
                  Map<String, String> promotions = {
                    'id': uuid,
                    'name': shopNameController.text.trim(),
                    'image': image_url,
                  };
                  dbRef2.set(promotions);
                  /*
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminSelectTournamentPage()),
                          (route) => false);

                   */
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