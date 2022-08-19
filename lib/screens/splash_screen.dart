import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Image> list = [
    Image.asset('assets/images/soccer.png', ),
    Image.asset('assets/images/badminton.png', ),
    Image.asset('assets/images/baseball.png',),
  ];
  int currentIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0, viewportFraction: 0.5
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 5),
          (Timer timer) {
        if (currentIndex < list.length-1) {
          currentIndex++;
        }

        else {
          currentIndex = 0;
        }

        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
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
          title:   Padding(
              padding: EdgeInsets.only(left:20, right:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Sports & Activities',
                maxLines: 2,
                style: TextStyle(color: Color(0xff242526),
                    overflow: TextOverflow.visible,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),
              ),
                    Container(
                    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    border: Border.all(color: Color(0xFFADCBE8))
    // border: Color(0xFFADCBE8)
    ),

    // margin:,
    child: IconButton(
    icon: const Icon(Icons.menu , color: Color(0xFF002870)),
    onPressed: () {

    print('pressed');
    Navigator.pushNamed(context, '/myaccount');
    },
    ),
    ),
                ],
              ),



        ) ,
        ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.only(left: 35, right: 35),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children:[
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
      ),
              const Text('Sports Activities',
                maxLines: 2,
                style: TextStyle(color: Color(0xff242526),
                    overflow: TextOverflow.visible,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Text('Choose the sport and Practice various shots and \nlearn From AI',
                  maxLines: 2,
                  style: TextStyle(color: Color(0xff242526),
                      overflow: TextOverflow.visible,
                      fontSize: 15
                  ),

            ),
            SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
                controller: _pageController,
                scrollDirection: axisDirectionToAxis(AxisDirection.right),
                onPageChanged: _onPageChanged,

        itemCount: list.length,

              itemBuilder: (_,i){
                return ListView(
                    children: [
                      Container(child: list[i],
                        decoration: BoxDecoration(
                          //color: Colors.red,
                        ),
                        //width: MediaQuery.of(context).size.width * 0.1
                      ),
                    ]
                );
              }),
          ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

    Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          list.length,
        (index) => buildDot(index, context)
    )
    ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Card(
              elevation: 1,
              shadowColor: const Color(0xFFC2EDF0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              //color: Color(newData[index]['color']),
              color: const Color(0xFFEFFAFB),
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        const Text('Take Physical Activity\n Assessment',
                          //'Note Title',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),

                        IconButton(onPressed:(){print('pressed');},icon: Image.asset(('assets/images/Group 12087.png'), height: 20, width: 20))

                      ],
                    ),


                   Image.asset('assets/images/Light bulb-pana.png', height: 100, width: 100,)
                  ]
                ),
              ),
              
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(left:8),
              child: Text('Diagnosed Diseases',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(left:8),
              child: Text('Injuries recovery suggested activities and Stats',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Container(
                   height:MediaQuery.of(context).size.height * 0.17,
                   width: MediaQuery.of(context).size.width * 0.279,

                   child: Card(
                     color: Color(0xFFE8F3FE),
                     shadowColor: Color(0xFFADCBE8),
                     child: Padding(
                       child: Column(children:[
                         Image.asset('assets/images/Path 36948.png', height: 50, width: 50,),
                         SizedBox(
                           height: MediaQuery.of(context).size.height * 0.02,
                         ),
                         Text('Hypertension', style: TextStyle(fontSize: 12),)
                       ]),
                       padding: EdgeInsets.fromLTRB(15, 18, 15, 12),
                     ),

                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12.0),
                     ),
                     elevation: 1,

                   ),
                 ),

                 Container(
                   height:MediaQuery.of(context).size.height * 0.17,
                   width: MediaQuery.of(context).size.width * 0.26,

                   child: Card(
                     color: const Color(0xFFE8F3FE),
                     shadowColor: const Color(0xFFADCBE8),

                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12.0),
                     ),
                     elevation: 1,
                     child: Padding(
                       padding: const EdgeInsets.fromLTRB(15, 18, 15, 12),
                       child: Column(children:[

                         Image.asset('assets/images/Group 11601.png', height: 50, width: 50,),
                         SizedBox(
                           height: MediaQuery.of(context).size.height * 0.02,
                         ),
                         const Text('Diabetes', style: TextStyle(fontSize: 12),)
                       ]),
                     ),

                   ),
                 ),
                 SizedBox(
                   height:MediaQuery.of(context).size.height * 0.17,
                   width: MediaQuery.of(context).size.width * 0.26,

                   child: Card(
                     color: const Color(0xFFE8F3FE),
                     shadowColor: Color(0xFFADCBE8),

                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12.0),
                     ),
                     elevation: 1,
                     child: Padding(
                       padding: EdgeInsets.fromLTRB(15, 18, 15, 12),
                       child: Column(children:[
                         Image.asset('assets/images/Path 36949.png', height: 50, width: 50,),
                         SizedBox(
                           height: MediaQuery.of(context).size.height * 0.02,
                         ),
                         Text('Survical', style: TextStyle(fontSize: 12),)
                       ]),
                     ),

                   ),
                 ),



               ],
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Text('Diagnosed Diseases',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Text('Injuries recovery suggested activities and Stats',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height:MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.26,
                  // height:120,
                  // width: 110,

                  child: Card(
                    color: const Color(0xFFE8F3FE),
                    shadowColor: Color(0xFFADCBE8),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 18, 15, 12),
                      child: Column(children:[
                        Image.asset('assets/images/Path 36948.png', height: 50, width: 50,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const Text('Shoulder', style: TextStyle(fontSize: 12),)
                      ]),
                    ),

                  ),
                ),

                Container(
                  height:MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.26,

                  child: Card(
                    color: const Color(0xFFE8F3FE),
                    shadowColor: const Color(0xFFADCBE8),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 18, 15, 12),
                      child: Column(children:[
                        Image.asset('assets/images/Group 11601.png', height: 50, width: 50,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const Text('Knee', style: TextStyle(fontSize: 12),)
                      ]),
                    ),

                  ),
                ),
                SizedBox(
                  height:MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.26,

                  child: Card(
                    color: const Color(0xFFE8F3FE),
                    shadowColor: Color(0xFFADCBE8),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 18, 15, 12),
                      child: Column(children:[
                        Image.asset('assets/images/Path 36949.png', height: 50, width: 50,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const Text('Hip Injury', style: TextStyle(fontSize: 12),)
                      ]),
                    ),

                  ),
                ),



              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Card(
              elevation: 1,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              //color: Color(newData[index]['color']),
              color: const Color(0xFFEFFAFB),
              shadowColor: const Color(0xFFC2EDF0),
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 13),
                child: Column(
                  children:[
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          const Text('Aerobic Activity',
                            //'Note Title',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF48474A),
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          const Text('Perform Aerobic activity for 30 mins',
                            style: TextStyle(
                                color: Color(0xFF48474A),
                                fontSize: 12),
                          ),





                          //SizedBox(width: 20),

                        ],
                      ),
                        IconButton(onPressed:(){print('pressed');},icon: Image.asset(('assets/images/Group 12087.png'), height: 20, width: 20)),

                      ],


                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Time spent out',
                          style: TextStyle(
                              color: Color(0xFF48474A),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Text('15/30 mins',
                          style: TextStyle(
                              color: Color(0xFF48474A),
                              fontSize: 12),
                        ),
                      ],
                    ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),

                    child:  SizedBox(
                      height: 5,
                      child: LinearProgressIndicator(
                        value: 0.7, // percent filled
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF17CA94)),
                        backgroundColor: Color(0xFF17CA94).withOpacity(0.1),
                      ),
                    ),
                )
                  ]
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Card(
              elevation: 1,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              //color: Color(newData[index]['color']),
              color: const Color(0xFFEFFAFB),
              shadowColor: const Color(0xFFC2EDF0),
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 13),
                child:
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            const Text('Yoga',
                              //'Note Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF48474A),
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.005,
                            ),
                            const Text('Do yoga at least 30 mins in morning',
                              style: TextStyle(
                                  color: Color(0xFF48474A),
                                  fontSize: 12),
                            ),





                            //SizedBox(width: 20),

                          ],
                        ),
                          IconButton(onPressed:(){print('pressed');},icon: Image.asset(('assets/images/Group 12087.png'), height: 20, width: 20)),

                        ],


                      ),



              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              padding: const EdgeInsets.only(right: 0),
              margin: const EdgeInsets.only(right: 0),
              child: Card(
                elevation: 1,
                shadowColor: const Color(0xFFC2EDF0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                //color: Color(newData[index]['color']),
                color: const Color(0xFFE8F3FE),
                child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Padding(
                      padding: const EdgeInsets.only(left:20.0, top: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          const Text('Search for Disease and get \nExercise recommendations',
                            textAlign: TextAlign.left,
                            //'Note Title',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          IconButton(onPressed:(){print('pressed');},icon: Image.asset(('assets/images/Group 12087.png'), height: 20, width: 20))

                        ],
                      ),
                    ),


                     Align(child: Image.asset(alignment: Alignment.topRight,'assets/images/Group 11547.png', height: 90, width: 70,)),
                    ]
                ),

              ),
            ),

    ]
    ),
      )
    );




  }
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 30 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF002870),
      ),
    );
  }
}
