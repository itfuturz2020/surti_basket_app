import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:surti_basket_app/CustomWidgets/CategoryComponent.dart';
import 'package:surti_basket_app/CustomWidgets/SubCategoryComponent.dart';


class SubCategoryScreen extends StatefulWidget {
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("SubCategory",style: TextStyle(color: Colors.white)),
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
                                "Shop by SubCategory",
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
            Padding(
              padding: const EdgeInsets.only(left:2.0,right: 2.0),
              child: Card(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _Category.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return SubCategoryComponent(_Category[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
