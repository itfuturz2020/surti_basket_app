import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Screens/HomeScreen.dart';
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
       statusBarIconBrightness: Brightness.light
    ));
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
              title: TextStyle(color: Colors.white,fontSize: 16)
            ),
            iconTheme: IconThemeData(color: Colors.white)
          ),
          accentColor: appPrimaryMaterialColor),
    );
  }
}
