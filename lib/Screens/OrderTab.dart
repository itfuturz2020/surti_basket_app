import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Screens/OrderDetailScreen.dart';
import 'package:surti_basket_app/Screens/OrderHistoryScreen.dart';

class OrderTab extends StatefulWidget {
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text("Order History",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        body: Column(
          children: [
            TabBar(
                labelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.w600),
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
                indicatorColor: appPrimaryMaterialColor,
                tabs: [
                  Tab(text: "Order Detail"),
                  Tab(text: "Order Item"),
                ]),
            Expanded(
              child: TabBarView(
                  children: [OrderHistoryScreen(), OrderDetailScreen()]),
            )
          ],
        ),
      ),
    );
  }
}
