import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:surti_basket_app/Common/Colors.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
          child: SpinKitCircle(
        color: appPrimaryMaterialColor,
      )),
    );
  }
}
