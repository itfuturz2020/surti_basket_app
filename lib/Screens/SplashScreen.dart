import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Screens/HomeScreen.dart';
import 'package:surti_basket_app/Screens/LoginScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String phoneNumber = prefs.getString(Session.CustomerPhoneNo);
      if (phoneNumber == null) {
        Navigator.pushReplacement(context, FadeRoute(page: LoginScreen()));
      } else {
        Navigator.pushReplacement(context, FadeRoute(page: HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
           child: Image.asset('assets/surati_basket_logo.png'),
      ),
    );
  }
}
