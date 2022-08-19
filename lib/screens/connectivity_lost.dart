// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';



class OfflineMode extends StatefulWidget {
  const OfflineMode({Key? key}) : super(key: key);
  @override
  _OfflineModeState createState() => _OfflineModeState();
}

class _OfflineModeState extends State<OfflineMode> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:offlineMode() ,
        ));
  }
  offlineMode() => Column(
    children: <Widget>[
      Padding(
        padding:
        const EdgeInsets.only(left: 10, bottom: 15, right: 10, top: 50),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child:
                Image.asset('assets/images/connectivity-error.png'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                'Connection Error',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff242526),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                'Something went wrong\n try again later',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
      )
    ],
  );
}

