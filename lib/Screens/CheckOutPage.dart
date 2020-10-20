import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/Providers/CartProvider.dart';
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
  bool isLoading = false;
  String PaymentMode;
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
    Map<String, dynamic> _addressData = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddressScreen(fromwehere: "Checkout")),
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
      AddressPincode = _addressData["AddressPincode"];
      AddressType = _addressData["AddressType"];
      City = _addressData["AddressCityName"];
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
                                  Icon(Icons.location_on, size: 18),
                                  Text("Deliver to: ${AddressType}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              InkWell(
                                onTap: () {
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
                                onChanged: (value) {
                                  setState(() {
                                    _usePoints = value;
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text("Apply Promocode",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.8, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 5.0, top: 5.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Enter Coupon Code",
                                      hintStyle: TextStyle(fontSize: 12),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 6.0, left: 6.0),
                            child: FlatButton(
                              color: appPrimaryMaterialColor,
                              onPressed: () {},
                              child: Text("APPLY",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Payment Mode",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  PaymentMode = "Cash";
                                });
                              },
                              child: Text("COD",
                                  style: TextStyle(
                                      color: PaymentMode == "Cash"
                                          ? Colors.white
                                          : Colors.black54)),
                              color: PaymentMode == "Cash"
                                  ? appPrimaryMaterialColor
                                  : Colors.grey[200]),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  PaymentMode = "Online";
                                });
                              },
                              child: Text("Online",
                                  style: TextStyle(
                                      color: PaymentMode != "Cash"
                                          ? Colors.white
                                          : Colors.black54)),
                              color: PaymentMode != "Cash"
                                  ? appPrimaryMaterialColor
                                  : Colors.grey[200]),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 40),
              child: SizedBox(
                height: 45,
                child: FlatButton(
                  color: appPrimaryMaterialColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.grey[200])),
                  onPressed: () {
                    _placeOrder();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                "Place Order",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    // color: Colors.grey[700],
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _placeOrder() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        FormData body = FormData.fromMap({
          "CustomerId": "${CustomerId}",
          "AddressId": "${AddressId}",
          "OrderPaymentMethod": "${PaymentMode}",
          "OrderTransactionNo": "",
          "OrderPromoCode": "",
          "OrderTransactionNo": "",
          "OrderBonusPoint": ""
        });
        Services.postForSave(apiname: 'placeOrder', body: body).then(
            (responseremove) async {
          if (responseremove.IsSuccess == true && responseremove.Data == "1") {
            Provider.of<CartProvider>(context, listen: false).removecart();
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Order Place Successfully");
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
  }

  amountCalulation() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        FormData body = FormData.fromMap({
              "CustomerId": "${CustomerId}",
              "Promocode": "",
              "Points": ""
            });
        Services.postForSave(apiname: 'beforePlaceOrder', body: body).then(
            (responseremove) async {
          if (responseremove.IsSuccess == true && responseremove.Data == "1") {
            Provider.of<CartProvider>(context, listen: false).removecart();
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Order Place Successfully");
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
  }

/*
  startPayment() async {
    double payableAmount = double.parse(totalamount);
    //double payableAmount=1;
    print(int.parse(payableAmount.roundToDouble().floor().toString() + "00"));
    Services.GetOrderIDForPayment(
        int.parse(payableAmount.roundToDouble().floor().toString() + "00"),
        'ORD1001')
        .then((data) async {
      if (data != null) {
        print("order Id---> ${data.Data}");
        var options = {
          'image': '',
          'key': 'rzp_live_XCxat4CzDhDGNj',
          'order_id': data.Data,
          'amount': payableAmount.toString(),
          'name': 'Pick N DeliverE',
          'description': 'Order Payment',
          'prefill': {'contact': MobileNo, 'email': email},
        };
        try {
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Payment Gateway Not Open",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_LONG);
      }
    }, onError: (e) {
      Fluttertoast.showToast(
          msg: "Data Not Saved" + e.toString(), backgroundColor: Colors.red);
    });
  }
*/
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
}
