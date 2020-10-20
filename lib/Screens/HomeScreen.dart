import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/CategoryComponent.dart';
import 'package:surti_basket_app/CustomWidgets/DrawerComponent.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/CustomWidgets/OfferComponent.dart';
import 'package:surti_basket_app/CustomWidgets/ProductComponent.dart';
import 'package:surti_basket_app/CustomWidgets/TitlePattern.dart';
import 'package:surti_basket_app/Providers/CartProvider.dart';
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
  List _dashboardList = [];
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
    CartProvider provider = Provider.of<CartProvider>(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: isLoading == true ? Colors.white : Colors.grey[400],
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.account_box),
                onPressed: () {
                  Navigator.push(
                      context, SlideLeftRoute(page: ProfileScreen()));
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
        drawer: DrawerComponent(),
        body: isLoading == true
            ? LoadingComponent()
            : _dashboardList.length > 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        _bannerList.length > 0
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: SizedBox(
                                  height: 170.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Carousel(
                                    boxFit: BoxFit.cover,
                                    autoplay: true,
                                    animationCurve: Curves.fastOutSlowIn,
                                    animationDuration:
                                        Duration(milliseconds: 1000),
                                    dotSize: 4.0,
                                    dotIncreasedColor: Colors.black54,
                                    dotBgColor: Colors.transparent,
                                    dotPosition: DotPosition.bottomCenter,
                                    dotVerticalPadding: 10.0,
                                    showIndicator: true,
                                    indicatorBgPadding: 7.0,
                                    images: _bannerList
                                        .map((item) => Container(
                                            child: Image.network(
                                                IMG_URL + item["BannerImage"],
                                                fit: BoxFit.fill)))
                                        .toList(),
                                  ),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4.0, top: 4.0),
                          child: Card(
                            child: Column(
                              children: [
                                TitlePattern(title: "Category"),
                                GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: _categoryList.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return CategoryComponent(
                                        _categoryList[index]);
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
                                child:
                                    TitlePattern(title: "Suggested Products")),
                          ),
                        ),
                        SizedBox(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _suggestedProductList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ProductComponent(
                                    product: _suggestedProductList[index]);
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: TitlePattern(title: "Offers"),
                            ),
                          ),
                        ),
                        // ignore: missing_return
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return OfferComponent(_Offerlist[index]);
                          },
                          itemCount: _Offerlist.length,
                        )
                      ],
                    ),
                  )
                : Container(color: Colors.white),
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
                child: Stack(
                  children: [
                    InkWell(
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
                    Container(
                      alignment: Alignment.topCenter,
                      child: provider.cartCount > 0
                          ? CircleAvatar(
                              radius: 7.0,
                              backgroundColor: Colors.red[400],
                              foregroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Text(
                                  provider.cartCount.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    )
                  ],
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
          if (responselist.length > 0) {
            setState(() {
              isLoading = false;
              _dashboardList = responselist;
              _bannerList = responselist[0]["Banner"];
              _categoryList = responselist[1]["Category"];
              _Offerlist = responselist[2]["Offer"];
              _suggestedProductList = responselist[3]["SuggestedProduct"];
            });
            print(_bannerList);
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
}
