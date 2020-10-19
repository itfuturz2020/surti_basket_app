import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Screens/AddressScreen.dart';
import 'package:surti_basket_app/Screens/MyOrder.dart';
import 'package:surti_basket_app/Screens/OrderHistoryScreen.dart';
import 'package:surti_basket_app/Screens/OrderDetailScreen.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getlocaldata();
  }

  String CustomerId;
  String CustomerName;
  String CustomerEmail;
  String Customerphone;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = preferences.getString(Session.customerId);
      CustomerName = preferences.getString(Session.CustomerName);
      CustomerEmail = preferences.getString(Session.CustomerEmailId);
      Customerphone = preferences.getString(Session.CustomerPhoneNo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Profile",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.4,
              color: Colors.red[300],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/profile.png'),
                            radius: 35,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${CustomerName}",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            SlideLeftRoute(
                                                page: AddressScreen()));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Image.asset(
                                            'assets/editicon.png',
                                            width: 18,
                                            height: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text("${CustomerEmail}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text("${Customerphone}",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 12, left: 12),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red[400],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10, top: 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text("Surat City Gymkhana",
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text("Surat - 395007",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[700])),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 7.0),
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 4.5,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red[400]),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                "Change",
                                style: TextStyle(color: Colors.red[400]),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                color: Colors.grey[200],
                height: 10,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, FadeRoute(page: MyOrder()));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset('assets/shoppingcart.png',
                            width: 25, color: Colors.black54),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("My Orders",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 0.8,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset('assets/earning.png',
                              width: 25, color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text("My Points",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                  Text('00.00',
                      style: TextStyle(color: Colors.green, fontSize: 16))
                ],
              ),
            ),
            Container(
              height: 0.8,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset('assets/logout.png',
                        width: 23, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text("Logout",
                        style: TextStyle(color: Colors.black54, fontSize: 16)),
                  )
                ],
              ),
            ),
            Container(
              height: 0.8,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 30,
        child: Center(child: Text("Version 1.0.0")),
      ),
    );
  }
}
