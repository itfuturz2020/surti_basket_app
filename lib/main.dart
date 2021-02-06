import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Screens/SplashScreen.dart';

import 'Providers/CartProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
    );

    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      showNotification(
          message["notification"]["title"], message["notification"]["body"]);
      print("onMessage");
      print(message);
    }, onResume: (Map<String, dynamic> message) {
      print("onResume");
      print(message);
    }, onLaunch: (Map<String, dynamic> message) {
      print("onLaunch");
      print(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surti Basket',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Lato',
          cursorColor: Colors.black54,
          primaryColor: appPrimaryMaterialColor,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              textTheme: TextTheme(
                  // ignore: deprecated_member_use
                  title: TextStyle(color: Colors.white, fontSize: 16)),
              iconTheme: IconThemeData(color: Colors.white)),
          accentColor: appPrimaryMaterialColor),
    );
  }

  showNotification(String title, String body) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.max, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin
        .show(0, "${title}", "${body}", platform, payload: 'Surti Basket');
  }
}
