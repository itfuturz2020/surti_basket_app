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
  String CustomerId,
      CustomerName,
      Customerphone,
      AddressId,
      AddressHouseNo,
      AddressName,
      AddressAppartmentName,
      AddressStreet,
      AddressLandmark,
      AddressArea,
      AddressType,
      AddressPincode,
      City;
  SharedPreferences preferences;
  bool _usePoints = false;

  getlocaldata() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = preferences.getString(Session.customerId);
      CustomerName = preferences.getString(Session.CustomerName);
      Customerphone = preferences.getString(Session.CustomerPhoneNo);
      AddressId = preferences.getString(AddressSession.AddressId);
      AddressHouseNo = preferences.getString(AddressSession.AddressHouseNo);
      AddressPincode = preferences.getString(AddressSession.AddressPincode);
      AddressAppartmentName =
          preferences.getString(AddressSession.AddressAppartmentName);
      AddressStreet = preferences.getString(AddressSession.AddressStreet);
      AddressLandmark = preferences.getString(AddressSession.AddressLandmark);
      AddressArea = preferences.getString(AddressSession.AddressArea);
      AddressType = preferences.getString(AddressSession.AddressType);
      City = preferences.getString(AddressSession.City);
    });
  }

  _changeAddress(BuildContext context) async {
    Map<String,dynamic> _addressData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddressScreen(fromwehere: "Checkout")),
    );
    print(_addressData);
    setState(() {
        CustomerId = _addressData["CustomerId"];
        AddressId = _addressData["AddressId"];
        AddressHouseNo = _addressData["AddressHouseNo"];
        AddressAppartmentName = _addressData["AddressAppartmentName"];
        AddressStreet = _addressData["AddressStreet"];
        AddressLandmark = _addressData["AddressLandmark"];
        AddressArea = _addressData["AddressArea"];
        AddressPincode =_addressData["AddressPincode"];
        AddressType = _addressData["AddressType"];
        City = _addressData["City"];
      });
    print(AddressId);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: preferences == ""
                  ? FlatButton(onPressed: () {}, child: Text("Select Address"))
                  : Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 18),
                                  Text("Deliver to: ${AddressType}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  _changeAddress(context);
                                },
                                child: Container(
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text("Change",
                                        style: TextStyle(fontSize: 13)),
                                  )),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(4.0)),
                                ),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 6.0, left: 4.0, bottom: 4.0),
                            child: Text(
                                "${AddressHouseNo}-" +
                                    "${AddressAppartmentName}" +
                                    "," +
                                    "${AddressStreet}" +
                                    "\n${AddressLandmark}, " +
                                    "${AddressArea} ," +
                                    "${City}-" +
                                    "${AddressPincode}",
                                style: TextStyle(color: Colors.grey[700])),
                          ),
                        ],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: _usePoints,
                                onChanged: (value){
                                  setState(() {
                                    _usePoints=value;
                                  });
                                }),
                            Image.asset("assets/coin.png", width: 25),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Redeem Points",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("100 Points ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            )
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
  TextEditingController pincode = new TextEditingController();
  bool isLoading = false;

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
    if (pincode.text != null) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          FormData body = FormData.fromMap({"PincodeNo": pincode.text});
          Services.postForSave(apiname: 'checkPincode', body: body).then(
              (responseremove) async {
            if (responseremove.IsSuccess == true &&
                responseremove.Data == "1") {
              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
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
    } else {
      Fluttertoast.showToast(msg: "Please Enter PinCode");
    }
  }

  _placeOrder() async {
    if (pincode.text != null) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          FormData body = FormData.fromMap({
            "CustomerId": "",
            "AddressId": "",
            "OrderPaymentMethod": "",
            "OrderTransactionNo": "",
            "OrderPromoCode": "",
            "OrderTransactionNo": "",
            "OrderBonusPoint": ""
          });
          Services.postForSave(apiname: 'placeOrder', body: body).then(
              (responseremove) async {
            if (responseremove.IsSuccess == true &&
                responseremove.Data == "1") {
              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
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
    } else {
      Fluttertoast.showToast(msg: "Please Enter PinCode");
    }
  }
}
