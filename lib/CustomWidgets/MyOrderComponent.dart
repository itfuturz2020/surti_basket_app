import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:surti_basket_app/Common/Colors.dart';

class MyorderComponent extends StatefulWidget {
  var MyOrderData, orderPayment, ordertotal;

  MyorderComponent({this.MyOrderData, this.orderPayment, this.ordertotal});

  @override
  _MyorderComponentState createState() => _MyorderComponentState();
}

class _MyorderComponentState extends State<MyorderComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 7),
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13.0, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:
                          Text("${widget.MyOrderData[0]["OrderDeliveryDate"]}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 9.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text("Order ID ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700])),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 9.0, left: 8),
                                child: Text(
                                    "${widget.MyOrderData[0]["OrderId"]}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[700])),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Text("Rs",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700])),
                                  width:
                                      MediaQuery.of(context).size.width / 4.2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      "${widget.ordertotal[0]["Total"]}",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      child: Text("Items ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700])),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                        "${widget.MyOrderData[0]["OrderId"]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700])),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    "${widget.MyOrderData[0]["OrderStageDropDown"]}"),
                              )
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
    );
  }
}
