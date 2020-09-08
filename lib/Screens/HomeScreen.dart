import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/CustomWidgets/CategoryComponent.dart';

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
      "CatName": "Pet Care",
      "CateImage":
          "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,w=145,h=140/app/images/category/cms_images/icon/icon_cat_5_v_3_500_1598001588.jpg"
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
          title: Row(
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
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Category",
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
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
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Offers",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black87),
                              ),
                            ),
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
        ));
  }
}
