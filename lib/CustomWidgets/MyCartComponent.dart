import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';

class MyCartComponent extends StatefulWidget {
  var cartData;

  Function onRemove;
  MyCartComponent({this.cartData, this.onRemove});

  @override
  _MyCartComponentState createState() => _MyCartComponentState();
}

class _MyCartComponentState extends State<MyCartComponent> {
  bool iscartremoveLoading = false;

  int Qty = 1;
  void add() {
    setState(() {
      Qty++;
    });
  }

  void remove() {
    if (Qty != 0) {
      setState(() {
        Qty--;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      Qty = int.parse("${widget.cartData["CartQuantity"]}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Fruits & Vegetables"),
              Text("1 Item"),
            ],
          ),
        ),
        Container(
          height: 120,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.network(
                    IMG_URL + "${widget.cartData["ProductImages"]}",
                    width: 120,
                    height: 120),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("${widget.cartData["ProductName"]}",
                          style: TextStyle(fontSize: 15)),
                      RichText(
                        text: TextSpan(
                            text: 'MRP: ',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${Inr_Rupee}" +
                                    "${widget.cartData["ProductMrp"]}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough),
                              )
                            ]),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                " $Inr_Rupee " +
                                    "${widget.cartData["ProductSrp"]}",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              children: [
                                Qty == 0
                                    ? GestureDetector(
                                        onTap: () {
                                          _removefromcart();
                                        },
                                        child: iscartremoveLoading == true
                                            ? Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey[300],
                                                        blurRadius: 2.0,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Colors.red[400])),
                                                child: Center(
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    child: Center(
                                                        child: SpinKitRipple(
                                                      color: Colors.red[400],
                                                    )),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey[300],
                                                        blurRadius: 2.0,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Colors.red[400])),
                                                child: Center(
                                                  child: Icon(Icons.delete,
                                                      color: Colors.red[400],
                                                      size: 20),
                                                ),
                                              ),
                                      )
                                    : InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300],
                                                  blurRadius: 2.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.red[400])),
                                          width: 30,
                                          height: 30,
                                          child: Center(
                                            child: Icon(Icons.remove,
                                                color: Colors.red[400],
                                                size: 20),
                                          ),
                                        ),
                                        onTap: () {
                                          remove();
                                        },
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Text(
                                    "${Qty}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    add();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        border: Border.all(
                                            width: 1, color: Colors.red[400])),
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                      child: Icon(Icons.add,
                                          color: Colors.red[400], size: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _removefromcart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          iscartremoveLoading = true;
        });
        FormData body =
            FormData.fromMap({"CartId": "${widget.cartData["CartId"]}"});
        Services.postForSave(apiname: '/removeCart', body: body).then(
            (responseremove) async {
          if (responseremove.IsSuccess == true && responseremove.Data == "1") {
            widget.onRemove();
            setState(() {
              iscartremoveLoading = false;
            });
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
}
