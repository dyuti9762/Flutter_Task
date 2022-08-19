import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

class ManagePlayer extends StatefulWidget {
  const ManagePlayer({Key? key}) : super(key: key);

  @override
  State<ManagePlayer> createState() => _ManagePlayerState();
}

class _ManagePlayerState extends State<ManagePlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.pushNamed(context, '/explorecards');
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:12),
                child: Text('Player',
                  maxLines: 2,
                  style: TextStyle(color: Color(0xff242526),
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.bold,
                      fontSize: 27
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Color(0xFFADCBE8))
                  // border: Color(0xFFADCBE8)
                ),
                //margin: const EdgeInsets.only(left:20, right:10),
                // margin:,
                child: IconButton(
                  icon: const Icon(Icons.menu , color: Color(0xFF002870)),
                  onPressed: () {
                    print('pressed');
                    //buildLanguageDialog(context);
                  },
                ),
              ),
            ],
          ),
        )
    ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),

        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          //height: 200.0,
          height: MediaQuery.of(context).size.height * 0.5,
          child: FutureBuilder(
    future: DefaultAssetBundle.of(context)
        .loadString('assets/loadjson/playerdata.json'),
    builder: (context, snapshot) {
      // Decode the JSON
      var newData = json.decode(snapshot.data.toString());
      return ListView.builder(
          scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    //width: 160.0,
                    child: Card(
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
                                child: Image.asset(newData[index]['img'],height:100),
                              ),
                        QrImage(
                              // data: "Name: Martine nasda,"
                              //     "DOB: 21 March 1970, "
                              //     "Team: FC Barcelona, "
                              //     "Role: Defender",
                          data: "$newData",
                                  // "DOB: $newData[index]['DOB'] "
                                  // "Team: $newData[index]['Team'] "
                                  // "Role: $newData[index]['Role']",
                              version: QrVersions.auto,
                              size: 120.0,
                            ),
                            ],
                          ),
                        )

                        //Text(newData[index]['Name']),

                      ),
                    ),
          );
        },
        itemCount: newData == null ? 0 : newData.length,
      );

    }
          ),
        ),
      ),
    );
  }
}
    // return Scaffold(
    //   body: QrImage(
    //     data: "Name: Martine nasda,"
    //         "DOB: 21 March 1970, "
    //         "Team: FC Barcelona, "
    //         "Role: Defender",
    //     version: QrVersions.auto,
    //     size: 200.0,
    //   ),
    // );
  //}
//}
