import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/CustomWidgets/CategoryComponent.dart';
import 'package:surti_basket_app/CustomWidgets/ProductComponent.dart';
import 'package:surti_basket_app/Screens/AddressScreen.dart';
import 'package:surti_basket_app/Screens/SubCategoryScreen.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _offerbannerlist = [
    "https://www.bigbasket.com/media/uploads/banner_images/2009005_cooking-essential_460_25th.jpg",
    "https://www.bigbasket.com/media/uploads/banner_images/2009063_fnv-below-rs-20_460_5th.jpg",
    "https://www.bigbasket.com/media/uploads/banner_images/2009312_bbpl-staples_8_460_Bangalore.jpg"
  ];

  List _Category = [
    {
      "id": 0,
      "CatName": "Foodgrains , Oil & Grains",
      "CateImage":
          "https://www.shopnow.org.in/wp-content/uploads/2020/07/Ashirvaad-aata-tata-salt-dhara-oil-1-300x300.jpg"
    },
    {
      "id": 1,
      "CatName": "Bakery,Cakes & Dairy",
      "CateImage":
          "https://assetscdn1.paytm.com/images/catalog/product/F/FA/FASFRESHO-BREADINNO985832D47622C4/1575134540377_2.jpg"
    },
    {
      "id": 2,
      "CatName": "Beverages",
      "CateImage":
          "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,w=145,h=140/app/images/category/cms_images/icon/icon_cat_12_v_3_500_1597977286.jpg"
    },
    {
      "id": 3,
      "CatName": "Pet Care",
      "CateImage":
          "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,w=145,h=140/app/images/category/cms_images/icon/icon_cat_5_v_3_500_1598001588.jpg"
    },
    {
      "id": 4,
      "CatName": "Personal Care",
      "CateImage": "https://www.shopickr.com/wp-content/uploads/2019/07/icon_cat_163_v_3_500_1553422430.jpg"
    },
    {
      "id": 5,
      "CatName": "Kitchen & Gardens",
      "CateImage":
          "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,w=145,h=140/app/images/category/cms_images/icon/icon_cat_1047_v_3_500_1597977471.jpg"
    },
    {
      "id": 6,
      "CatName": "Vegetables & Fruits",
      "CateImage":
          "https://cdn.grofers.com/app/images/category/cms_images/icon/icon_cat_1487_v_3_500_1597977519.jpg"
    },
  ];

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
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: [
            IconButton(icon: Icon(Icons.account_box), onPressed: () {})
          ],
          title: InkWell(
            onTap: (){
              Navigator.push(context, SlideLeftRoute(page: AddressScreen()));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Location",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    Text("Sarjan Society",
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, left: 6.0),
                  child: Icon(Icons.edit, size: 18),
                )
              ],
            ),
          ),
        ),
        drawer: Drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration:
                            BoxDecoration(border: Border.all(width: 0.5,color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(4.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('assets/Pattern.png',width: 40,color: Colors.brown),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Category",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black87),
                                  ),
                                ),
                                Image.asset('assets/Pattern.png',width: 40,color: Colors.brown),
                              ],
                            )),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: _Category.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return CategoryComponent(_Category[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration:
                          BoxDecoration(border: Border.all(width: 0.5,color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(4.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/Pattern.png',width: 40,color: Colors.brown),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Suggested Products..",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87),
                                ),
                              ),
                              Image.asset('assets/Pattern.png',width: 40,color: Colors.brown),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: ListView.builder(
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: _Product.length,
                   shrinkWrap: true,
                    itemBuilder: (context , index){
                  return ProductComponent(_Product[index]);
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.5,color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(4.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/Pattern.png',width: 40,color: Colors.brown),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Offers",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87),
                                ),
                              ),
                              Image.asset('assets/Pattern.png',width: 40,color: Colors.brown),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              // ignore: missing_return
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 2.0, left: 6.0, right: 6.0),
                    child: Card(child: Image.network(_offerbannerlist[index])),
                  );
                },
                itemCount: _offerbannerlist.length,
              )

            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: appPrimaryMaterialColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: 0, // this will be set when a new tab is tapped
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home,size: 20),
          title: new Text('Home',style: TextStyle(fontSize: 16),),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text('Search',style: TextStyle(fontSize: 16)),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.shopping_basket),
          title: new Text('My Basket',style: TextStyle(fontSize: 16)),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile',style: TextStyle(fontSize: 16))
        )
      ],
    ),
    );
  }
}
