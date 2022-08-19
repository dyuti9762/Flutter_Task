import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'utils/date_utils.dart' as date_util;

class WaterIntake extends StatefulWidget {
  const WaterIntake({Key? key}) : super(key: key);

  @override
  State<WaterIntake> createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  late List<BMIMeasurement> _chartData;
  String dropdownvalue = 'Week';
  DateTime currentDateTime = DateTime.now();
  String header = '';
  String _date = DateTime.now().toString().split(' ').first;

  void _currentDate (_date, slected_date){
    if( _date == DateTime.now().toString().split(' ').first){
      setState(() {
        header = 'Today';
        print(DateTime.now().subtract(Duration(days:1)).toString().split(' ').first);
      });
    }
    else if (_date == DateTime.now().subtract(Duration(days:1)).toString().split(' ').first){
      setState(() {
        header = 'Yesterday';
      });

    } else if (_date == DateTime.now().add(Duration(days:1)).toString().split(' ').first){
      setState(() {
        header = 'Tommorrow';
      });

    } else{
      setState(() {

        header = date_util.DateUtils.months[slected_date.month - 1] +
            ' ' +slected_date.day.toString();
      });

      //header = 'Tomorrow';
    }

  }

  // void _header() {
  //   if (currentDateTime == DateTime.now()){
  //     setState(() {
  //       header = 'Today';
  //     });
  //     //
  //   }
  //   else if (currentDateTime == DateTime.now().subtract(Duration(days:1))){
  //     setState(() {
  //       header = 'Yesterday';
  //     });
  //   ;
  //   } else if (currentDateTime == DateTime.now().add(Duration(days:1))){
  //     setState(() {
  //       header = 'Tomorrow';
  //     });
  //
  //   } else{
  //     header = date_util.DateUtils.months[currentDateTime.month - 1] +
  //         ' ' +currentDateTime.day.toString();
  //
  //   }
  // }

  var items = [
    'Week',
    'Month',
    'Year',
  ];
  int _counter = 1;
  List<Image> list = [
    Image.asset('assets/images/Group 12505.png',height: 120 ),
    Image.asset('assets/images/Group 12501.png',height: 120 ),
    Image.asset('assets/images/Group 12502.png',height: 120),
    Image.asset('assets/images/Group 12503.png',height: 120),
    Image.asset('assets/images/glass-of-water.png',height: 120,),
  ];
  int currentIndex = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter < 9){
        _counter++;
      }
      else{
        return;
      }

    });
  }
  void _decrincrementCounter() {
    setState(() {
      if (_counter > 0){
        _counter--;
      }
      else{
        return;
      }
    });
  }
  void _incrementImageCounter() {
      setState(() {
        if(currentIndex <  list.length-1){
          list[currentIndex++];
        } else{
          return;
        }
      //if (currentIndex < )


    });
  }
  void _dicrementImageCounter() {
    setState(() {
      if(currentIndex >= list.length){
        list[currentIndex--];
      } else{
        currentIndex = 0;
      }

    });
  }


  @override
  void initState() {

    //_date = DateTime.now().toString().split(' ').first;
    print(DateTime.now().subtract(Duration(days:1)).toString().split(' ').first);
    print(DateTime.now());
    print(_date);
    _chartData = getChartData();
    //_currentDate(DateTime.now());
    _currentDate (_date, currentDateTime);
    //_header();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(bottom: 10, top: 10),

          child: ListView(
            children: [
              appView(header, _currentDate),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              glassCard(_counter,context,_decrincrementCounter,
                  _dicrementImageCounter, list,currentIndex,_incrementCounter,
                  _incrementImageCounter),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                margin: EdgeInsets.only(left:30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Previous data of water intake',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),),
                    Text('Edit',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF2298FC)
                      ),),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

              Container(
                margin: EdgeInsets.only(right:20, left:20),
                child: Card(

                  //color: Color(newData[index]['color']),
                    color: const Color(0xFFE8F3FE),
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
                                color:Color(0xFFE8F3FE), //background color of dropdown button
                                border: Border.all(color: Color(0xFF2C2C2E), width:1), //border of dropdown button
                                borderRadius: BorderRadius.circular(5), //border raiuds of dropdown button

                              ),
                              child: Container(
                                //color: Color(0xFFE8F3FE),
                                decoration: BoxDecoration(
                                  color:Color(0xFFE8F3FE), //background color of dropdown button
                                  border: Border.all(color: Color(0xFF2C2C2E), width:1), //border of dropdown button
                                  borderRadius: BorderRadius.circular(5), //border raiuds of dropdown button

                                ),
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

                                  dataSource: _chartData, xValueMapper: (BMIMeasurement bmi, _) => bmi.week, yValueMapper: (BMIMeasurement bmi, _) => bmi.bmi, color: Color(0xFF2298FC))
                            ],
                            primaryXAxis: CategoryAxis(
                                title: AxisTitle(
                                    text: 'Days',
                                    textStyle: TextStyle(

                                      fontSize: 15,


                                    )
                                ),
                                majorGridLines: const MajorGridLines(width: 0),
                                labelPlacement: LabelPlacement.onTicks),
                            primaryYAxis: NumericAxis(
                                title: AxisTitle(
                                    text: 'No of glasses ( 250 ml each )',
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
              ),
            ],
          )
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
}
class BMIMeasurement {
  BMIMeasurement(this.bmi, this.week);
  final double bmi;
  final double week;
}

Widget appView(header, _currentDate){
  return Stack(
      children: [Row(
          children: [Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Color(0xFFADCBE8))
              // border: Color(0xFFADCBE8)
            ),
            margin: const EdgeInsets.only(left:30, right:30),
            // margin:,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined , color: Color(0xFF002870)),
              onPressed: () {

                print('pressed');
              },
            ),
          ),
            Text(header, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            // Container(
            //     margin: EdgeInsets.only(left: 90),
            //     child: Text('press')),
          ]
      ),
        CalendarAgenda(
          backgroundColor: Colors.white12,
          dateColor: Colors.grey,

          fullCalendar: true,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 140)),
          lastDate: DateTime.now().add(Duration(days: 140)),
          //calendarBackground: Colors.teal,
          onDateSelected: (date) {
            _currentDate (date.toString().split(' ').first, date);
            //_currentDate(date.toString().split(' ').first);
            print(date.toString().split(' ').first);
          },
        ),
      ]
  );
}

Widget glassCard(_counter,context,_decrincrementCounter(),
    _dicrementImageCounter(), list,currentIndex,_incrementCounter(),
    _incrementImageCounter()) {
  return Container(
    margin: EdgeInsets.only(right:20, left:20),
    child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              children: [Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$_counter of 9 Glasses',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('500ml/2l')
                ],
              ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),

                  child:  SizedBox(
                    height: 5,
                    child: LinearProgressIndicator(
                      value: (_counter/9), // percent filled
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2298FC)),
                      backgroundColor: Color(0xFF17CA94).withOpacity(0.1),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height:40,
                        child: FloatingActionButton(
                          onPressed: () =>{
                            _decrincrementCounter(),
                            _dicrementImageCounter()
                          },
                          tooltip: 'Decrement',
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      //Image.asset('assets/images/glass-of-water.png', height:120, width:120),
                      list[currentIndex],
                      SizedBox(
                        height:40,
                        child: FloatingActionButton(
                          //onPressed: _incrementCounter,
                          onPressed: () =>{
                            _incrementCounter(),
                            _incrementImageCounter()
                          },
                          tooltip: 'Increment',
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ]
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text('$_counter glass = 250 ml')

              ]
          ),
        )
    ),
  );
}