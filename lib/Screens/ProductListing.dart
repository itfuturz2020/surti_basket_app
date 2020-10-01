import 'package:flutter/material.dart';
import 'package:surti_basket_app/CustomWidgets/ProductComponent.dart';

class ProductListing extends StatefulWidget {
  @override
  _ProductListingState createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  List _Product = [
    {
      "id": 0,
      "ProductName": "Onion",
      "Price": "100",
      "Image":
          "https://www.shopnow.org.in/wp-content/uploads/2020/07/Ashirvaad-aata-tata-salt-dhara-oil-1-300x300.jpg"
    },
    {
      "id": 1,
      "ProductName": "Tomato",
      "Price": "120",
      "Image":
          "https://media.istockphoto.com/photos/tomato-with-slice-isolated-with-clipping-path-picture-id941825878?k=6&m=941825878&s=612x612&w=0&h=GAQ-ypOITkWGGBYUwNDDh4_xjcjOM6Gf79FJMA-Kcfw="
    },
    {
      "id": 2,
      "ProductName": "Tide Washing Power",
      "Price": "550",
      "Image":
          "https://5.imimg.com/data5/RQ/QL/TC/SELLER-32690784/green-bath-soaps-500x500.jpg"
    },
    {
      "id": 3,
      "ProductName": "Ashirvad Aata",
      "Price": "170",
      "Image":
          "https://images-na.ssl-images-amazon.com/images/I/71-u8LysFmL._SL1000_.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Surti Basket",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: 30,
            child: Center(child: Text('ATTA,FLOOR & SOOJI',style: TextStyle(fontSize: 15),)),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('105 Items',style: TextStyle(fontSize: 15,color: Colors.black54)),
                FlatButton(
                  color: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.grey[200],
                  onPressed: () {
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:6.0),
                        child: Image.asset('assets/filter.png',color: Colors.black54,width: 20),
                      ),
                      Text(
                        "Filter",
                        style: TextStyle(fontSize: 14.0,color: Colors.black54),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _Product.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductComponent(product: _Product[index]);
              }),
        ],
      ),
    );
  }
}
