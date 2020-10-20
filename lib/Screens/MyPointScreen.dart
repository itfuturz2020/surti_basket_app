import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/CustomWidgets/MyPointsComponent.dart';

class MyPointScreen extends StatefulWidget {
  @override
  _MyPointScreenState createState() => _MyPointScreenState();
}

class _MyPointScreenState extends State<MyPointScreen> {
  bool isPointsLoading = false;
  List pointsList = [];
  String CustomerId;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CustomerId = await preferences.getString(Session.customerId);
  }

  @override
  void initState() {
    _points();
    getlocaldata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: Text("My Points",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: isPointsLoading == true
          ? LoadingComponent()
          : ListView.separated(
              padding: EdgeInsets.only(top: 10),
              physics: BouncingScrollPhysics(),
              itemCount: pointsList.length,
              itemBuilder: (BuildContext context, int index) {
                return MyPointsComponent(
                  pointsdata: pointsList[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) => Container(
                color: Colors.white,
                height: 10,
              ),
            ),
    );
  }

  _points() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isPointsLoading = true;
        });
        FormData body = FormData.fromMap({"CustomerId": CustomerId});
        print(body.fields);
        Services.postforlist(apiname: 'getBonusPoint', body: body).then(
            (responselist) async {
          setState(() {
            isPointsLoading = false;
          });
          if (responselist.length > 0) {
            setState(() {
              pointsList = responselist;
            });
          } else {
            Fluttertoast.showToast(msg: "Data Not Found!");
          }
        }, onError: (e) {
          setState(() {
            isPointsLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }
}
