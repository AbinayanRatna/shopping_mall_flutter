import 'dart:ui' as ui;
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'AdminHome.dart';

class AdminShowQrPage extends StatefulWidget {
  final String shopName;
  final String description;
  final String floorNumber;
  final String shopsFromRight;
  final String shopsFromLeft;

  const AdminShowQrPage(
      {super.key,
      required this.shopName,
      required this.description,
      required this.floorNumber,
      required this.shopsFromLeft,
      required this.shopsFromRight});

  @override
  State<StatefulWidget> createState() => _AdminShowQrPageState();
}

class _AdminShowQrPageState extends State<AdminShowQrPage> {
  GlobalKey _globalKey = GlobalKey();

/*
  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary? boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        var image = await boundary.toImage();
        ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        final tempDir = await getTemporaryDirectory();
        final file = await new File('${tempDir.path}/image.png').create();
        await file.writeAsBytes(pngBytes);

        final channel =
        const MethodChannel('channel:me.alfian.share/share');
        channel.invokeMethod('shareFile', 'image.png');
      } else {
        print("RenderRepaintBoundary is null.");
      }
    } catch (e) {
      print(e.toString());
    }
  }

 */

  Future<Uint8List?> _capturePng() async {
    try {
      // Find the RenderRepaintBoundary object
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;

      // Capture image as ui.Image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // Convert ui.Image to ByteData
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      // Convert ByteData to Uint8List
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      return pngBytes;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _uploadImageToFirebaseStorage(Uint8List imageBytes) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      DatabaseReference deRef=FirebaseDatabase.instance.ref().child('shops/${widget.shopName}');
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference ref = storage.ref().child('${widget.shopName}.png');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putData(imageBytes);

      // Get the download URL
      String downloadURL = await (await uploadTask).ref.getDownloadURL();
      Map<String,String> shops={
        "name":(widget.shopName).toString(),
        "floor_number":(widget.floorNumber).toString(),
        "from_right":(widget.shopsFromRight).toString(),
        "from_left":(widget.shopsFromLeft).toString(),
        "description":(widget.description).toString(),
        "qr":downloadURL.toString()
      };
      deRef.set(shops);
      print("Image uploaded to Firebase Storage: $downloadURL");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Qr Code for the shop",
          style: TextStyle(fontSize: 17.w, color: Colors.white),
        ),
      ),
      body: Center(
        child: RepaintBoundary(
          key: _globalKey,
          child: QrImageView(
            data: widget.shopName,
            size: 300.w,
          ),
        ),
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
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                ),
                onPressed: () async {
                  Uint8List? imageBytes = await _capturePng();
                  if (imageBytes != null) {
                    await _uploadImageToFirebaseStorage(imageBytes).then((value){
                      Fluttertoast.showToast(msg: "Shop added");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomePage()));
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: "Shop not added");
                    });
                  }

                },
                child: Padding(
                  padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                  child: Text(
                    "Save",
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
