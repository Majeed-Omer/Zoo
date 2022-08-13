import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo/Screens/allAnimals_scrren.dart';
import 'package:zoo/Screens/onBoarding_screen.dart';
import 'package:zoo/Screens/register_screen.dart';
import 'package:zoo/widgets/wrapper.dart';
import 'package:native_notify/native_notify.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "zoo",
      options: FirebaseOptions(
          apiKey: '123',
          appId: '111',
          messagingSenderId: '333',
          projectId: '444'));
  NativeNotify.initialize(
      1220,
      '1Exwx7C8rNyFewTJYYbx06',
      'AAAAVOeUyg8:APA91bHd4TMY-ySexcDP8345MsSLUyBIOkxyr57Rsb7XwB9Y9urIex_Qbuf2i8Gduz3x3rkUSPcuR4W2KkARbyLNYP5SUfyK-6oZizVNJu--XSa4ukPdUbQf_3Pb7E9EdPX7lW28bA7d',
      null);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var status = preferences.getBool("isLoggedIn") ?? false;

  var name = preferences.getString("name") ?? '';
  var email = preferences.getString("email") ?? '';
  var image = preferences.getString("image");

  final showHome = preferences.getBool('showHome') ?? false;

  runApp(MaterialApp(
    home: status == true
        ? Wrapper(email: email, name: name, image: image)
        : showHome
            ? MyApp()
            : onBoarding(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
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
