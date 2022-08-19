import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';




class ExploreCards extends StatefulWidget {
  @override
  _ExploreCardsState createState() => _ExploreCardsState();
  late List data;

}

class _ExploreCardsState extends State<ExploreCards> {
  //bool language=false;
  String _selectedLanguage = '';
  void initState() {
    super.initState();
    _selectedLanguage = Get.locale.toString() == 'en_US' ? 'ENGLISH' : 'HINDI';
    saveChanges();
  }

  saveChanges()
  {
    Locale localeInternal = const Locale('en', 'US') ;
    if(_selectedLanguage == 'ENGLISH'){
      setState(() {
       // language=true;
      });
    }
    else{
      localeInternal = const Locale('hi', 'In');
      setState(() {
       // language=false;
      });
    }
    Get.updateLocale(localeInternal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottomOpacity: 0.0,
          elevation: 0.0,

          toolbarHeight: 120,
          backgroundColor: Colors.white,
          title:  Center(
            child: Text('What you want to Explore ?'.tr,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: TextStyle(color: Color(0xff242526),
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),
          ),
        ) ,
        body: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/loadjson/data.json'),
            builder: (context, snapshot) {
              // Decode the JSON
              var newData = json.decode(snapshot.data.toString());


              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10),
                    child: Card(
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      //color: Color(newData[index]['color']),
                      color: Color(int.parse(newData[index]['color'])),
                      //color:Colors.red,

                      child:
                         Padding(
                           padding: EdgeInsets.only(right: 30, left: 30, top: 35, bottom: 35),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                                 TextButton(
                                      child: Text(newData[index]['title'],
                                      //'Note Title',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 19),
                         ),
                                   onPressed: (){
                                        print('pressed');
                                   },
                                    ),



                              //SizedBox(width: 20),
                              Image.asset(newData[index]['img'],height: 70,
                                width: 80,)
                            ],
                        ),
                         ),

                    ),
                  );
                },
                itemCount: newData == null ? 0 : newData.length,
              );
            },
          ),
        ));
  }
}