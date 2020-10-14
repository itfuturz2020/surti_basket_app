import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/CategoryComponent.dart';
import 'package:surti_basket_app/CustomWidgets/SubCategoryComponent.dart';
import 'package:surti_basket_app/CustomWidgets/TitlePattern.dart';


class SubCategoryScreen extends StatefulWidget {
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  bool isLoading = false;
  List _subCategory;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        centerTitle: true,
        title: Text("SubCategory",style: TextStyle(color: Colors.white,fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 170.0,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 4.0,
                dotIncreasedColor: Colors.black54,
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: [
                  NetworkImage(
                      'https://www.jiomart.com/images/cms/aw_rbslider/slides/1596181546_Kitchen_superstar_web.jpg'),
                  NetworkImage(
                      'https://www.jiomart.com/images/cms/aw_rbslider/slides/1599489896_breakfast-mela-web-banner_600-X-350.jpg'),
                  NetworkImage(
                      "https://www.jiomart.com/images/cms/aw_rbslider/slides/1599488248_immunity-booste_Creative_r600x350.jpg"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0,top:4.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: TitlePattern(title:"Shop by SubCategory")
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:2.0,right: 2.0),
              child: Card(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _subCategory.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return SubCategoryComponent(_subCategory[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _getSubCategory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.postforlist(apiname: 'getCategoryData').then(
                (responselist) async {
              if(responselist.length > 0){
                setState(() {

                  isLoading = false;
                });
              }
              else{
                setState(() {
                  isLoading=false;
                });
              }
            }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }

}
