import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo/Screens/register_screen.dart';
import 'package:zoo/widgets/wrapper.dart';
import 'package:native_notify/native_notify.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(
      1220,
      '1Exwx7C8rNyFewTJYYbx06',
      'AAAADvD_G9Y:APA91bHT0SJ8_dDFgSX_3VpTxmSkfLXLLPKIFOuPn6nyOsZArSiqKj4GCwbDocN1y9X_3vtrHrbjGC4x2Ncr5fxDiO_K0kpy8f9xY1zZ0WnauuqkdGVvKB_GkOt61xGAJWbDAD-8BDZ6',
      null);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var status = preferences.getBool("isLoggedIn") ?? false;
  
  runApp(MaterialApp(
    home: status == true ? Wrapper() : MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}
