import 'package:flutter/material.dart';
import 'package:surti_basket_app/Screens/SubCategoryScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class SubCategoryComponent extends StatefulWidget {
  var category;
  SubCategoryComponent(this.category);
  @override
  _SubCategoryComponentState createState() => _SubCategoryComponentState();
}

class _SubCategoryComponentState extends State<SubCategoryComponent> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //Navigator.push(context, SlideRightRoute(page: SubCategoryScreen()));
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
              child: Image.network(
                "${widget.category["CateImage"]}",
                width: 70,
                height: 70,
              ),
            ),
            Text(
              "${widget.category["CatName"]}",
              maxLines: 1,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
