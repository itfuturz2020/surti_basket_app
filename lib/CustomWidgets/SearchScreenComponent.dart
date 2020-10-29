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

class SearchScreenComponent extends StatefulWidget {
  var searchdata;
  SearchScreenComponent({this.searchdata});

  @override
  _SearchScreenComponentState createState() => _SearchScreenComponentState();
}

class _SearchScreenComponentState extends State<SearchScreenComponent> {
  bool iscartLoading = false;
  bool iscartlist = false;
  String CustomerId;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CustomerId = await preferences.getString(Session.customerId);
  }

  @override
  void initState() {
    getlocaldata();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  Image.network(
                    '${IMG_URL + widget.searchdata["ProductImages"]}',
                    width: 110,
                    height: 110,
                  ),
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
                            "${widget.searchdata["SubcategoryName"]}",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'MRP : ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "${Inr_Rupee + widget.searchdata["ProductMrp"]} ",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    " ${Inr_Rupee + widget.searchdata["ProductSrp"]}",
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
                                      child: iscartLoading == true
                                          ? LoadingComponent()
                                          : iscartlist == true
                                              ? Text('Added',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14))
                                              : Text('Add',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14)),
                                    ),
                                  ),
                                ),
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
          "ProductId": "",
          "CartQuantity": "1",
          "ProductDetailId": "",
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
}
