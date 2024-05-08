import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shopping_mall_flutter/UserLocateShopsPage.dart';

class QrScannerPage extends StatefulWidget {
  final String DesctinationShop;

  const QrScannerPage({super.key, required this.DesctinationShop});

  @override
  State<StatefulWidget> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  String result = "Please Scan";

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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) =>
                            UserLocateShopsPage(nowShopName: result,
                                destinationShopName: widget.DesctinationShop)), (
                        route) => false);
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
}
