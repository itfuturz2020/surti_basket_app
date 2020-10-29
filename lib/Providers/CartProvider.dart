import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';

class CartProvider extends ChangeNotifier {
  int cartCount = 0;

  List settingList = [];

  CartProvider() {
    log("Cart Provider");
    getCartdata();
    getSettingData();
  }

  void setCartCount(int count) {
    cartCount = count;
    notifyListeners();
  }

  void increaseCart() {
    cartCount++;
    notifyListeners();
  }

  void decreaseCart() {
    cartCount--;
    notifyListeners();
  }

  void removecart() {
    cartCount = 0;
    notifyListeners();
  }

  Future<int> getCartdata() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap(
            {"CustomerId": preferences.getString(Session.customerId)});
        Services.postforlist(apiname: 'getCart', body: body).then(
            (responselist) async {
          if (responselist.length > 0) {
            setCartCount(responselist.length);
          } else
            return 0;
        }, onError: (e) {
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
          return 0;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
      return 0;
    }
  }

  Future<int> getSettingData() async {
    try {
      log("------------------------");
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.postforlist(apiname: 'getSetting').then((responselist) async {
          if (responselist.length > 0) {
            settingList = responselist;
            notifyListeners();
            log("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                responselist.toString());
          }
          return 0;
        }, onError: (e) {
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
          return 0;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
      return 0;
    }
  }
}
