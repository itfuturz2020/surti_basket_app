import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/CategoryComponent.dart';
import 'package:surti_basket_app/CustomWidgets/ProductComponent.dart';
import 'package:surti_basket_app/Screens/AddressScreen.dart';
import 'package:surti_basket_app/Screens/MyCartScreen.dart';
import 'package:surti_basket_app/Screens/ProfileScreen.dart';
import 'package:surti_basket_app/Screens/SearchProductPage.dart';
import 'package:surti_basket_app/Screens/SubCategoryScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;
  List _bannerList = [];
  List _categoryList = [];
  List _suggestedProductList = [];
  List _Offerlist = [];
  bool isLoading = false;


  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "press back again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }


  @override
  void initState() {
    super.initState();
    _dashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.account_box),
                onPressed: () {
                  Navigator.push(context,
                      SlideLeftRoute(page: ProfileScreen("Hello World")));
                })
          ],
          title: InkWell(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: AddressScreen()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Location",
                    style: TextStyle(fontSize: 13, color: Colors.white)),
                Row(
                  children: [
                    Text("Surat",
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                    Icon(Icons.location_on, size: 15)
                  ],
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 170.0,
                  width: MediaQuery.of(context).size.width,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 4.0,
                    dotIncreasedColor: Colors.black54,
                    dotBgColor: Colors.transparent,
                    dotPosition: DotPosition.bottomCenter,
                    dotVerticalPadding: 10.0,
                    showIndicator: true,
                    indicatorBgPadding: 7.0,
                    images: [
                      NetworkImage(
                          'https://www.jiomart.com/images/cms/aw_rbslider/slides/1596181546_Kitchen_superstar_web.jpg'),
                      NetworkImage(
                          'https://www.jiomart.com/images/cms/aw_rbslider/slides/1599489896_breakfast-mela-web-banner_600-X-350.jpg'),
                      NetworkImage(
                          "https://www.jiomart.com/images/cms/aw_rbslider/slides/1599488248_immunity-booste_Creative_r600x350.jpg"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('assets/Pattern.png',
                                    width: 40, color: Colors.brown),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Category",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black87),
                                  ),
                                ),
                                Image.asset('assets/Pattern.png',
                                    width: 40, color: Colors.brown),
                              ],
                            )),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: _categoryList.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return CategoryComponent(_categoryList[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/Pattern.png',
                                  width: 40, color: Colors.brown),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Suggested Products..",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black87),
                                ),
                              ),
                              Image.asset('assets/Pattern.png',
                                  width: 40, color: Colors.brown),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
/*
              SizedBox(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _suggestedProductList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProductComponent(product: _suggestedProductList[index]);
                    }),
              ),
*/
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/Pattern.png',
                                  width: 40, color: Colors.brown),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Offers",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black87),
                                ),
                              ),
                              Image.asset('assets/Pattern.png',
                                  width: 40, color: Colors.brown),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              // ignore: missing_return
              /*ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 2.0, left: 6.0, right: 6.0),
                    child: Card(child: Image.network(_Offerlist[index])),
                  );
                },
                itemCount: _Offerlist.length,
              )*/
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 54,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey, width: 0.3))),
          child: Row(
            children: <Widget>[
              Flexible(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/home.png',
                            width: 20, color: Colors.grey),
                        Text("Home", style: TextStyle(fontSize: 11))
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Flexible(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/category.png',
                            width: 20, color: Colors.grey),
                        Text("Category", style: TextStyle(fontSize: 11))
                      ],
                    ),
                  ),
                  onTap: () {
                    // Navigator.pushNamed(context, "/MyGuestList");
                  },
                ),
              ),
              Flexible(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/loupe.png',
                            width: 20, color: Colors.grey),
                        Text("Search",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, color: Colors.black))
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, FadeRoute(page: SearchProductPage()));
                  },
                ),
              ),
              Flexible(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/shoppingcart.png',
                            width: 22, color: Colors.grey),
                        Text("My Cart",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11))
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, SlideLeftRoute(page: MyCartScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _dashboardData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.postforlist(apiname: 'getDashboardData').then(
                (responselist) async {
              if(responselist.length > 0){
                setState(() {
                  isLoading = false;
                  _bannerList=responselist[0]["Banner"];
                  _categoryList=responselist[1]["Category"];
                //  _Offerlist=responselist[2]["Offer"];
                  //_suggestedProductList=responselist[3]["SuggestedProduct"];
                });
                print(_Offerlist);
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
}