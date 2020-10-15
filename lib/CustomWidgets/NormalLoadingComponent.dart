import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Colors.dart';

class CartLoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3.5,
          valueColor:
              new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
        ),
      ),
    );
  }
}
