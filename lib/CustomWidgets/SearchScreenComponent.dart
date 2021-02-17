import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/Providers/CartProvider.dart';
import 'package:surti_basket_app/Screens/ProductDetailScreen.dart';

class SearchScreenComponent extends StatefulWidget {
  var searchdata;
  Function onRemove, onQtyUpdate;

  SearchScreenComponent({this.searchdata, this.onQtyUpdate, this.onRemove});

  @override
  _SearchScreenComponentState createState() => _SearchScreenComponentState();
}

class _SearchScreenComponentState extends State<SearchScreenComponent> {
  bool iscartLoading = false;
  bool iscartlist = false;
  String CustomerId;
  int currentIndex = 0;
  List packageInfo;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CustomerId = await preferences.getString(Session.customerId);
  }

  bool iscartremoveLoading = false;
  bool isupdateLoading = false;

  int Qty = 0;

  void add() {
    setState(() {
      Qty++;
    });
    _updateCart();
  }

  void remove() {
    if (Qty != 0) {
      setState(() {
        Qty--;
      });
      _updateCart();
    }
  }

  @override
  void initState() {
    getlocaldata();
    getPackageInfo();
  }

  getPackageInfo() {
    setState(() {
      packageInfo = widget.searchdata["PackInfo"];
    });
  }

  showPackageInfo() {
    showDialog(
        context: context,
        child: Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Pack Variation",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Divider(),
              Column(
                children: List.generate(packageInfo.length, (index) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 6.0, bottom: 6.0),
                            child: Column(
                              children: [
                                Text(
                                    " ${packageInfo[index]["ProductdetailName"]}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'MRP: ',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "${packageInfo[index]["ProductdetailMRP"]}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          ]),
                                    ),
                                    Text(
                                        " ${packageInfo[index]["ProductdetailSRP"]}",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0.5,
                            color: Colors.grey[200],
                          )
                        ],
                      ));
                }),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                    productId: widget.searchdata["ProductId"],
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    packageInfo[0]["ProductdetailImages"] != ""
                        ? "${packageInfo[currentIndex]["ProductdetailProductShow"]}" ==
                                "0"
                            ? Image.network(
                                "${IMG_URL + packageInfo[0]["ProductdetailImages"][0]}",
                                height: 80,
                                width: 80)
                            : Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Stack(children: [
                                  Image.network(
                                      "${IMG_URL + packageInfo[0]["ProductdetailImages"][0]}",
                                      height: 80,
                                      width: 80),
                                  Container(
                                    color: Colors.grey[100],
                                    width: 120,
                                    height: 120,
                                    child: Center(
                                      child: Text(
                                          "${packageInfo[currentIndex]["ProductdetailMessage"]}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    ),
                                  )
                                ]),
                              )
                        : Image.asset("assets/no-image.png",
                            height: 80, width: 80),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.searchdata["ProductName"]}",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${packageInfo[currentIndex]["ProductdetailBrandname"]}",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: InkWell(
                                onTap: () {
                                  showPackageInfo();
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: Text(
                                          "${packageInfo[currentIndex]["ProductdetailName"]}",
                                          style: TextStyle(fontSize: 10)),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'MRP : ',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            "${Inr_Rupee + packageInfo[currentIndex]["ProductdetailMRP"].toString()} ",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      " ${Inr_Rupee + packageInfo[currentIndex]["ProductdetailSRP"].toString()}",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black)),
                                  "${packageInfo[currentIndex]["ProductdetailProductShow"]}" ==
                                          "1"
                                      ? Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: SizedBox(
                                              height: 35,
                                              // width: 75,
                                              child: FlatButton(
                                                onPressed: () {
                                                  //_addTocart();
                                                  /*if (provider.cartIdList.contains(
                                                int.parse(widget
                                                    .product["ProductId"]))) {
                                              Fluttertoast.showToast(
                                                  msg: "Already in Cart!");
                                            } else {
                                              _addTocart();
                                            }*/
                                                },
                                                color: Colors.redAccent,
                                                child: iscartLoading == true
                                                    ? Container(
                                                        height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .height,
                                                        child: Center(
                                                            child:
                                                                SpinKitCircle(
                                                          color: Colors.white,
                                                          size: 25,
                                                        )),
                                                      )
                                                    :
                                                    /*provider.cartIdList.contains(
                                                      int.parse(widget
                                                          .product["ProductId"]))*/
                                                    Text(
                                                        "${packageInfo[currentIndex]["ProductdetailMessage"]}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                        )
                                      :
                                      //Qty == 0
                                      //     ?
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: SizedBox(
                                            height: 35,
                                            width: 75,
                                            child: FlatButton(
                                              onPressed: () {
                                                _addTocart();
                                              },
                                              color: Colors.redAccent,
                                              child: iscartLoading == true
                                                  ? Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      child: Center(
                                                          child: SpinKitCircle(
                                                        color: Colors.white,
                                                        size: 25,
                                                      )),
                                                    )
                                                  : Text('Add',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14)),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          "ProductId": "${widget.searchdata["ProductId"]}",
          "CartQuantity": "1",
          "ProductDetailId": "${packageInfo[currentIndex]["ProductdetailId"]}",
        });
        print(body.fields);
        Services.postForSave(apiname: 'addToCart', body: body).then(
            (responseadd) async {
          if (responseadd.IsSuccess == true && responseadd.Data == "1") {
            setState(() {
              iscartLoading = false;
              iscartlist = !iscartlist;
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

  _removefromcart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          iscartremoveLoading = true;
        });
        FormData body =
            FormData.fromMap({"CartId": "${widget.searchdata["CartId"]}"});
        Services.postForSave(apiname: '/removeCart', body: body).then(
            (responseremove) async {
          if (responseremove.IsSuccess == true && responseremove.Data == "1") {
            // widget.onRemove();
            Provider.of<CartProvider>(context, listen: false).decreaseCart(
                productId: int.parse(widget.searchdata["ProductId"]));
            setState(() {
              iscartremoveLoading = false;
            });
            //   widget.onQtyUpdate();
            Fluttertoast.showToast(
                msg: "Product Removed Successfully",
                gravity: ToastGravity.BOTTOM);
          }
        }, onError: (e) {
          setState(() {
            iscartremoveLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
//      showMsg("No Internet Connection.");
    }
  }

  _updateCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isupdateLoading = true;
        });
        FormData body = FormData.fromMap(
            {"CartId": "${widget.searchdata["CartId"]}", "CartQuantity": Qty});
        Services.postForSave(apiname: 'updateCartQty', body: body).then(
            (responseList) async {
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            setState(() {
              print("update");
              isupdateLoading = false;
            });
            // widget.onQtyUpdate();
          } else {
            setState(() {
              isupdateLoading = false;
            });
            Fluttertoast.showToast(msg: "Something went wrong");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isupdateLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }
}
