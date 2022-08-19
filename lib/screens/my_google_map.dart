import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:get/get.dart';
import 'utils/location_controller.dart';
import 'splash_screen.dart';
import 'utils/location_search_dialouge.dart';


class MyGoogleMap extends StatefulWidget{
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.5006, 88.3598),
    zoom: 14.4746,

  );
  Completer<GoogleMapController> _controller = Completer();
  Widget appBarTitle = new Text("Sports Analytics");
  Icon actionIcon = new Icon(Icons.search);
  TextEditingController _searchController = TextEditingController();
  GoogleMapController? mapController;
  GoogleMapController? mapController2;//contrller for Google map
  final Set<Marker> markers = {};
  double lat = 0;
  double lang = 0; //markers for google map
  static const LatLng showLocation = LatLng(22.5006, 88.3598);
 // LatLng varLocation = LatLng(lat, lang);
  //
  //location to show in map

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return  Scaffold(
        // appBar: AppBar(
        //     centerTitle: true,
        //     title:appBarTitle,
        //     actions: <Widget>[
        //       IconButton(icon: actionIcon,onPressed:(){
        //         setState(() {
        //           if ( actionIcon.icon == Icons.search){
        //             actionIcon = const Icon(Icons.close);
        //             appBarTitle = TextFormField(
        //               controller: _searchController,
        //               style: TextStyle(
        //                 color: Colors.white,
        //
        //               ),
        //               decoration: InputDecoration(
        //                   prefixIcon: Icon(Icons.search,color: Colors.white),
        //                   hintText: "Search by city",
        //                   hintStyle: TextStyle(color: Colors.white)
        //               ),
        //               onChanged: (value) {
        //                 print(value);
        //               },
        //             );}
        //           else {
        //             actionIcon = const Icon(Icons.search);
        //             appBarTitle = const Text("Sports Analytics");
        //           }
        //
        //
        //         });
        //       } ,),]
        // ),
        resizeToAvoidBottomInset: false,
      body:Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers:
                getmarkers(),
            ),
            buildFloatingSearchBar(context, _searchController, LocationController(),mapController),
            //buildFloatingSearchBar2(context, _searchController, LocationController(),mapController, searchByLatLon(location)),
        Positioned(
          top: 200,
          left: 10, right: 20,
          child: GestureDetector(
            onTap:() {
              Get.dialog(LocationSearchDialog(mapController: mapController));
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Row(children: [
                Icon(Icons.location_on, size: 25, color: Theme.of(context).primaryColor),
                SizedBox(width: 3),
                //here we show the address on the top
                Expanded(
                    child:
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'search by Lat Lon like 22.5881, 88.4082',
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),

                    )
                ),
                SizedBox(width: 10),
                IconButton(
                    icon: Icon(Icons.search),
                  iconSize: 25,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  onPressed: () async {
                      var userInput = _searchController.text;
                      lat = double.parse(userInput.toString().split(',').first);
                      print(lat);
                      lang = double.parse(userInput.toString().split(',').last);
                      print(lang);
                    LatLng varLocation = await LatLng(lat, lang);
                    print(varLocation);
                      //MyMap(varLocation);
                    // searchByLatLon(lat, lang);
                    _goToPlace(lat,lang);

                  },),
              ]),
            ),
          ),
        )
          ])
    );
  }

  // Widget MyMap(showLocation) {
  //   return GoogleMap( //Map widget from google_maps_flutter package
  //     zoomGesturesEnabled: true, //enable Zoom in, out on map
  //     initialCameraPosition:  CameraPosition( //innital position in map
  //       target: showLocation, //initial position
  //       zoom: 12.0, //initial zoom level
  //     ),
  //     markers: getmarkers(), //markers to show on map
  //     mapType: MapType.normal, //map type
  //     onMapCreated: (controller) { //method called when map is created
  //       setState(() {
  //         mapController = controller;
  //       });
  //     },
  //   );
  // }

  Future<void>_goToPlace(lat,lang) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(lat, lang), zoom:12)
        )
    );

  }
  Set<Marker>
  getmarkers() {
     setState(() {
      markers.add(
          Marker(
            zIndex: 2,
            onTap: (){
              debugPrint('MarkerInside');
        },
        markerId: MarkerId(showLocation.toString()),
        position: showLocation,
        infoWindow: InfoWindow(
          title: 'South City Mall',

          onTap: (){
            debugPrint('MarkerInside2');
          }

        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      )
      );

      markers.add(Marker( //add second marker
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(22.5150, 88.3930),
        // onTap: () {
        //   print('acro');
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => SplashScreen()),
        //   );
        // }, //position of marker
        infoWindow: InfoWindow(//popup info
          title: 'Acropolis Mall',
            onTap: () {
              print('acro');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
              // InfoWindow clicked
            }


        ),
          //snippet: 'My Custom Subtitle',

        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      )
      );

      markers.add(Marker( //add third marker
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(22.5163, 88.3491), //position of marker
        infoWindow: const InfoWindow( //popup info
          title: 'Lake Mall Mall',
          //snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add fourth marker
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(22.5390, 88.3658), //position of marker
        infoWindow: const InfoWindow( //popup info
          title: 'Quest Mall',
          //snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add fourth marker
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(22.5881, 88.4082), //position of marker
        infoWindow: const InfoWindow( //popup info
          title: 'City Centre',
          //snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here 
    });

    return markers;
  }
}

Widget buildFloatingSearchBar(context, _searchController, locationController, _mapController) {
  //final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return Positioned(
    top: 35,
    left: 10, right: 20,
    child: GestureDetector(
      onTap:() {
        Get.dialog(LocationSearchDialog(mapController: _mapController));
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(50)),
        child: Row(children: [
          Icon(Icons.location_on, size: 25, color: Theme.of(context).primaryColor),
          SizedBox(width: 3),
          //here we show the address on the top
          Expanded(
            child: Text(
              '${locationController.pickPlaceMark.name ?? ''} ${locationController.pickPlaceMark.locality ?? ''} '
                  '${locationController.pickPlaceMark.postalCode ?? ''} ${locationController.pickPlaceMark.country ?? ''}',
              style: TextStyle(fontSize: 20),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.search, size: 25, color: Theme.of(context).textTheme.bodyText1!.color),
        ]),
      ),
    ),
  );
}


Widget buildFloatingSearchBar2(context, _searchController, locationController, _mapController) {
  //final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return Positioned(
    top: 200,
    left: 10, right: 20,
    child: GestureDetector(
      onTap:() {
        Get.dialog(LocationSearchDialog(mapController: _mapController));
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(50)),
        child: Row(children: [
          Icon(Icons.location_on, size: 25, color: Theme.of(context).primaryColor),
          SizedBox(width: 3),
          //here we show the address on the top
          Expanded(
            child:
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'search by Lat Lon like 22.5881, 88.4082',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  String location = '';
                  double latu;
                  location = value;
                  latu = double.parse(value.toString().split(',').first);
                  //print(latu);


                  //print(value);
                },
              )
            // Text(
            //   '${locationController.pickPlaceMark.name ?? ''} ${locationController.pickPlaceMark.locality ?? ''} '
            //       '${locationController.pickPlaceMark.postalCode ?? ''} ${locationController.pickPlaceMark.country ?? ''}',
            //   style: TextStyle(fontSize: 20),
            //   maxLines: 1, overflow: TextOverflow.ellipsis,
            // ),
          ),
          SizedBox(width: 10),
          Icon(Icons.search, size: 25, color: Theme.of(context).textTheme.bodyText1!.color),
        ]),
      ),
    ),
  );
}