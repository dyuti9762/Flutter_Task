import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/storage_handler.dart';
import 'utils/globals.dart' as globals;


class LanguageTry extends StatefulWidget {
  const LanguageTry({Key? key}) : super(key: key);

  @override
  State<LanguageTry> createState() => _LanguageTryState();
}

class _LanguageTryState extends State<LanguageTry> {

  String _selectedLanguage = '';
  bool isSpanishColorChanged=false;
  bool isEnglishColorChange=false;

    final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'हिंदी','locale': Locale('hi','IN')},
  ];
  @override
  void initState() {
    super.initState();
    debugPrint(Get.locale.toString());
    _selectedLanguage = Get.locale.toString() == 'en_US' ? 'English' : 'Hindi';
  }


  updateLanguage()
  async {
    Locale localeInternal = const Locale('en', 'US') ;
    await writeStorage("lanPref", _selectedLanguage);

    if(_selectedLanguage == 'ENGLISH'){
      localeInternal = const Locale('en', 'US');
      setState((){
        //globals.isTypeOfActivity=true;
      });
    }
    else{
      localeInternal = const Locale('hi', 'IN');
      setState((){
        //globals.isTypeOfActivity=true;
      });
    }
    Get.back();
    Get.updateLocale(localeInternal);
  }


  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        setState(() {
                          print(locale[index]['name']);
                          _selectedLanguage = (locale[index]['name']);
                          updateLanguage();
                        });

                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.blue,
                );
              }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('title'.tr),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('hello'.tr,style: TextStyle(fontSize: 15),),
              SizedBox(height: 10,),
              Text('message'.tr,style: TextStyle(fontSize: 20),),

              ElevatedButton(onPressed: (){
                buildLanguageDialog(context);
              }, child: Text('changelang'.tr)),
            ],
          ),
        )
    );
  }
}

