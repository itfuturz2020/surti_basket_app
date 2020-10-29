import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/Providers/CartProvider.dart';
import 'package:surti_basket_app/Screens/MyCartScreen.dart';
import 'package:surti_basket_app/Screens/ProductDetailScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class ProductComponent extends StatefulWidget {
  var product;

  ProductComponent({this.product});

  @override
  _ProductComponentState createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  bool iscartlist = false;
  bool iscartLoading = false;
  String CustomerId;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CustomerId = await preferences.getString(Session.customerId);
  }

  @override
  void initState() {
    getlocaldata();
  }

  int Qty = 0;

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                    productId: widget.product["ProductId"],
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 1),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            SlideLeftRoute(
                                page: ProductDetailScreen(
                                    productId:
                                        "${widget.product["ProductId"]}")));
                      },
                      child: Image.network(
                        '${IMG_URL + widget.product["ProductImages"]}',
                        width: 110,
                        height: 110,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.product["ProductName"]}",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${widget.product["SubcategoryName"]}",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'MRP: ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          "${Inr_Rupee + widget.product["ProductMrp"]} ",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      " ${Inr_Rupee + widget.product["ProductSrp"]}",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: SizedBox(
                                      height: 35,
                                      width: 75,
                                      child: FlatButton(
                                        onPressed: () {
                                          _addTocart();
                                        },
                                        color: Colors.redAccent,
                                        child: iscartLoading
                                            ? LoadingComponent()
                                            : iscartlist == true
                                                ? Text('Added',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14))
                                                : Text('Add',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15)),
                                      ),
                                    ),
                                  ),

                                  // : Padding(
                                  //     padding:
                                  //         const EdgeInsets.only(right: 10.0),
                                  //     child: Row(
                                  //       children: [
                                  //         InkWell(
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.white,
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Colors.grey[300],
                                  //                     blurRadius: 2.0,
                                  //                   ),
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         4.0),
                                  //                 border: Border.all(
                                  //                     width: 1,
                                  //                     color:
                                  //                         Colors.red[400])),
                                  //             width: 30,
                                  //             height: 30,
                                  //             child: Center(
                                  //               child: Icon(Icons.remove,
                                  //                   color: Colors.red[400],
                                  //                   size: 20),
                                  //             ),
                                  //           ),
                                  //           onTap: () {
                                  //             remove();
                                  //           },
                                  //         ),
                                  //         Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               left: 10.0, right: 10.0),
                                  //           child: Text(
                                  //             "${Qty}",
                                  //             style: TextStyle(fontSize: 20),
                                  //           ),
                                  //         ),
                                  //         InkWell(
                                  //           onTap: () {
                                  //             add();
                                  //           },
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.white,
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Colors.grey[300],
                                  //                     blurRadius: 2.0,
                                  //                   ),
                                  //                 ],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         4.0),
                                  //                 border: Border.all(
                                  //                     width: 1,
                                  //                     color:
                                  //                         Colors.red[400])),
                                  //             width: 30,
                                  //             height: 30,
                                  //             child: Center(
                                  //               child: Icon(Icons.add,
                                  //                   color: Colors.red[400],
                                  //                   size: 20),
                                  //             ),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
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
          "ProductId": "${widget.product["ProductId"]}",
          "CartQuantity": "1",
          "ProductDetailId": "",
        });
        print(body.fields);
        Services.postForSave(apiname: 'addToCart', body: body).then(
            (responseadd) async {
          if (responseadd.IsSuccess == true && responseadd.Data == "1") {
            // Navigator.push(context, FadeRoute(page: MyCartScreen()));
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
}
