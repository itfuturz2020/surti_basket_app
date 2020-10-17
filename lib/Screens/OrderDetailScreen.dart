import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/OrderDetailComponent.dart';

class OrderDetailScreen extends StatefulWidget {
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List OrderDetailList = [];
  String CustomerId;
  bool isorderLoading = false;

  @override
  void initState() {
    setState(() {
      _getorderhistorydetail();
      getlocaldata();
    });
  }

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CustomerId = await preferences.getString(Session.customerId);
  }

  _getorderhistorydetail() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isorderLoading = true;
        });
        FormData body = FormData.fromMap({"OrderId": "74"});
        print(body.fields);
        Services.postforlist(apiname: 'orderHistoryDetail', body: body).then(
            (responselist) async {
          setState(() {
            isorderLoading = false;
          });
          if (responselist.length > 0) {
            setState(() {
              OrderDetailList = responselist;
            });
          } else {
            Fluttertoast.showToast(msg: "Data Not Found!");
          }
        }, onError: (e) {
          setState(() {
            isorderLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 1,
        title: Text("Order Detail",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: OrderDetailList.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderDetailComponent(
              orderDetaildata: OrderDetailList[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
    );
  }
}
