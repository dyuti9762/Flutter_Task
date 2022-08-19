import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    _selectedLanguage = Get.locale.toString() == 'en_US' ? 'English' : 'Spanish';
    saveChanges();
  }
  saveChanges()
  {
    Locale localeInternal = const Locale('en', 'US') ;
    if(_selectedLanguage == 'English'){
      setState(() {
        //language=true;
      });
    }
    else{
      localeInternal = const Locale('es', 'ES');
      setState(() {
        //language=false;
      });
    }
    Get.updateLocale(localeInternal);
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: MediaQuery.of(context).padding.add(const EdgeInsets.fromLTRB(30, 0, 30, 30)),
            child: Container(

                height: MediaQuery.of(context).size.height,

                //padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Image.asset('assets/images/sports-analytics-logo.png',
                          width: MediaQuery.of(context).size.height * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),

                    Image.asset('assets/images/signup.png',
                          // width: 280,
                          // height: 280,

                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),



                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(const Color(0xFF002870)),
                          ), onPressed: () { Navigator.pushNamed(context, '/signup'); },
                          child:  Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Signup With Email'.tr,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(const Color(0xFF2298FC)),
                          ), onPressed: () { print("Pressed"); },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Continue With Google',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                        const Center(
                            child: Text('OR')
                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                        SizedBox(
                          height: 60,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(width: 1.0, color: Color(0xFF002870)),

                            ),
                            onPressed: () { Navigator.pushNamed(context, '/login'); },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),

                              child:  Text(
                                'Already a Member ? Login',
                                style: TextStyle(color: Color(0xFF48474A), fontSize: 16),
                              ),
                            ),

                          ),
                        ),

                      ],
                    )


            ),
          ),
        )

    );
  }
}


// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Padding(
//             padding: MediaQuery.of(context).padding.add(const EdgeInsets.fromLTRB(30, 0, 30, 30)),
//             child: Container(
//
//                 height: MediaQuery.of(context).size.height,
//
//                 //padding: const EdgeInsets.all(30.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//
//                     Image.asset('assets/images/sports-analytics-logo.png',
//                           width: 200,
//                           height: 70,
//                         ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.05,
//                     ),
//
//                     Image.asset('assets/images/signup.png',
//                           // width: 280,
//                           // height: 280,
//
//                         ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.04,
//                     ),
//
//
//
//                         TextButton(
//                           style: ButtonStyle(
//                             backgroundColor:
//                             MaterialStateProperty.all<Color>(const Color(0xFF002870)),
//                           ), onPressed: () { Navigator.pushNamed(context, '/signup'); },
//                           child: const Padding(
//                             padding: EdgeInsets.all(10.0),
//                             child: Text(
//                               'Signup With Email',
//                               style: TextStyle(color: Colors.white, fontSize: 16),
//                             ),
//                           ),
//                         ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                         TextButton(
//                           style: ButtonStyle(
//                             backgroundColor:
//                             MaterialStateProperty.all<Color>(const Color(0xFF2298FC)),
//                           ), onPressed: () { print("Pressed"); },
//                           child: const Padding(
//                             padding: EdgeInsets.all(10.0),
//                             child: Text(
//                               'Continue With Google',
//                               style: TextStyle(color: Colors.white, fontSize: 16),
//                             ),
//                           ),
//                         ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                         const Center(
//                             child: Text('OR')
//                         ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                         SizedBox(
//                           height: 60,
//                           child: OutlinedButton(
//                             style: OutlinedButton.styleFrom(
//                               side: const BorderSide(width: 1.0, color: Color(0xFF002870)),
//
//                             ),
//                             onPressed: () { Navigator.pushNamed(context, '/login'); },
//                             child: const Padding(
//                               padding: EdgeInsets.all(10.0),
//
//                               child:  Text(
//                                 'Already a Member ? Login',
//                                 style: TextStyle(color: Color(0xFF48474A), fontSize: 16),
//                               ),
//                             ),
//
//                           ),
//                         ),
//
//                       ],
//                     )
//
//
//             ),
//           ),
//         )
//
//     );
//   }
// }