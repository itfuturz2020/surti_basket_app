import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Colors.dart';

class promocodeComponent extends StatefulWidget {
  List promoCode;
  promocodeComponent({this.promoCode});

  @override
  _promocodeComponentState createState() => _promocodeComponentState();
}

class _promocodeComponentState extends State<promocodeComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11.0, right: 11, top: 10),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, top: 15, bottom: 15, right: 12),
          child: Row(
            children: [
              Image.asset(
                "assets/o2.jpg",
                width: 90,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("Coupon Code",
                          // "${widget.MyOrderData["OrderDeliveryDate"]}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("30 %  Off  With  Flipcart  Charge",
                          // "${widget.MyOrderData["OrderDeliveryDate"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("wp1589yt used today",
                          // "${widget.MyOrderData["OrderDeliveryDate"]}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: SizedBox(
                        height: 35,
                        width: 110,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () {},
                          color: appPrimaryMaterialColor,
                          child: Text('Get Code',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ),
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
