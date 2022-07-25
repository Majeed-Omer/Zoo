import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo/Screens/register_screen.dart';
import 'package:zoo/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:native_notify/native_notify.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(
      1220,
      '1Exwx7C8rNyFewTJYYbx06',
      'AAAADvD_G9Y:APA91bHT0SJ8_dDFgSX_3VpTxmSkfLXLLPKIFOuPn6nyOsZArSiqKj4GCwbDocN1y9X_3vtrHrbjGC4x2Ncr5fxDiO_K0kpy8f9xY1zZ0WnauuqkdGVvKB_GkOt61xGAJWbDAD-8BDZ6',
      null);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var status = preferences.getBool("isLoggedIn") ?? false;
  //WidgetsFlutterBinding.ensureInitialized();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
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
// @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 //channel.description,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher',
//               ),
//             ));
//       }
//     });

//     // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     //   print('A new onMessageOpenedApp event was published!');
//     //   RemoteNotification? notification = message.notification;
//     //   AndroidNotification? android = message.notification?.android;
//     //   if (notification != null && android != null) {
//     //     showDialog(
//     //         context: context,
//     //         builder: (_) {
//     //           return AlertDialog(
//     //             title: Text(notification.title!),
//     //             content: SingleChildScrollView(
//     //               child: Column(
//     //                 crossAxisAlignment: CrossAxisAlignment.start,
//     //                 children: [Text(notification.body!)],
//     //               ),
//     //             ),
//     //           );
//     //         });
//     //   }
//     // });
//   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}
