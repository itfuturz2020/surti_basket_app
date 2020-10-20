import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Screens/HomeScreen.dart';
import 'package:surti_basket_app/Screens/OrderHistoryScreen.dart';
import 'package:surti_basket_app/Screens/OrderTab.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';

class MyorderComponent extends StatefulWidget {
  var MyOrderData;

  MyorderComponent({this.MyOrderData});

  @override
  _MyorderComponentState createState() => _MyorderComponentState();
}

class _MyorderComponentState extends State<MyorderComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            FadeRoute(page: OrderTab(OrderId: widget.MyOrderData["OrderId"])));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child: Icon(Icons.done, size: 20, color: appPrimaryMaterialColor),
              decoration: BoxDecoration(
                  border: Border.all(color: appPrimaryMaterialColor),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 13.0, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    "${widget.MyOrderData["OrderDeliveryDate"]}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 9.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Text("Order ID ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[700])),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 9.0, left: 8),
                                          child: Text(
                                              "${widget.MyOrderData["OrderId"]}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700])),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Text("Rs",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.grey[700])),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4.2,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                    "${widget.MyOrderData["OrderTotal"][0]["Total"]}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                                "${widget.MyOrderData["OrderStageDropDown"]}"),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.7,
                                                child: Text("Items ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.grey[700])),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                  "${widget.MyOrderData["OrderTotalQty"]}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[700])),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: SizedBox(
                                            height: 25,
                                            child: FlatButton(
                                              onPressed: () {},
                                              color: appPrimaryMaterialColor,
                                              child: Text('Reorder',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
