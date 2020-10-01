import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Cart",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/location.png',
                                width: 18, color: Colors.black54),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Delivere to: Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                        fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "  (Defualt)",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border:
                                    Border.all(width: 0.7, color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, bottom: 2.0, right: 4.0, left: 4.0),
                              child: Text(
                                "Change",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text(
                      "Belle Planet lives at 223 Center Street, Venus, New York 10001",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Text("Promocode\nonline payment Charges 2%")
          ],
        ),
      ),
    );
  }
}
