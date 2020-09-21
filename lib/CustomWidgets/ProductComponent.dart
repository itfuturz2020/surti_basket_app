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
  int Qty = 0;

  void add() {
    setState(() {
      Qty++;
    });
  }

  void remove() {
    if (Qty != 0) {
      setState(() {
        Qty--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 1),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, SlideLeftRoute(page: ProductDetailScreen()));
                    },
                    child: Image.network(
                      '${widget.product["Image"]}',
                      width: 110,
                      height: 110,
                    ),
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
                          Text("1 KG",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey)),
                          RichText(
                            text: TextSpan(
                                text: 'MRP: ',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "${Inr_Rupee} 100",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        decoration:
                                            TextDecoration.lineThrough),
                                  )
                                ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(" $Inr_Rupee 90",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black)),
                              Qty == 0
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SizedBox(
                                        height: 35,
                                        width: 70,
                                        child: FlatButton(
                                          color: Colors.redAccent,
                                          child: Text('Add',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                          //`Text` to display
                                          onPressed: () {
                                            setState(() {
                                              Qty=1;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey[300],
                                                      blurRadius: 2.0,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Colors.red[400])),
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child: Icon(Icons.remove,
                                                    color: Colors.red[400],
                                                    size: 20),
                                              ),
                                            ),
                                            onTap: () {
                                              remove();
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Text(
                                              "${Qty}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              add();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey[300],
                                                      blurRadius: 2.0,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Colors.red[400])),
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child: Icon(Icons.add,
                                                    color: Colors.red[400],
                                                    size: 20),
                                              ),
                                            ),
                                          )
                                        ],
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
    );
  }
}
