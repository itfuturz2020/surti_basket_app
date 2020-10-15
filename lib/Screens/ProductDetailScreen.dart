import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/Providers/CartProvider.dart';
import 'package:surti_basket_app/Screens/MyCartScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';

class ProductDetailScreen extends StatefulWidget {
  var productId;

  ProductDetailScreen({this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool iscartlist = false;
  bool iscartLoading = false;
  bool isLoading = false;
  int currentIndex = 0;
  int currentImageIndex = 0;
  int groupvalue = 0;
  String productDetailId;
  List productdetail = [];
  List packageInfo = [];
  String CustomerId;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CustomerId = await preferences.getString(Session.customerId);
  }

  @override
  void initState() {
    _productDetail();
    getlocaldata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product Detail",
            style: TextStyle(fontSize: 17, color: Colors.white)),
        actions: [
          Stack(
            children: [
              IconButton(
                  icon: Image.asset('assets/shoppingcart.png',
                      width: 26, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context, FadeRoute(page: MyCartScreen()));
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Container(
                  child: provider.cartCount > 0
                      ? CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                          child: Text(
                            provider.cartCount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0,
                            ),
                          ),
                        )
                      : Container(),
                ),
              )
            ],
          )
        ],
      ),
      body: isLoading == true
          ? LoadingComponent()
          : productdetail.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 18.0, right: 10.0),
                          child: Text("${productdetail[0]["ProductName"]}",
                              style: TextStyle(fontSize: 18)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                    "${packageInfo.length > 0 ? Inr_Rupee + packageInfo[currentIndex]["ProductdetailSRP"] : productdetail[0][""]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'MRP: ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "${packageInfo.length > 0 ? Inr_Rupee + packageInfo[currentIndex]["ProductdetailMRP"] : productdetail[0][""]}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )
                                      ]),
                                ),
                              ),
/*
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0,
                                        right: 4.0,
                                        top: 2.0,
                                        bottom: 2.0),
                                    child: Text("20 %",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  )),
*/
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Image.network(
                                    '${IMG_URL + packageInfo[currentImageIndex]["ProductdetailImage"]}',
                                    height: 300),
                              ),
                            ],
                          ),
/*
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children:
                                  List.generate(packageInfo.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: index == currentIndex
                                                    ? 1.0
                                                    : 0.5,
                                                color: index == currentIndex
                                                    ? Colors.lightGreen
                                                    : Colors.grey[400]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.network(
                                              '${IMG_URL + packageInfo[index]["ProductdetailImage"]}',
                                              fit: BoxFit.cover,
                                              width: 50),
                                        )),
                                  ),
                                );
                              }),
                            ),
                          ),
*/
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text('Pack Sizes',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Column(
                            children:
                                List.generate(packageInfo.length, (index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5,
                                              color: Colors.grey[400]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0))),
                                      child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  "${packageInfo[index]["ProductdetailName"]}"),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      " $Inr_Rupee ${packageInfo[index]["ProductdetailSRP"]}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black)),
                                                  RichText(
                                                    text: TextSpan(
                                                        text: 'MRP: ',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                "${Inr_Rupee} ${packageInfo[index]["ProductdetailMRP"]}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 13,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          )
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                              currentIndex == index
                                                  ? Icon(
                                                      Icons
                                                          .radio_button_checked,
                                                      size: 20)
                                                  : Icon(
                                                      Icons
                                                          .radio_button_unchecked,
                                                      size: 20)
                                            ],
                                          ))),
                                ),
                              );
                            }),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 15,
                            color: Colors.grey[100],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text('Product Description',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: Text(
                              "${productdetail[0]["ProductDescription"]}",
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Container(child: Text("No Found")),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.red[400],
        child: GestureDetector(
          onTap: () {
            _addTocart();
          },
          child: iscartLoading
              ? Center(
                  child: SpinKitRipple(
                  color: Colors.white,
                ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/shoppingcart.png',
                        width: 26, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("ADD TO CART",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  _productDetail() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var data = FormData.fromMap({"ProductId": "${widget.productId}"});
        print(data.fields);
        setState(() {
          isLoading = true;
        });
        Services.postforlist(apiname: 'getProductDetailData', body: data).then(
            (responselist) async {
          if (responselist.length > 0) {
            setState(() {
              isLoading = false;
              productdetail = responselist;
              packageInfo = responselist[1]["Packinfo"];
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
  }

  _addTocart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          iscartLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": CustomerId,
          "ProductId": "${productdetail[0]["ProductId"]}",
          "CartQuantity": "${productdetail[0]["ProductQty"]}",
          "ProductDetailId": "${packageInfo[currentIndex]["ProductdetailId"]}"
        });
        print(body.fields);
        Services.postForSave(apiname: 'addToCart', body: body).then(
            (responseadd) async {
          if (responseadd.IsSuccess == true && responseadd.Data == "1") {
            Navigator.push(context, FadeRoute(page: MyCartScreen()));
            setState(() {
              iscartLoading = false;

              // iscartlist = !iscartlist;
            });
            Provider.of<CartProvider>(context, listen: false).increaseCart();
            Fluttertoast.showToast(
                msg: "Added Successfully", gravity: ToastGravity.BOTTOM);
          }
        }, onError: (e) {
          setState(() {
            iscartLoading = false;
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
