import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/language.dart';
import 'screens/utils/languages.dart';
import 'screens/home.dart';
import 'screens/sign_up.dart';
import 'screens/water_intake.dart';
import 'screens/map.dart';
import 'screens/water_intake.dart';
import 'screens/home.dart';
import 'screens/track_progress.dart';
import 'screens/explore_cards.dart';
import 'screens/login.dart';
import 'screens/splash_screen.dart';
import 'screens/utils/myAccount.dart';
import 'screens/explore_cards.dart';
import 'screens/my_google_map.dart';
import 'screens/manage_player.dart';
import 'screens/scanner.dart';
import 'screens/generate_qr.dart';
import 'screens/save_qr.dart';
import 'package:dart_ping/dart_ping.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyAccount(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/signup': (context) => const SignUp(),
        '/login': (context) => const LoginScreen(),
        '/spashscreen': (context) => const SplashScreen(),
        '/waterIntake': (context) => const WaterIntake(),
        '/trackProgress': (context) => const TrackProgress(),
        '/myaccount': (context) => const MyAccount(),
        '/explorecards': (context) =>  ExploreCards(),
        '/map': (context) =>  MyGoogleMap(),
        '/QR_generator': (context) => GenerateQR(),
        '/scanner': (context) => ScanQrPage(),
        '/generate' : (context) => GenerateQR(),
      },
      //home: SignUp(),
      //home: LoginScreen(),
      //home: WaterIntake(),
      //home: Home(),
      //home: MapSample(),
      //home: ExploreCards(),
      //home: TrackProgress(),
      translations: LocaleString(),
      locale: const Locale('en','US'),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
    );
  }
}