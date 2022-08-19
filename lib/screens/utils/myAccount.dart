import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manage_player.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
    String _selectedQRmenu = '';
  final List qr_code =[
    {'name':'QR Generator',},
    {'name':'Scanner',},
  ];


  buildDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            //title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(qr_code[index]['name']),onTap: (){
                        if (qr_code[index]['name'] == 'QR Generator'){
                          Navigator.pushNamed(context, '/generate');
                          //Get.back();
                        } else{
                          Navigator.pushNamed(context, '/scanner');
                        }
                        //Get.back();
                        // setState(() {
                        //   print(qr_code[index]['name']);
                        //   _selectedQRmenu = (qr_code[index]['name']);
                        //   redirectQR();
                        // });

                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.blue,
                );
              }, itemCount: qr_code.length
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: ListView(

            children: [
              Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
          // border: Color(0xFFADCBE8)

                      child: Image.asset('assets/images/Dyuti.jpeg', height: 100,)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text('Dyuti Mohapatra')
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextButton(
                child: Text('Sports and Activities',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),
                ),

                onPressed: () => {
                  Navigator.pushNamed(context, '/spashscreen')
                },
              ),
              Divider(
                color: Colors.black,
              ),
              TextButton(
                child: Text('Track Progress',
                  style: TextStyle(
fontSize: 25,
                    color: Colors.black
                  ),
                ),

                onPressed: () => {
                Navigator.pushNamed(context, '/trackProgress')
                },
              ),
              Divider(
                color: Colors.black,
              ),
              TextButton(
                child: Text('Water Intake',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),
                ),

                onPressed: () => {
                  Navigator.pushNamed(context, '/waterIntake')
                },
              ),
              Divider(
                color: Colors.black,
              ),
              TextButton(
                child: Text('Explore',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),
                ),

                onPressed: () => {
                  Navigator.pushNamed(context, '/explorecards')
                },
              ),
              Divider(
                color: Colors.black,
                height: 50,
              ),
              TextButton(
                child: Text('Google Map',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),
                ),

                onPressed: () => {
                  Navigator.pushNamed(context, '/map')
                },
              ),
              Divider(
                color: Colors.black,
              ),
              TextButton(
                child: Text('QR code',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),
                ),

                onPressed: () => {
                  buildDialog(context)
                },
              ),

            ]
          ),
        )
      )
    );
  }

}



// class MyAccount extends StatefulWidget {
//   const MyAccount({Key? key}) : super(key: key);
//   String _selectedQRmenu = '';
//   final List qr_code =[
//     {'name':'QR Generator',},
//     {'name':'Scanner',},
//   ];
//
//
//   buildLanguageDialog(BuildContext context){
//     showDialog(context: context,
//         builder: (builder){
//           return AlertDialog(
//             title: Text('Choose Your Language'),
//             content: Container(
//               width: double.maxFinite,
//               child: ListView.separated(
//                   shrinkWrap: true,
//                   itemBuilder: (context,index){
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(child: Text(qr_code[index]['name']),onTap: (){
//                         setState(() {
//                           print(qr_code[index]['name']);
//                           _selectedQRmenu = (qr_code[index]['name']);
//                           updateLanguage();
//                         });
//
//                       },),
//                     );
//                   }, separatorBuilder: (context,index){
//                 return Divider(
//                   color: Colors.blue,
//                 );
//               }, itemCount: locale.length
//               ),
//             ),
//           );
//         }
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.all(30),
//           child: ListView(
//
//             children: [
//               Column(
//                 children: [
//                   ClipRRect(
//                       borderRadius: BorderRadius.circular(50),
//           // border: Color(0xFFADCBE8)
//
//                       child: Image.asset('assets/images/Dyuti.jpeg', height: 100,)),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.03,
//                   ),
//                   Text('Dyuti Mohapatra')
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.03,
//               ),
//               TextButton(
//                 child: Text('Sports and Activities',
//                   style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.black
//                   ),
//                 ),
//
//                 onPressed: () => {
//                   Navigator.pushNamed(context, '/spashscreen')
//                 },
//               ),
//               Divider(
//                 color: Colors.black,
//               ),
//               TextButton(
//                 child: Text('Track Progress',
//                   style: TextStyle(
// fontSize: 25,
//                     color: Colors.black
//                   ),
//                 ),
//
//                 onPressed: () => {
//                 Navigator.pushNamed(context, '/trackProgress')
//                 },
//               ),
//               Divider(
//                 color: Colors.black,
//               ),
//               TextButton(
//                 child: Text('Water Intake',
//                   style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.black
//                   ),
//                 ),
//
//                 onPressed: () => {
//                   Navigator.pushNamed(context, '/waterIntake')
//                 },
//               ),
//               Divider(
//                 color: Colors.black,
//               ),
//               TextButton(
//                 child: Text('Explore',
//                   style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.black
//                   ),
//                 ),
//
//                 onPressed: () => {
//                   Navigator.pushNamed(context, '/explorecards')
//                 },
//               ),
//               Divider(
//                 color: Colors.black,
//               ),
//               TextButton(
//                 child: Text('Google Map',
//                   style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.black
//                   ),
//                 ),
//
//                 onPressed: () => {
//                   Navigator.pushNamed(context, '/map')
//                 },
//               ),
//               Divider(
//                 color: Colors.black,
//               ),
//               TextButton(
//                 child: Text('QR code',
//                   style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.black
//                   ),
//                 ),
//
//                 onPressed: () => {
//                   Navigator.pushNamed(context, '/map')
//                 },
//               ),
//
//             ]
//           ),
//         )
//       )
//     );
//   }
//
// }
