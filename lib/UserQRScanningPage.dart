import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerPage extends StatefulWidget {
  final String DesctinationShop;
  final String DesctinationFloor;
  final String DesctinationShopFromRIght;
  final String DesctinationShopFromLeft;

  const QrScannerPage(
      {super.key,
      required this.DesctinationShop,
      required this.DesctinationFloor,
      required this.DesctinationShopFromRIght,
      required this.DesctinationShopFromLeft});

  @override
  State<StatefulWidget> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  String result = "Please Scan";
  String currentFloor = '';
  late DatabaseReference dbRef;
  late DatabaseReference dbRef2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance
        .ref()
        .child("shops/${widget.DesctinationShop}");
  }

  void currentFloorNumberFinder() {
    dbRef2.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        currentFloor = snapshot.value.toString();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQrViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locate shops",
            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
        backgroundColor: const Color.fromRGBO(51, 110, 203, 1.0),
        automaticallyImplyLeading: true,
        toolbarHeight: 60.w,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQrViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "You are in: $result",
                style: TextStyle(
                  fontSize: 18.w,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                  elevation: 0,
                  backgroundColor: Colors.indigo),
              onPressed: () {
                  setState(() {
                    dbRef2 = FirebaseDatabase.instance
                        .ref()
                        .child("shops/${result}/floor_number");
                    dbRef2.once().then((DatabaseEvent event) {
                      DataSnapshot snapshot = event.snapshot;
                      if (snapshot.value != null) {
                        currentFloor = snapshot.value.toString();
                      }
                    }).then((value) => {
                    showToastMessageAnotherFloor(
                    context,
                    currentFloor,
                    widget.DesctinationFloor,
                    widget.DesctinationShopFromLeft,
                    widget.DesctinationShopFromRIght)
                    });

                  });
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                child: Text(
                  "Locate",
                  style: TextStyle(fontSize: 20.w, color: Colors.white),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  void showToastMessageAnotherFloor(BuildContext context, String currentFloor,
      String destinationFloor, String fromLeft, String fromRight) {
    int fromRightInt = int.parse(fromRight);
    int fromLeftInt = int.parse(fromLeft);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 30),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[800] ?? Colors.blue,
                // Use Colors.red if Colors.red[800] is null
                Colors.blue[900] ?? Colors.blue,
                // Use Colors.red if Colors.red[900] is null
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.w),
          ),
          padding: EdgeInsets.all(16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  (currentFloor != destinationFloor)
                      ? 'You are now in the $currentFloor floor. Go to $destinationFloor floor. Then if you pass ${fromLeftInt - 1} shops left side of elevator,or if you pass ${fromRightInt - 1} shops right side of elevator, you will reach the ${widget.DesctinationShop}'
                      : 'You are now in the $currentFloor floor. Then if you pass ${fromLeftInt - 1} shops left side of elevator,or if you pass ${fromRightInt - 1} shops right side of elevator, you will reach the ${widget.DesctinationShop}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.w,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
