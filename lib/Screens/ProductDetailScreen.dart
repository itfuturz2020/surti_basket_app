import 'package:flutter/material.dart';
import 'package:surti_basket_app/Common/Constant.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int currentIndex = 0;
  int groupvalue = 0;
  List ProductImages = [
    {
      "id": 1,
      "Image":
          "https://images-na.ssl-images-amazon.com/images/I/71gcOblCdcL._SL1000_.jpg"
    },
    {
      "id": 2,
      "Image":
          "https://images-na.ssl-images-amazon.com/images/I/817suZ5%2BdZL._SL1500_.jpg"
    },
    {
      "id": 3,
      "Image":
          "https://images-na.ssl-images-amazon.com/images/I/71I9b%2BbIbiL._SL1500_.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Product Detail",
            style: TextStyle(fontSize: 17, color: Colors.white)),
        actions: [
          IconButton(
              icon: Image.asset('assets/shoppingcart.png',
                  width: 26, color: Colors.white),
              onPressed: null)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 10.0),
              child: Text("Wheat Flour - Chakki Atta , 10 Kg (Fortified)",
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(" Rs 328",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: RichText(
                      text: TextSpan(
                          text: 'MRP: ',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${Inr_Rupee} 295",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  decoration: TextDecoration.lineThrough),
                            )
                          ]),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                        child: Text("20 %",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Image.network(
                      '${ProductImages[currentIndex]["Image"]}',
                      width: 300),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: List.generate(ProductImages.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: index == currentIndex ? 1.0 : 0.5,
                                  color: index == currentIndex
                                      ? Colors.lightGreen
                                      : Colors.grey[400]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.network(
                                '${ProductImages[index]["Image"]}',
                                fit: BoxFit.cover,
                                width: 50),
                          )),
                    ),
                  );
                }),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text('Pack Sizes', style: TextStyle(fontSize: 16)),
            ),
            Column(
              children: List.generate(ProductImages.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: Colors.grey[400]),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("10 Kg"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(" $Inr_Rupee 90",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black)),
                                  RichText(
                                    text: TextSpan(
                                        text: 'MRP: ',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "${Inr_Rupee} 100",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                              Radio(
                                activeColor: Colors.black54,
                                groupValue: groupvalue,
                                value: groupvalue,
                                onChanged: (int value) {
                                  setState(() {
                                    groupvalue = value;
                                  });
                                },
                              )
                            ],
                          ))),
                );
              }),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 15,
              color: Colors.grey[100],
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child:
                  Text('Product Description', style: TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
              child: Text(
                  "Aashirvaad Atta is made from selectively handpicked grains which are "
                  "known for their supreme quality by being heavy on the palm, golden amber"
                  "in colour and hard to bite. It is carefully ground using modern chakki grinding"
                  "process for the perfect balance of colour"
                      "\n \nTaste and nutrition"
                  "Aashirvaad Atta contains 0% Maida and contains 100% pure"
                  "wheat. The dough made from Aashirvaad Atta absorbs more water, hence"
                  "rotis remain softer for longer.",style: TextStyle(color: Colors.black54),),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.red[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/shoppingcart.png',
                width: 26, color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("ADD TO CART",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
