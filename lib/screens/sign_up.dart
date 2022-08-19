import 'dart:async';
import 'dart:convert';
import 'utils/globals.dart' as globals;
import 'utils/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'connectivity_lost.dart';
import 'login.dart';




class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);


  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isNetworkAvailable = true;
  late StreamSubscription _connectivitySubscription;
  var _isSubmitted = false;
  bool isTokenAvailable=false;
  final formKey = GlobalKey<FormState>();
  var isLoading = false;
  late String name, email, password, confirmPassword;
  late String? confirmPass;
  String errorMessage = '';
  bool _passwordVisible = true;
  bool _confirmpasswordVisible = true;
  final storage = const FlutterSecureStorage();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    _confirmpasswordVisible = false;
    super.initState();
    offlinemode();
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        body: isNetworkAvailable? Padding(
          padding: MediaQuery.of(context).padding.add(const EdgeInsets.fromLTRB(30, 0, 30, 30)),
          child: Container(
          // decoration: const BoxDecoration(
          //   color: Colors.green
          // ),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [

                  Image.asset('assets/images/sports-analytics-logo.png',
                    width: 200,
                    height: 70,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  const Center(
                      child: Text('Sign Up',
                          style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold))
                  ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
                  Form(
                        key: formKey ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:  <Widget>[

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                              child: TextFormField(
                                controller: nameController,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                onSaved: (val) {
                                  name = val!;
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(borderSide:  BorderSide(color: Color(0xFF2298FC))),
                                    hintText: 'Enter name',
                                    prefixIcon: Padding(
                                      padding: EdgeInsetsDirectional.only(end: 42.0, start: 12.0),
                                      child: Icon(Icons.person_outline_outlined, color: Color(0xFF2298FC),) , // myIcon is a 48px-wide widget.
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.5, color: Color(0xFF2298FC)),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Name',
                                  labelStyle: TextStyle(
                                    color: Color(0xffB1B3B7)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"([a-zA-Z])")
                                          .hasMatch(value)) {
                                    return 'Please enter a valid name!';
                                  }
                                  return null;
                                },
                              ),
                              ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),    //
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                              child: TextFormField(
                                controller: emailController,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                onSaved: (val) {
                                  email = val!;
                                },
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide:  BorderSide(color: Color(0xFF2298FC))),
                                  hintText: 'Enter Email',
                                  //prefixIcon: Icon(Icons.mail_outline, color: Color(0xFF2298FC),)
                                  prefixIcon: Padding(
                                    padding: EdgeInsetsDirectional.only(end: 42.0, start: 12.0),
                                    child: Icon(Icons.mail_outline, color: Color(0xFF2298FC),) , // myIcon is a 48px-wide widget.
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5, color: Color(0xFF2298FC)),




                                  ),
                                  border: OutlineInputBorder(),
                                    labelText: 'Enter Email',
                                    labelStyle: TextStyle(
                                        color: Color(0xffB1B3B7)),
                                ),
                                validator: (value){
                                  if(value!.isEmpty) {
                                    return "email can't be blank";
                                  } else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\-#$%*!&\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
                                    return "Enter correct email id";
                                  } else{
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                            ),
    // ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                              child: TextFormField(
                                controller: passwordController,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                  onSaved: (val) {
                                    password = val!;
                                  },
                                obscureText: !_passwordVisible,//This will obscure text dynamically
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(borderSide:  BorderSide(color: Color(0xFF2298FC))),
                                  hintText: 'Enter Password',
                                  prefixIcon: const Padding(
                                    padding: EdgeInsetsDirectional.only(end: 42.0, start: 12.0),
                                    child: Icon(Icons.lock_outline, color: Color(0xFF2298FC),) , // myIcon is a 48px-wide widget.
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5, color: Color(0xFF2298FC)),



                                  ),
                                  border: const OutlineInputBorder(),
                                    labelText: 'Enter Password',
                                    labelStyle: const TextStyle(
                                        color: Color(0xffB1B3B7)),

                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black38,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  confirmPass = value;
                                  if (value!.isEmpty ||
                                      !RegExp(
                                          r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
                                          .hasMatch(value)) {
                                    return 'Required min 8 characters ,1 uppercase, 1 special character'
                                        ;
                                  } else if (value.length <= 8) {
                                    return "Password must be atleast 8 characters long"
                                        ;
                                  } else {
                                    return null;
                                  }
                                }

                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onSaved: (val) {
                                  confirmPassword = val!;
                                },
                                obscureText: !_confirmpasswordVisible,//This will obscure text dynamically
                                decoration: InputDecoration(
                                  // hintText: 'Enter your password',
                                  enabledBorder: const OutlineInputBorder(borderSide:  BorderSide(color: Color(0xFF2298FC))),
                                  hintText: 'Confirm Password',
                                  prefixIcon: const Padding(
                                    padding: EdgeInsetsDirectional.only(end: 42.0, start: 12.0),
                                    child: Icon(Icons.lock_outline, color: Color(0xFF2298FC),) , // myIcon is a 48px-wide widget.
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5, color: Color(0xFF2298FC)),



                                  ),
                                  border: const OutlineInputBorder(),
                                    labelText: 'Confirm Password',
                                    labelStyle: const TextStyle(
                                        color: Color(0xffB1B3B7)),
                                  // Here is key idea
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _confirmpasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black38,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _confirmpasswordVisible = !_confirmpasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
                                            .hasMatch(value)) {
                                      return 'Password and confirm password doesn’t match';
                                    } else if (value.length <= 8) {
                                      return "Password and confirm password doesn’t match";
                                    } else if (value != confirmPass) {
                                      return "Password and confirm password doesn’t match";
                                    } else {
                                      return null;
                                    }
                                  }
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
    //
    //

    //
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Color(0xFF002870)),
                                ), onPressed: () {
                                print("Pressed");
                                if ((formKey.currentState!.validate())) {
                                  signup(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      confirmPasswordController.text);
                                }
                              },
                                child:  isLoading? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text('Creating Account...    ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Poppins-Medium'
                                      ),),
                                    SizedBox(
                                      height: 20.0,
                                      width: 20.0,
                                      child: CircularProgressIndicator(color: Colors.white,),
                                    ),
                                  ],
                                ) :
                                const Text('Create Account',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                      fontFamily: 'Poppins-Medium'
                                  ),),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.01,
                            ),
                            const Center(
                              child: Text(
                                'OR',
                                style: TextStyle(
                                    color: Color(0xff3A3B3C),
                                    fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(Color(0xFF2298FC)),
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
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextButton(
              onPressed: () { Navigator.pushNamed(context, '/login'); },
              child: const Text('Already a Member ? Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF48474A),)
              )
            )
           ],
          ),
         )])
          ),
        ) : const OfflineMode(),// body:
    );
  }
  void showToastMessage(String message){
    Fluttertoast.showToast(
      msg: errorMessage, //message to show toast//duration for message to show
      gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
      timeInSecForIosWeb: 1, //for iOS only
      backgroundColor: Colors.red, //background Color for message
      textColor: Colors.white, //message text color
      fontSize: 16.0, //message font size
      toastLength: Toast.LENGTH_SHORT,
    );
  }
  signup(name, email, password, confirmpassword) async {
    setState(() {
      isLoading = true;
      errorMessage = errorMessage;
    });
    Map data = {
      'email': email,
      'password': password,
      'name': name,
      'confirmpassword': confirmpassword
    };
    String locale= 'es';
    String languageUrl='$REGISTRATION?language=$locale';
    debugPrint('.............$languageUrl');
    http.post(Uri.parse(languageUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"))
        .then((response) {
      if (response.statusCode == 200) {
        print('........TEst${response.body}');

        setState(() {
          isLoading = false;
          _isSubmitted=false;
          errorMessage = json.decode(response.body)['message'];
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        Fluttertoast.showToast(
            msg: "Account created successfully".tr,
            backgroundColor: Colors.green,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white);
        Map<String, dynamic> resposne = jsonDecode(response.body);
      } else {
        setState(() {
          errorMessage = json.decode(response.body)['message'];
          _isSubmitted=false;
          showToastMessage("");
        });
        if(errorMessage.isNotEmpty){
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }
  offlinemode()
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
  writeToStorage(key, value) async {
    await storage.write(key: key, value: value);
  }
  globalToken() {
    print('globaltokestart');
    if(globals.token=='')
    {
      print('globaltokestartIF');
      print({globals.token});
      setState(() {
        isTokenAvailable=true;
      });
      print('......if${isTokenAvailable}');
    }
    else
    { print('globaltokestartELSE');
    print('.........elsetoken${globals.token}');
    setState(() {
      isTokenAvailable=false;
    });
    print('......else${isTokenAvailable}');
    }
  }


}



