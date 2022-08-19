import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import'utils/storage_handler.dart';
import 'package:http/http.dart' as http;
import 'connectivity_lost.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'utils/globals.dart' as globals;
import 'utils/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isNetworkAvailable = true;
  late StreamSubscription _connectivitySubscription;
  String message = '';
  bool emailValidated = true;
  var isLoading = false;
  var _isSubmitted = false;
  bool _showPassword = false;
  String errorMessage = '';
  late String email, password;
  final storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isTokenAvailable = false;

  get user => {
    email: 'Suraj@gmai;.com',
  };

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    offlineMode();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        body: isNetworkAvailable? Padding(
          padding: MediaQuery
              .of(context)
              .padding
              .add(const EdgeInsets.fromLTRB(30, 0, 30, 30)),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
                children: [

                  Image.asset('assets/images/sports-analytics-logo.png',
                    width: 200,
                    height: 70,
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1,
                  ),
                  const Center(
                      child: Text('LogIn',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.06,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.09,
                          child: TextFormField(
                            controller: emailController,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (val) {
                              email = val!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email can't be blank";
                              } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\-#$%*!&\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value)) {
                                return "Enter correct email id";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF2298FC))),
                              hintText: 'Enter Email',
                              prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(
                                    end: 42.0, start: 12.0),
                                child: Icon(Icons.mail_outline, color: Color(
                                    0xFF2298FC),), // myIcon is a 48px-wide widget.
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xFF2298FC)),


                              ),
                              border: OutlineInputBorder(),


                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01,
                        ),

                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.09,
                          child: TextFormField(
                            obscureText: _showPassword,
                            controller: passwordController,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (val) {
                              password = val!;
                            },
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(
                                      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
                                      .hasMatch(value)) {
                                return 'Required min 8 characters ,1 uppercase, 1 special character';
                              } else if (value.length <= 8) {
                                return "Password must be atleast 8 characters long";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(
                                          () => _showPassword = !_showPassword);
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF2298FC))),
                              hintText: 'Enter Password',
                              prefixIcon: const Padding(
                                padding: EdgeInsetsDirectional.only(
                                    end: 42.0, start: 12.0),
                                child: Icon(Icons.lock_outline, color: Color(
                                    0xFF2298FC),), // myIcon is a 48px-wide widget.
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xFF2298FC)),


                              ),
                              border: const OutlineInputBorder(),

                            ),
                          ),
                        ),


                        TextButton(
                          onPressed: () {
                            print('pressed');
                          },

                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Color(0xFF48474A),
                                fontSize: 13,),

                            ),
                          ),

                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                        ),


                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF002870)),
                          ), onPressed: () {
                          if ((_formKey.currentState!.validate())) {
                            login(emailController.text,
                                passwordController.text);
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'LogIn',

                              style: TextStyle(color: Colors.white,
                                  fontSize: 16),

                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                        ),
                        const Center(
                            child: Text('OR')
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                        ),

                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                const Color(0xFF2298FC)),
                          ), onPressed: () {
                          print("Pressed");
                        },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Continue With Google',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text('New User? SignUp',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF48474A)),)
                        )
                      ],
                    ),
                  ),


                ]),

          ),
        ):const OfflineMode(),
    );
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: errorMessage,
      //message to show toast//duration for message to show
      gravity: ToastGravity.BOTTOM,
      //where you want to show, top, bottom
      timeInSecForIosWeb: 1,
      //for iOS only
      backgroundColor: Colors.red,
      //background Color for message
      textColor: Colors.white,
      //message text color
      fontSize: 16.0,
      //message font size
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  writeToStorage(key, value) async {
    await storage.write(key: key, value: value);
  }

  login(email, password) async {
    setState(() {
      isLoading = true;
      errorMessage = errorMessage;
    });
    Map data = {
      'email': email,
      'password': password,
    };
    String locale = Get.locale.toString() == 'en_US' ? 'en' : 'en';
    String languageUrl = '$LOGIN?language=$locale';
    debugPrint('.............$languageUrl');
    var headersList = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    var httpRequest = http.Request('POST', Uri.parse(languageUrl));
    httpRequest.headers.addAll(headersList);
    httpRequest.body = json.encode(data);

    var response = await httpRequest.send();
    final responseBody = await response.stream.bytesToString();
    {
      if (response.statusCode == 200) {
        print(responseBody);
        setState(() {
          isLoading = false;
          _isSubmitted = false;
        });
        Navigator.pushNamed(context, '/spashscreen');
        String storageValue = "${json.decode(responseBody)['token']}";
        writeToStorage(key, value) async {
          await storage.write(key: key, value: value);
        }

        writeToStorage("token", storageValue);
        await writeStorage("idToken", storageValue.toString());
        String readValue = "${json.decode(responseBody)['token']}";
        globals.token = readValue;
      } else {
        setState(() {
          errorMessage = json.decode(responseBody)['message'];
          _isSubmitted = false;
          showToastMessage("");
        });
        if (errorMessage.isNotEmpty) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  globalToken() {
    print('globaltokestart');
    if (globals.token == '') {
      print('globaltokestartIF');
      print({globals.token});
      setState(() {
        isTokenAvailable = true;
      });
      print('......if${isTokenAvailable}');
    }
    else {
      print('globaltokestartELSE');
      print('.........elsetoken${globals.token}');
      setState(() {
        isTokenAvailable = false;
      });
      print('......else${isTokenAvailable}');
    }
  }

  googleLogin(Map data) async {
    if (data['name'] != null) {
      var database = json.encode(data);
      print('................Database$database');
      http.post(Uri.parse(
          'https://d0d4ogh6t3.execute-api.us-west-2.amazonaws.com/dev/google-login'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: database,
          encoding: Encoding.getByName("utf-8"))
          .then((response) {
        if (response.statusCode == 200) {
          Navigator.pushNamed(context, '/login');
          print(response.body);
          String storageValue = "${json.decode(response.body)['token']}";
          writeToStorage("token", storageValue);
          writeStorage('idToken', storageValue.toString());
          globals.token = "${json.decode(response.body)['token']}";
        } else {}
      });
    }
    else {
      setState(() {
        isTokenAvailable = false;
      });
    }
  }
  offlineMode()
  {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        ConnectivityResult result
        ) {
      if(result.toString().split('.').last != 'none')
      {
        setState(() {
          isNetworkAvailable=true;
        });
      }
      else
      {
        setState(() {
          isNetworkAvailable=false;
        });
      }
    });

  }
  String toValue() {
    return toString().split('.').last;
  }
}