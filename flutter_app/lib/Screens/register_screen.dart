import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo/Screens/login_screen.dart';
import 'package:zoo/Services/auth_services.dart';
import 'package:zoo/Services/globals.dart';
import 'package:zoo/widgets/rounded_button.dart';
import 'package:zoo/widgets/wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _name = '';
  Map _userObj = {};

  createAccountPressed() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (emailValid) {
      http.Response response =
          await AuthServices.register(_name, _email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isLoggedIn", true);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Wrapper(email: _userObj["email"], name: _userObj["name"], image: '',),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Registration',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          toolbarHeight: (h + w) / 15,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 15.sp)),
                    onChanged: (value) {
                      _name = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 15.sp)),
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 15.sp)),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundedButton(
                    btnText: 'Create Account',
                    onBtnPressed: () => createAccountPressed(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "-----------------------------OR--------------------------------",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Image.asset('assets/facebook_image.jpg',
                            width: w / 10, height: h / 10),
                        onTap: () {
                          FacebookAuth.instance.login(permissions: [
                            "public_profile",
                            "email"
                          ]).then((value) {
                            FacebookAuth.instance
                                .getUserData()
                                .then((userData) async {
                              setState(() async {
                                _userObj = userData;
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                preferences.setBool("isLoggedIn", true);
                                preferences.setString("name", _userObj["name"]);
                                preferences.setString("email", _userObj["email"]);
                                preferences.setString("image", _userObj["picture"]["data"]["url"]);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => 
                                          Wrapper(email: _userObj["email"], name: _userObj["name"], image: _userObj["picture"]["data"]["url"]),
                                          
                                    ));
                              });
                            });
                          });
                        },
                      ),
                      InkWell(
                        child: Image.asset('assets/google_image.png',
                            width: w / 10, height: h / 10),
                        onTap: () {
                          print("mom");
                        },
                      ),
                      InkWell(
                        child: Image.asset('assets/Instagram_image.jpg',
                            width: w / 10, height: h / 10),
                        onTap: () {
                          print("mom");
                        },
                      ),
                      InkWell(
                        child: Image.asset('assets/twitter_image.png',
                            width: w / 10, height: h / 10),
                        onTap: () {
                          print("mom");
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginScreen(),
                          ));
                    },
                    child: Text(
                      'already have an account',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
