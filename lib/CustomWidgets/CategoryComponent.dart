import 'package:flutter/material.dart';

class CategoryComponent extends StatefulWidget {
  var category;
  CategoryComponent(this.category);
  @override
  _CategoryComponentState createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
