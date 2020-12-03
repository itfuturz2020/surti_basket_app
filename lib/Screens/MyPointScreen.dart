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
  List pointsData = [];
  MyPointScreen({this.pointsData});

  @override
  _MyPointScreenState createState() => _MyPointScreenState();
}

class _MyPointScreenState extends State<MyPointScreen> {
  bool isPointsLoading = false;
  List pointsList = [];
  String CustomerId;

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
              itemCount: widget.pointsData.length,
              itemBuilder: (BuildContext context, int index) {
                return MyPointsComponent(
                  pointsdata: widget.pointsData[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) => Container(
                color: Colors.white,
                height: 10,
              ),
            ),
    );
  }
}
