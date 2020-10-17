import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/Screens/AddressScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class CheckoutPage extends StatefulWidget {
  var addressdata;
  CheckoutPage({this.addressdata});
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  String CustomerId,CustomerName,Customerphone,AddressId,AddressHouseNo,AddressName,AddressAppartmentName,AddressStreet,AddressLandmark,AddressArea,AddressType,AddressPincode,City;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = preferences.getString(Session.customerId);
      CustomerName = preferences.getString(Session.CustomerName);
      Customerphone = preferences.getString(Session.CustomerPhoneNo);
      AddressId =  preferences.getString(AddressSession.AddressId);
      AddressHouseNo =  preferences.getString(AddressSession.AddressHouseNo);
      AddressAppartmentName =  preferences.getString(AddressSession.AddressAppartmentName);
      AddressStreet =  preferences.getString(AddressSession.AddressStreet);
      AddressLandmark =  preferences.getString(AddressSession.AddressLandmark);
      AddressArea =  preferences.getString(AddressSession.AddressArea);
      AddressType =  preferences.getString(AddressSession.AddressType);
      City =  preferences.getString(AddressSession.City);
    });
  }

  @override
  void initState() {
    getlocaldata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Check out",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RaisedButton(onPressed: (){
            }),
            widget.addressdata != null ?
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ):Container()
          ],
        ),
      ),
    );
  }
}


class PinCodePopup extends StatefulWidget {
  @override
  _PinCodePopupState createState() => _PinCodePopupState();
}

class _PinCodePopupState extends State<PinCodePopup> {
  TextEditingController pincode=new TextEditingController();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Enter Pincode",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
            child: PinCodeTextField(
              controller: pincode,
              wrapAlignment: WrapAlignment.center,
              autofocus: false,
              pinBoxRadius: 6,
              highlight: true,
              pinBoxHeight: 35,
              pinBoxWidth: 35,
              highlightColor: appPrimaryMaterialColor,
              defaultBorderColor: Colors.grey,
              hasTextBorderColor: appPrimaryMaterialColor,
              maxLength: 6,
              pinBoxDecoration:
              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 14.0),
              pinTextAnimatedSwitcherTransition:
              ProvidedPinBoxTextAnimation.scalingTransition,
              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 200),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                color: appPrimaryMaterialColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK", style: TextStyle(color: Colors.white))),
          )
        ],
      ),
    );
  }

  _checkPinCode() async {
    if(pincode.text != null){
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          FormData body = FormData.fromMap({
            "PincodeNo":pincode.text
          });
          Services.postForSave(apiname: 'checkPincode', body: body).then(
                  (responseremove) async {
                if (responseremove.IsSuccess == true && responseremove.Data == "1") {
                  setState(() {
                    isLoading = false;
                  });
                }
                else{
                  setState(() {
                    isLoading=false;
                  });
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
        Fluttertoast.showToast(msg: "No Internet Connection");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Please Enter PinCode");
    }
  }

  _placeOrder() async {
    if(pincode.text != null){
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          FormData body = FormData.fromMap({
          "CustomerId":"",
          "AddressId":"",
          "OrderPaymentMethod":"",
          "OrderTransactionNo":"",
          "OrderPromoCode":"",
          "OrderTransactionNo":"",
          "OrderBonusPoint":""
          });
          Services.postForSave(apiname: 'placeOrder', body: body).then(
                  (responseremove) async {
                if (responseremove.IsSuccess == true && responseremove.Data == "1") {
                  setState(() {
                    isLoading = false;
                  });
                }
                else{
                  setState(() {
                    isLoading=false;
                  });
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
        Fluttertoast.showToast(msg: "No Internet Connection");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Please Enter PinCode");
    }
  }

}