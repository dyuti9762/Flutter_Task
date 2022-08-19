import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/cupertino.dart';

class GenerateQR extends StatefulWidget {
  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  final qrKey = GlobalKey();
  String qrData=" ";
  String nameData = "";
  String teamdata = "";
  bool isqrdataempty = false;
  final qrdataFeed = TextEditingController();
  final name = TextEditingController();
  final team = TextEditingController();

  void takeScreenShot() async {
    PermissionStatus res;
    res = await Permission.storage.request();
    if (res.isGranted) {
      final boundary =
      qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // We can increse the size of QR using pixel ratio
      final image = await boundary.toImage(pixelRatio: 5.0);
      final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        // getting directory of our phone
        final directory = (await getApplicationDocumentsDirectory()).path;
        final imgFile = File(
          '$directory/${DateTime.now()}.png',
        );
        imgFile.writeAsBytes(pngBytes);
        GallerySaver.saveImage(imgFile.path).then((success) async {
          //In here you can show snackbar or do something in the backend at successfull download
        });
      }
    }
  }

  @override
  void innit(){
    isqrdataempty = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar having title
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
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:12),
                  child: Text('Geneerate Player\n QR code',
                    maxLines: 3,
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(

          //Scroll view given to Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text("Generate QR Code",style: TextStyle(fontSize: 20),),

              //TextField for input link
              TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: "Enter your Name"
                ),
              ),
              TextField(
                controller: team,
                decoration: InputDecoration(
                    hintText: "Enter Team"
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                //Button for generating QR code
                child: ElevatedButton(
                  onPressed: () async {
                    //a little validation for the textfield
                    if (name.text.isEmpty || team.text.isEmpty) {
                      setState(() {
                        qrData = "";
                        isqrdataempty = false;
                      });
                    } else {
                      setState(() {

                        nameData = name.text;
                        teamdata = team.text;
                        qrData = 'Name: $nameData\n Number: $teamdata';
                        isqrdataempty = true;
                      });
                    }
                  },
                  //Title given on Button
                  child: Text("Generate QR Code",style: TextStyle(color: Colors.indigo[900],),),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  //   side: BorderSide(color: Colors.pink),
                  // ),
                ),
              ),
              
              Output(context, qrData, nameData, teamdata)
            ],
          ),
        ),
      ),
    );
  }
  Widget Output(context,qrData, name, team) {
    return isqrdataempty ? Card(
      color: Color(0xFFE8F3FE),
      child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    // border: Color(0xFFADCBE8)

                    child: Image.asset('assets/images/Dyuti.jpeg', height: 100,)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text( team),
                  ],
                ),

                RepaintBoundary(
                  key: qrKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: QrImage(
                      // data: "Name: Martine nasda,"
                      //     "DOB: 21 March 1970, "
                      //     "Team: FC Barcelona, "
                      //     "Role: Defender",
                      data: qrData,
                      // "DOB: $newData[index]['DOB'] "
                      // "Team: $newData[index]['Team'] "
                      // "Role: $newData[index]['Role']",
                      version: QrVersions.auto,
                      size: 120.0,
                    ),
                  ),
                ),

                InkWell(
                  child: Text(
                    'Download Image',
                    style: TextStyle(color: Colors.blue),
                    //onPressed: takeScreenShot,
                  ),
                  onTap: takeScreenShot,
                ),
                const SizedBox(height: 25)
              ],

            ),
          )

        //Text(newData[index]['Name']),

      ),
    ): Text('');
  }
}

