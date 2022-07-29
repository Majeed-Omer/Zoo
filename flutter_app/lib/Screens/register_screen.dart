import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:flutter_session/flutter_session.dart';

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
  bool _isLoggedIn = false;
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
              builder: (BuildContext context) => Wrapper(),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Registration',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                  
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
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
        
                Text("-----------------------------OR--------------------------------"),
        
                SizedBox(height: 20,),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(child: Image.asset('assets/facebook_image.jpg', width: 30, height: 30), onTap: (){FacebookAuth.instance.login(
                      permissions: ["public_profile", "email"]).then((value) {
                    FacebookAuth.instance.getUserData().then((userData) async {
                      setState(() {
                        _isLoggedIn = true;
                        _userObj = userData;
        
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Wrapper(),
                        ));
                         
                      });
                    });
                  });},),
                    InkWell(child: Image.asset('assets/google_image.png', width: 30, height: 30), onTap: (){print("mom");},),
                    InkWell(child: Image.asset('assets/Instagram_image.jpg', width: 30, height: 30), onTap: (){print("mom");},),
                    InkWell(child: Image.asset('assets/twitter_image.png', width: 30, height: 30), onTap: (){print("mom");},),
                  ],
                ),
        
                SizedBox(height: 40,),
        
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const LoginScreen(),
                        ));
                  },
                  child: const Text(
                    'already have an account',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
      
    );
  }
}
