import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';

class AddressProviderData extends ChangeNotifier {
  List addresslist = [];

  AddressProviderData() {
    getAdressData();
  }

  Future<int> getAdressData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        var CustomerId = preferences.getString(Session.customerId);
        log("Customer Id=============================${CustomerId}");
        FormData body = FormData.fromMap({"CustomerId": CustomerId});
        Services.postforlist(apiname: 'getAddress', body: body).then(
            (responselist) async {
          if (responselist.length > 0) {
            addresslist = responselist;
            notifyListeners();
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
