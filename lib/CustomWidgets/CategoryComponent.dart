import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Screens/SubCategoryScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class CategoryComponent extends StatefulWidget {
  var category;
  CategoryComponent(this.category);
  @override
  _CategoryComponentState createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, SlideLeftRoute(page: SubCategoryScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white30,
          border: Border.all(
            color: Colors.black26,
            width: 0.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Image.network(IMG_URL+
                "${widget.category["CategoryImage"]}",
                width: 70,
                height: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.category["CategoryName"]}",
                maxLines: 1,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
