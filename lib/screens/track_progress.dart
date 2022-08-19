import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:async/async.dart';
import 'package:get/get.dart';
import 'explore_cards.dart';
import 'water_intake.dart';

class TrackProgress extends StatefulWidget {
  const TrackProgress({Key? key}) : super(key: key);

  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

class _TrackProgressState extends State<TrackProgress> {
  String _selectedLanguage = '';
  late List<BMIMeasurement> _chartData;
  String dropdownvalue = 'Week';
  late final TextEditingController _currentweightController = TextEditingController();
  late final TextEditingController _targetweightController = TextEditingController();
  String weight = '';
  String targetWeight = '';
  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'हिंदी','locale': Locale('hi','IN')},
  ];


  // List of items in our dropdown menu
  var items = [
    'Week',
    'Month',
    'Year',
  ];



  @override
  void initState() {
    _chartData = getChartData();
        super.initState();
    _selectedLanguage = Get.locale.toString() == 'en_US' ? 'English' : 'Hindi';
  }
  updateLanguage()
  async {
    Locale localeInternal = const Locale('en', 'US') ;

    if(_selectedLanguage == 'ENGLISH'){
      localeInternal = const Locale('en', 'US');
      setState((){

      });
    }
    else{
      localeInternal = const Locale('hi', 'IN');
      setState((){

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
      appBar: AppBar(
          automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.0,

        toolbarHeight: 120,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left:10,right:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Text('Track Progress'.tr,
                  maxLines: 2,
                  style: TextStyle(color: Color(0xff242526),
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.bold,
                      fontSize: 27
                  ),
            ),
              Container(
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
                    buildLanguageDialog(context);
                  },
                ),
              ),
            ],
          ),
        )




      ) ,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
    Stack(
    children: <Widget>[
      Card(
          elevation: 1,
          shadowColor: const Color(0xFFC2EDF0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          //color: Color(newData[index]['color']),
          color: const Color(0xFFE8F3FE),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
            child: Column(
                children:[
                  Row(
                    children: [
                      Stack(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top:5, left: 5),
                                child: Image.asset('assets/images/Path 36410.png',height: 45, width:45)),
                            Container(
                              width: 55,
                              height: 55,
                              margin: EdgeInsets.only(right: 20),
                              child: CircularProgressIndicator(
                                value: 0.6,

                                valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF2298FC)),
                                backgroundColor: Color(0xFF17CA94).withOpacity(0.1),
                                strokeWidth: 7,

                              ),
                            ),
                          ]
                      ),
                      Text('0.5 kg of 6kg Lost',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Current Weight'),
                      Text('$weight kg'),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text('Target Weight'),
                      Text('$targetWeight kg')
                    ],
                  )
                ]
            ),
          )

      ),
    Positioned(
    top: 2,
    right: 3,
    child: IconButton(onPressed: ()  async {

      weight = await openDialogue(context);


      setState(() {
        this.weight = weight;

      });



    },
        icon: Image.asset('assets/images/Group 10986.png', height: 20, width:20,)
    ),
    ),
    ],
    ),


          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(left:10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BMI Progress',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),),
                Text('Edit Vitals',
                  style: TextStyle(
                      fontSize: 12,
                    color: Color(0xFFF48474A)
                  ),),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(

            //color: Color(newData[index]['color']),
              color: const Color(0xFFFFFFFF),
              shadowColor: const Color(0xFFC2EDF0),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFFE8F3FE), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 35,
                    margin: EdgeInsets.only(right: 20, top: 20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color:Colors.white, //background color of dropdown button
                          border: Border.all(color: Color(0xFF2C2C2E), width:1), //border of dropdown button
                          borderRadius: BorderRadius.circular(5), //border raiuds of dropdown button

                      ),
                      child: Container(
                        //margin: EdgeInsets.only(right:30),
                        padding: EdgeInsets.only(left:15, right:15,),
                        child: DropdownButton(
underline: SizedBox(),
                          elevation: 0,

                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items, style: TextStyle(fontSize: 12),),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SfCartesianChart(

                  series: <ChartSeries>[
                    LineSeries<BMIMeasurement, double>(

                        dataSource: _chartData, xValueMapper: (BMIMeasurement bmi, _) => bmi.week, yValueMapper: (BMIMeasurement bmi, _) => bmi.bmi, color: Color(0xFF2298FD))
                  ],
                  primaryXAxis: CategoryAxis(
        title: AxisTitle(
                                text: 'weeks',
                                textStyle: TextStyle(

                                  fontSize: 15,


                                )
                            ),
                      majorGridLines: const MajorGridLines(width: 0),
                      labelPlacement: LabelPlacement.onTicks),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                          text: 'BMI Measurement',
                          textStyle: TextStyle(

                            fontSize: 15,


                          )
                      ),
                      axisLine: const AxisLine(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      majorTickLines: const MajorTickLines(size: 0)),

                //     primaryXAxis: CategoryAxis(
                //         title: AxisTitle(
                //             text: 'weeks',
                //             textStyle: TextStyle(
                //
                //               fontSize: 15,
                //
                //
                //             )
                //         )
                //     ),
                //     primaryYAxis: CategoryAxis(
                // title: AxisTitle(
                // text: 'BMI Measurement',
                //     textStyle: TextStyle(
                //
                //       fontSize: 15,
                //
                //
                //     )
                // )
      ),
      ]
              )
              ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(left:10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BMI Progress',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
                Text('Edit Vitals',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFF48474A)
                  ),),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(

            //color: Color(newData[index]['color']),
              color: const Color(0xFFFFFFFF),
              shadowColor: const Color(0xFFC2EDF0),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFFE8F3FE), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      margin: EdgeInsets.only(right: 20, top: 20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color:Colors.white, //background color of dropdown button
                          border: Border.all(color: Color(0xFF2C2C2E), width:1), //border of dropdown button
                          borderRadius: BorderRadius.circular(5), //border raiuds of dropdown button

                        ),
                        child: Container(
                          //margin: EdgeInsets.only(right:30),
                          padding: EdgeInsets.only(left:15, right:15,),
                          child: DropdownButton(
                            underline: SizedBox(),
                            elevation: 0,

                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items, style: TextStyle(fontSize: 12),),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SfCartesianChart(
                      series: <ChartSeries>[
                        LineSeries<BMIMeasurement, double>(

                            dataSource: _chartData, xValueMapper: (BMIMeasurement bmi, _) => bmi.week, yValueMapper: (BMIMeasurement bmi, _) => bmi.bmi, color: Color(0xFF17CA94))
                      ],
                      primaryXAxis: CategoryAxis(
                          title: AxisTitle(
                              text: 'weeks',
                              textStyle: TextStyle(

                                fontSize: 15,


                              )
                          ),
                          majorGridLines: const MajorGridLines(width: 0),
                          labelPlacement: LabelPlacement.onTicks),
                      primaryYAxis: NumericAxis(
                          title: AxisTitle(
                              text: 'BMI Measurement',
                              textStyle: TextStyle(

                                fontSize: 15,


                              )
                          ),
                          axisLine: const AxisLine(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          majorTickLines: const MajorTickLines(size: 0)),

                      //     primaryXAxis: CategoryAxis(
                      //         title: AxisTitle(
                      //             text: 'weeks',
                      //             textStyle: TextStyle(
                      //
                      //               fontSize: 15,
                      //
                      //
                      //             )
                      //         )
                      //     ),
                      //     primaryYAxis: CategoryAxis(
                      // title: AxisTitle(
                      // text: 'BMI Measurement',
                      //     textStyle: TextStyle(
                      //
                      //       fontSize: 15,
                      //
                      //
                      //     )
                      // )
                    ),
                  ]
              )
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(left:10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BMI Progress',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
                Text('Edit Vitals',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFF48474A)
                  ),),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(

            //color: Color(newData[index]['color']),
              color: const Color(0xFFFFFFFF),
              shadowColor: const Color(0xFFC2EDF0),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFFE8F3FE), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      margin: EdgeInsets.only(right: 20, top: 20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color:Colors.white, //background color of dropdown button
                          border: Border.all(color: Color(0xFF2C2C2E), width:1), //border of dropdown button
                          borderRadius: BorderRadius.circular(5), //border raiuds of dropdown button

                        ),
                        child: Container(
                          //margin: EdgeInsets.only(right:30),
                          padding: EdgeInsets.only(left:15, right:15,),
                          child: DropdownButton(
                            underline: SizedBox(),
                            elevation: 0,

                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items, style: TextStyle(fontSize: 12),),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SfCartesianChart(
                      series: <ChartSeries>[
                        LineSeries<BMIMeasurement, double>(

                            dataSource: _chartData, xValueMapper: (BMIMeasurement bmi, _) => bmi.week, yValueMapper: (BMIMeasurement bmi, _) => bmi.bmi, color: Color(0xFFFEB30F))
                      ],
                      primaryXAxis: CategoryAxis(
                          title: AxisTitle(
                              text: 'weeks',
                              textStyle: TextStyle(

                                fontSize: 15,


                              )
                          ),
                          majorGridLines: const MajorGridLines(width: 0),
                          labelPlacement: LabelPlacement.onTicks),
                      primaryYAxis: NumericAxis(
                          title: AxisTitle(
                              text: 'BMI Measurement',
                              textStyle: TextStyle(

                                fontSize: 15,


                              )
                          ),
                          axisLine: const AxisLine(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          majorTickLines: const MajorTickLines(size: 0)),

                      //     primaryXAxis: CategoryAxis(
                      //         title: AxisTitle(
                      //             text: 'weeks',
                      //             textStyle: TextStyle(
                      //
                      //               fontSize: 15,
                      //
                      //
                      //             )
                      //         )
                      //     ),
                      //     primaryYAxis: CategoryAxis(
                      // title: AxisTitle(
                      // text: 'BMI Measurement',
                      //     textStyle: TextStyle(
                      //
                      //       fontSize: 15,
                      //
                      //
                      //     )
                      // )
                    ),
                  ]
              )
          ),

        ]),
      ),
    );
  }
  List<BMIMeasurement> getChartData() {
    final List<BMIMeasurement> chartData = [
      BMIMeasurement(18, 1),
      BMIMeasurement(18, 1),
      BMIMeasurement(24, 2),
      BMIMeasurement(19, 3),
      BMIMeasurement(29, 4),
    ];
    return chartData;
  }
  openDialogue(BuildContext context) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(

      title: Center(child: Text('Weight')),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return Container(
            height: height - 700,
            child: Column(
                children: [

                  TextField(
                    autofocus: true,
                    decoration: InputDecoration( label: Text('Enter your current weight')),
                    controller: _currentweightController,
                  ),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(label: Text('Enter your target weight')),
                    controller: _targetweightController,
                  ),

                ]
            ),
          );
        },
      ),



      actions: [
        TextButton(onPressed: () => {Navigator.of(context).pop(BoxedReturns(_targetweightController.text, _currentweightController.text))}, child: Text('SUBMIT')),
        TextButton(onPressed: () => {Navigator.of(context).pop(),}, child: Text('CANCEL'))
      ],
    ),
  );


}
class BoxedReturns{
   String a;
  String b;

  BoxedReturns(this.a, this.b){
    print(a);
    print(b);
  }
}
class BoxedGet{
  String a;
  String b;

  BoxedGet(this.a, this.b){
    print(a);
    print(b);
  }
}

class BMIMeasurement {
  BMIMeasurement(this.bmi, this.week);
  final double bmi;
  final double week;
}
