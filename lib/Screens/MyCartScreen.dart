import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/CustomWidgets/MyCartComponent.dart';
import 'package:surti_basket_app/Screens/CheckOutPage.dart';
import 'package:surti_basket_app/Screens/ProductDetailScreen.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  _showRedeemPoints() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
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
                  padding: const EdgeInsets.only(top:20.0,right:8.0,left: 8.0),
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
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return MyCartComponent();
            },
            itemCount: 2,
          ),
        ],
      ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Text("Redeem Points ►",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold)),
                    onTap: () {
                      _showRedeemPoints();
                    },
                  ),
                  Text(
                    "Rs 450",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("Saved  Rs. 25"),
                ],
              ),
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
