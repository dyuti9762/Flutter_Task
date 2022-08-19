
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  String printResult ='';
  bool textnotnull = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }
  @override
  void innit(){
    textnotnull = false;
  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      printResult = result!.code!;
      textnotnull = true;
      print(printResult);
     // buildResult();
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return
      Scaffold(
  appBar: AppBar(
          automaticallyImplyLeading: false,
          bottomOpacity: 0.0,
          elevation: 0.0,

          toolbarHeight: 120,
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.only(left:15,right:10),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xFFADCBE8))
                    // border: Color(0xFFADCBE8)
                  ),
                  //margin: const EdgeInsets.only(left:10, right:20),
                  // margin:,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined , color: Color(0xFF002870)),
                    onPressed: () {
                      print('pressed');
                      //Navigator.pushNamed(context, '/explorecards');
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left:12),
                  child: Text('Scan Player QR code',
                    maxLines: 2,
                    style: TextStyle(color: Color(0xff242526),
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.bold,
                        fontSize: 27
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQRview(context),
         Positioned(bottom: 10,left:10,right:10, child: buildResult()),

        ]
      ),
    );

  }

  Widget buildQRview(context) {
    return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
        borderColor: const Color(0xFF4A96F5),
    borderRadius:5,
    borderLength: 120,
    borderWidth: 5,
    // cutOutHeight: MediaQuery.of(context).size.height * 0.2,
    // cutOutWidth: MediaQuery.of(context).size.width * 0.5,
    cutOutSize: MediaQuery.of(context).size.width * 0.6,
    )
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget buildResult() {
    //readQr();
    return textnotnull ? Container(
      margin: EdgeInsets.all(50),
padding: EdgeInsets.all(10),
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: Colors.white
),
        child: Text(
          textAlign: TextAlign.center,
          style: TextStyle(),
          printResult,
        maxLines: 3,

      ),
    ): const Text('');

  }
}