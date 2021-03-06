import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/CustomWidgets/SearchScreenComponent.dart';

class SearchProductPage extends StatefulWidget {
  @override
  _SearchProductPageState createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  TextEditingController txtSearch = TextEditingController();
  List searchlist = [];
  bool issearchLoading = false;

  @override
  void initState() {
    _getSearching();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Search Product"),
        bottom: PreferredSize(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: TextFormField(
              controller: txtSearch,
              textInputAction: TextInputAction.done,
              onChanged: (val) {
                _getSearching();
              },
              /*onFieldSubmitted: (mm) {
                // txtSearch.clear();
              },*/
              cursorColor: Colors.grey,
              decoration: new InputDecoration(
                contentPadding: const EdgeInsets.all(3.0),
                hintText: 'What do you want ?',
                hintStyle: TextStyle(fontSize: 13),
                prefixIcon: Icon(Icons.search, color: Colors.black54, size: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(55.0),
        ),
      ),
      body: issearchLoading == true
          ? LoadingComponent()
          : Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return SearchScreenComponent(
                    searchdata: searchlist[index],
                    // onRemove: () {
                    //   setState(() {
                    //     searchlist.removeAt(index);
                    //   });
                    // },
                    // onQtyUpdate: () {
                    //   //   getCartTotal();
                    // },
                  );
                },
                itemCount: searchlist.length,
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    color: Colors.grey[200],
                  );
                },
              ),
            ),
    );
  }

  // getCartTotal() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //
  //     var CustomerId = preferences.getString(Session.customerId);
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //
  //       FormData body = FormData.fromMap({"CustomerId": CustomerId});
  //       Services.postforlist(apiname: 'getCartTotal', body: body).then(
  //               (responselist) async {
  //             setState(() {
  //               isBottomLoading = false;
  //             });
  //             if (responselist.length > 0) {
  //               setState(() {
  //                 isBottomLoading = false;
  //                 priceList = responselist;
  //                 Total = priceList[0]["Total"];
  //                 Save = priceList[0]["Save"];
  //               });
  //             } else {
  //               Fluttertoast.showToast(msg: "No Product Found!");
  //             }
  //           }, onError: (e) {
  //         setState(() {
  //           isBottomLoading = false;
  //         });
  //         print("error on call -> ${e.message}");
  //         Fluttertoast.showToast(msg: "something went wrong");
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     Fluttertoast.showToast(msg: "No Internet Connection");
  //   }
  // }

  _getSearching() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          issearchLoading = true;
        });

        FormData body = FormData.fromMap({"ProductName": txtSearch.text});
        Services.postforlist(apiname: 'search', body: body).then(
            (responseList) async {
          setState(() {
            issearchLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              searchlist = responseList;
            });
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            issearchLoading = false;
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
