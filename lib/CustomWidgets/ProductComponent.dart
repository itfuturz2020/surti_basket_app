import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Screens/ProductDetailScreen.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class ProductComponent extends StatefulWidget {
  var product;
  ProductComponent({this.product});
  @override
  _ProductComponentState createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right:8.0,top:0.5),
      child: InkWell(
        onTap: (){
          Navigator.push(context, SlideLeftRoute(page: ProductDetailScreen()));
        },
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      '${widget.product["Image"]}',
                      width: 120,
                      height: 120,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Fresh Onion",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("1 KG", style: TextStyle(fontSize: 14, color: Colors.grey)),
                            RichText(
                              text: TextSpan(
                                  text: 'MRP: ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "${Inr_Rupee} 100",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          decoration: TextDecoration.lineThrough),
                                    )
                                  ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(" $Inr_Rupee 90",
                                    style: TextStyle(fontSize: 17, color: Colors.black)),
                                Padding(
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: SizedBox(
                                    height: 35,
                                    width: 70,
                                    child: FlatButton(
                                      color: Colors.redAccent,
                                      child: Text('Add',
                                          style: TextStyle(color: Colors.white, fontSize: 15)),
                                      //`Text` to display
                                      onPressed: () {
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
