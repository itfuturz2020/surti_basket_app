import 'package:flutter/material.dart';
import 'package:surti_basket_app/CustomWidgets/Promocodecomponent.dart';

class promoCode extends StatefulWidget {
  @override
  _promoCodeState createState() => _promoCodeState();
}

class _promoCodeState extends State<promoCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Offers",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10),
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return promocodeComponent();
        },
        separatorBuilder: (BuildContext context, int index) => Container(),
      ),
    );
  }
}
