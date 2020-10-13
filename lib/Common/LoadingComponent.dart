import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Colors.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
      ),
    );
  }
}
