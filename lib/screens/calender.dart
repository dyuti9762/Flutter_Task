import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'utils/colors_util.dart';
import 'utils/date_utils.dart' as date_util;

class Calender extends StatefulWidget {
  final String title;
  const Calender({Key? key, required this.title}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();
  }


  Widget titleView() {
    return Container(
      color: Colors.white12,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        date_util.DateUtils.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.day.toString(),
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return Container(
      color: Colors.white12,
      width: width,
      height: 100,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Container(
            width: 60,
            decoration: BoxDecoration(
              color:(currentMonthList[index].day != currentDateTime.day)
                  ? Colors.white12
                  : HexColor("E8F3FE"),
                // gradient: LinearGradient(
                //     colors: (currentMonthList[index].day != currentDateTime.day)
                //         ? [
                //       Colors.white,
                //       Colors.white,
                //       Colors.white
                //     ]
                //         : [
                //       HexColor("E8F3FE"),
                //       HexColor("E8F3FE"),
                //       HexColor("E8F3FE")
                //     ],
                //     begin: const FractionalOffset(0.0, 0.0),
                //     end: const FractionalOffset(0.0, 1.0),
                //     stops: const [0.0, 0.5, 1.0],
                //     tileMode: TileMode.clamp),
               // borderRadius: BorderRadius.circular(10),
                //boxShadow: const [
                  // BoxShadow(
                  //   offset: Offset(4, 4),
                  //   blurRadius: 4,
                  //   spreadRadius: 2,
                  //   color: Colors.black12,
                  // )
              //]
                ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                        color:
                        (currentMonthList[index].day != currentDateTime.day)
                            ? Colors.black
                            : Colors.black),
                  ),
                  Text(
                    date_util.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                        color:
                        (currentMonthList[index].day != currentDateTime.day)
                            ? Colors.black
                            : Colors.black),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget topView() {
    return Container(
      height: height * 0.35,
      width: width,
      decoration: BoxDecoration(


        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            titleView(),
            hrizontalCapsuleListView(),
          ]),
    );
  }

  // Widget floatingActionBtn() {
  //   return Align(
  //     alignment: Alignment.bottomRight,
  //     child: FloatingActionButton(
  //       child: Container(
  //         width: 100,
  //         height: 100,
  //         child: const Icon(
  //           Icons.add,
  //           size: 30,
  //         ),
  //         decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             gradient: LinearGradient(
  //                 colors: [
  //                   HexColor("ED6184"),
  //                   HexColor("EF315B"),
  //                   HexColor("E2042D")
  //                 ],
  //                 begin: const FractionalOffset(0.0, 0.0),
  //                 end: const FractionalOffset(0.0, 1.0),
  //                 stops: const [0.0, 0.5, 1.0],
  //                 tileMode: TileMode.clamp)),
  //       ),
  //       onPressed: () {
  //         controller.text = "";
  //         showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return Dialog(
  //                 backgroundColor: Colors.black87,
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(20)),
  //                 child: Container(
  //                   height: 200,
  //                   width: 320,
  //                   padding: EdgeInsets.all(12),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                       const Text(
  //                         "Add Todo",
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       const SizedBox(
  //                         height: 30,
  //                       ),
  //                       TextField(
  //                         controller: controller,
  //                         style: const TextStyle(color: Colors.white),
  //                         autofocus: true,
  //                         decoration: const InputDecoration(
  //                             hintText: 'Add your new todo item',
  //                             hintStyle: TextStyle(color: Colors.white60)),
  //                       ),
  //                       const SizedBox(
  //                         height: 20,
  //                       ),
  //                       SizedBox(
  //                         width: 320,
  //                         child: ElevatedButton(
  //                           onPressed: () {
  //                             setState(() {
  //                               todos.add(controller.text);
  //                             });
  //                             Navigator.of(context).pop();
  //                           },
  //                           child: const Text("Add Todo"),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             });
  //       },
  //     ),
  //   );
  // }

  // Widget todoList() {
  //   return Container(
  //     margin: EdgeInsets.fromLTRB(10, height * 0.38, 10, 10),
  //     width: width,
  //     height: height * 0.60,
  //     child: ListView.builder(
  //         itemCount: todos.length,
  //         padding: EdgeInsets.zero,
  //         itemBuilder: (BuildContext context, int index) {
  //           return Container(
  //             margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
  //             width: width - 20,
  //             height: 70,
  //             decoration: BoxDecoration(
  //                 color: Colors.white54,
  //                 borderRadius: BorderRadius.circular(20),
  //                 boxShadow: const [
  //                   BoxShadow(
  //                       color: Colors.white12,
  //                       blurRadius: 2,
  //                       offset: Offset(2, 2),
  //                       spreadRadius: 3)
  //                 ]),
  //             child: Center(
  //               child: Text(
  //                 todos[index],
  //                 style: const TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            topView(),
            //todoList()
          ],
        )
        );
  }
        //floatingActionButton: floatingActionBtn());

}