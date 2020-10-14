import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Constant.dart';

class OfferComponent extends StatefulWidget {
  var Offerdata;
  OfferComponent(this.Offerdata);
  @override
  _OfferComponentState createState() => _OfferComponentState();
}

class _OfferComponentState extends State<OfferComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 2.0, left: 6.0, right: 6.0),
      child: SizedBox(height:120,child: Card(child: Image.network(IMG_URL+widget.Offerdata["OfferImage"],fit: BoxFit.fill))),
    );
  }
}
