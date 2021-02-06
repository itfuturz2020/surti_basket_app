import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/CustomWidgets/NoFoundComponent.dart';
import 'package:surti_basket_app/CustomWidgets/Promocodecomponent.dart';

class promoCode extends StatefulWidget {
  @override
  _promoCodeState createState() => _promoCodeState();
}

class _promoCodeState extends State<promoCode> {
  bool isLoading = false;
  List promoCodeList = [];

  @override
  void initState() {
    super.initState();
    getPromoCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Promocode",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: isLoading == true
          ? LoadingComponent()
          : promoCodeList.length > 0
              ? ListView.separated(
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemCount: promoCodeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return promocodeComponent(promoCode: promoCodeList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(),
                )
              : NoFoundComponent(Title: "No PromoCode available"),
    );
  }

  getPromoCodes() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.postforlist(apiname: 'getPromoCode').then(
            (responselist) async {
          if (responselist.length > 0) {
            setState(() {
              isLoading = false;
              promoCodeList = responselist;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "No Product Found!");
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }
}
