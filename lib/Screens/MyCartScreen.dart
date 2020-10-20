import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/CustomWidgets/MyCartComponent.dart';
import 'package:surti_basket_app/CustomWidgets/NoFoundComponent.dart';
import 'package:surti_basket_app/Providers/CartProvider.dart';
import 'package:surti_basket_app/Screens/AddressScreen.dart';
import 'package:surti_basket_app/Screens/CheckOutPage.dart';
import 'package:surti_basket_app/Screens/HomeScreen.dart';
import 'package:surti_basket_app/Screens/ProductDetailScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool isLoading = true;
  List cartList = [];
  List priceList = [];
  String CustomerId,
      AddressId,
      AddressHouseNo,
      AddressName,
      AddressAppartmentName,
      AddressStreet,
      AddressLandmark,
      AddressArea,
      AddressType,
      AddressPincode;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = preferences.getString(Session.customerId);
      AddressId = preferences.getString(AddressSession.AddressId);
      AddressHouseNo = preferences.getString(AddressSession.AddressHouseNo);
      AddressAppartmentName =
          preferences.getString(AddressSession.AddressAppartmentName);
      AddressStreet = preferences.getString(AddressSession.AddressStreet);
      AddressLandmark = preferences.getString(AddressSession.AddressLandmark);
      AddressArea = preferences.getString(AddressSession.AddressArea);
      AddressType = preferences.getString(AddressSession.AddressType);
      AddressPincode = preferences.getString(AddressSession.AddressPincode);
    });
  }

  @override
  void initState() {
    _getCartdata();
    getlocaldata();
  }

  _changeAddress(BuildContext context) async {
      List _addressData = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddressScreen(fromwehere: "MyCart",)),
      );
      print(_addressData);
      /*setState(() {
        CustomerId = _addressData[0];
        AddressId = _addressData[1];
        AddressHouseNo = _addressData[2];
        AddressAppartmentName = _addressData[3];
        AddressStreet = _addressData[4];
        AddressLandmark = _addressData[5];
        AddressArea = _addressData[6];
        AddressPincode =_addressData[7];
      });*/
  }

  _getCartdata() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({"CustomerId": CustomerId});
        print(body.fields);
        Services.postforlist(apiname: 'getCarttest', body: body).then(
            (responselist) async {
          setState(() {
            isLoading = false;
          });
          if (responselist.length > 0) {
            setState(() {
              cartList = responselist[0]["Cart"];
              priceList = responselist[1]["carttotal"];
              print(body.fields);
            });
            print(cartList);
          } else {
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
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }

  _showRedeemPoints() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Your Points",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appPrimaryMaterialColor,
                          fontSize: 18)),
                ),
                Divider(
                  indent: 10,
                  color: Colors.grey[200],
                  endIndent: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/coin.png', width: 50),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Points Earned",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 1.5,
                              width: 70,
                              color: Colors.grey[200],
                            ),
                          ),
                          Text("5000",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber))
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 8.0, left: 8.0),
                  child: FlatButton(
                    color: Colors.grey[100],
                    textColor: Colors.black54,
                    splashColor: Colors.white24,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Redeem Now",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Cart",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: isLoading == true
          ? LoadingComponent()
          : cartList.length > 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return MyCartComponent(
                            cartData: cartList[index],
                            onRemove: () {
                              setState(() {
                                cartList.removeAt(index);
                              });
                            },
                          );
                        },
                        itemCount: cartList.length,
                      ),
                    ],
                  ),
                )
              : NoFoundComponent(
                  ImagePath: 'assets/noProduct.png',
                  Title: 'Your cart is empty'),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
          ),
        ]),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 12.0),
              child:priceList.length> 0 ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rs: ${priceList[0]["Total"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("Saved  Rs. ${priceList[0]["Save"]}"),
                ],
              ):Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FlatButton(
                color: Colors.red[400],
                textColor: Colors.white,
                splashColor: Colors.white24,
                onPressed: () {
                  Navigator.push(context, SlideLeftRoute(page: CheckoutPage()));
                },
                child: Row(
                  children: [
                    Text(
                      "Check Out",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(Icons.arrow_forward, size: 20),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
