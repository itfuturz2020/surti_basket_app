import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Screens/AddressScreen.dart';
import 'package:surti_basket_app/Screens/HomeScreen.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class ProfileScreen extends StatefulWidget {
  var ScreenName;
  ProfileScreen(this.ScreenName);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getlocaldata();
    print('${widget.ScreenName}');
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Profile",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.png'),
                    radius: 35,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${CustomerName}",
                                    style: TextStyle(fontSize: 18)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        SlideLeftRoute(page: AddressScreen()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Image.asset('assets/editicon.png',
                                        width: 18,
                                        height: 18,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("${CustomerEmail}",
                                style: TextStyle(fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("${Customerphone}",
                                style: TextStyle(fontSize: 15)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.grey[200],
              height: 10,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 16)),
                  )
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
