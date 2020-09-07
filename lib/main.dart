import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Screens/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: appPrimaryMaterialColor,
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
      title: 'Surti Basket',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: appPrimaryMaterialColor,
          accentColor: appPrimaryMaterialColor,
          accentColorBrightness: Brightness.dark),
    );
  }
}
