import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/Screens/AddressScreen.dart';
import 'package:surti_basket_app/Screens/LoginScreen.dart';
import 'package:surti_basket_app/Screens/MyOrder.dart';
import 'package:surti_basket_app/Screens/MyPointScreen.dart';
import 'package:surti_basket_app/Screens/Tearmscondition.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';
import 'package:url_launcher/url_launcher.dart';

class contactUs extends StatefulWidget {
  var contactdata, whtspdata, whtscall;
  contactUs({this.contactdata, this.whtspdata, this.whtscall});

  @override
  _contactUsState createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  void launchwhatsapp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 9.0, top: 3),
                  child: Icon(
                    Icons.clear,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              )),
          Container(
            // color: Colors.redAccent,
            height: 100,
            width: 120,
            child: Image.asset("assets/basket.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Icon(
                        Icons.mail,
                        color: Colors.grey,
                        size: 19,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        "meghatech@gmail.com",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Icon(
                          Icons.call,
                          color: Colors.grey,
                          size: 19,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Text(
                          "+9664742543",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Image.asset(
                            "assets/whatsapp.png",
                            width: 21,
                            color: Colors.grey,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "+9664742543",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 21.0, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.mail,
                    color: Colors.white,
                    size: 19,
                  ),
                  backgroundColor: appPrimaryMaterialColor,
                  radius: 19,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 19,
                      ),
                      backgroundColor: appPrimaryMaterialColor,
                      radius: 19,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchwhatsapp(
                        phone: "${widget.whtspdata}",
                        message: "${widget.whtscall}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: CircleAvatar(
                      child: Image.asset(
                        "assets/whatsapp.png",
                        width: 21,
                        color: Colors.white,
                      ),
                      backgroundColor: appPrimaryMaterialColor,
                      radius: 19,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 13.0, bottom: 25, left: 9, right: 9),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: appPrimaryMaterialColor, width: 1)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "${widget.contactdata}",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 4,
            color: appPrimaryMaterialColor,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.only(
        top: 6.0,
        bottom: 0.0,
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  bool isgetaddressLoading = false;
  List getaddressList = [];
  bool isLoading = false;
  List generaldatalist = [];

  void initState() {
    getlocaldata();
    _getAddress();
    _SettingApi();
  }

  String whatsapp, msg, address;
  String CustomerId,
      CustomerName,
      Customerphone,
      CustomerEmail,
      AddressId,
      AddressHouseNo,
      AddressName,
      AddressAppartmentName,
      AddressStreet,
      AddressLandmark,
      AddressArea,
      AddressType,
      AddressPincode,
      City;
  SharedPreferences preferences;

  getlocaldata() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = preferences.getString(Session.customerId);
      CustomerName = preferences.getString(Session.CustomerName);
      Customerphone = preferences.getString(Session.CustomerPhoneNo);
      CustomerEmail = preferences.getString(Session.CustomerEmailId);
      AddressId = preferences.getString(AddressSession.AddressId);
      AddressHouseNo = preferences.getString(AddressSession.AddressHouseNo);
      AddressPincode = preferences.getString(AddressSession.AddressPincode);
      AddressAppartmentName =
          preferences.getString(AddressSession.AddressAppartmentName);
      AddressStreet = preferences.getString(AddressSession.AddressStreet);
      AddressLandmark = preferences.getString(AddressSession.AddressLandmark);
      AddressArea = preferences.getString(AddressSession.AddressArea);
      AddressType = preferences.getString(AddressSession.AddressType);
      City = preferences.getString(AddressSession.City);
    });
    print(AddressPincode);
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Logout",
            style: TextStyle(color: appPrimaryMaterialColor),
          ),
          content: new Text("Are you sure want to logout..."),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(
                    context, FadeRoute(page: LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  _contactUs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return contactUs(
            contactdata: address, whtspdata: msg, whtscall: whatsapp);
      },
    );
  }
  //AlertDialog(
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Align(
  //                   alignment: Alignment.topRight,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(right: 9.0, top: 3),
  //                       child: Icon(
  //                         Icons.clear,
  //                         size: 20,
  //                         color: Colors.grey,
  //                       ),
  //                     ),
  //                   )),
  //               Container(
  //                 // color: Colors.redAccent,
  //                 height: 100,
  //                 width: 120,
  //                 child: Image.asset("assets/basket.png"),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 50.0, top: 8),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(top: 3.0),
  //                           child: Icon(
  //                             Icons.mail,
  //                             color: Colors.grey,
  //                             size: 19,
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 5.0),
  //                           child: Text(
  //                             "meghatech@gmail.com",
  //                             style: TextStyle(
  //                                 color: Colors.black54,
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w500),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 7.0),
  //                       child: Row(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.only(top: 3.0),
  //                             child: Icon(
  //                               Icons.call,
  //                               color: Colors.grey,
  //                               size: 19,
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 7.0),
  //                             child: Text(
  //                               "+9664742543",
  //                               style: TextStyle(
  //                                   color: Colors.black54,
  //                                   fontSize: 12,
  //                                   fontWeight: FontWeight.w500),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 7.0),
  //                       child: Row(
  //                         children: [
  //                           Padding(
  //                               padding: const EdgeInsets.only(top: 3.0),
  //                               child: Image.asset(
  //                                 "assets/whatsapp.png",
  //                                 width: 21,
  //                                 color: Colors.grey,
  //                               )),
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 5.0),
  //                             child: Text(
  //                               "+9664742543",
  //                               style: TextStyle(
  //                                   color: Colors.black54,
  //                                   fontSize: 12,
  //                                   fontWeight: FontWeight.w500),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 21.0, bottom: 35),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     CircleAvatar(
  //                       child: Icon(
  //                         Icons.mail,
  //                         color: Colors.white,
  //                         size: 19,
  //                       ),
  //                       backgroundColor: appPrimaryMaterialColor,
  //                       radius: 19,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 12.0),
  //                       child: CircleAvatar(
  //                         child: Icon(
  //                           Icons.call,
  //                           color: Colors.white,
  //                           size: 19,
  //                         ),
  //                         backgroundColor: appPrimaryMaterialColor,
  //                         radius: 19,
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 12.0),
  //                       child: CircleAvatar(
  //                         child: Image.asset(
  //                           "assets/whatsapp.png",
  //                           width: 21,
  //                           color: Colors.white,
  //                         ),
  //                         backgroundColor: appPrimaryMaterialColor,
  //                         radius: 19,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 height: 4,
  //                 color: appPrimaryMaterialColor,
  //                 width: MediaQuery.of(context).size.width,
  //               ),
  //             ],
  //           ),
  //           contentPadding: const EdgeInsets.only(
  //             top: 6.0,
  //             bottom: 0.0,
  //           ),
  //         );

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
              height: MediaQuery.of(context).size.height / 3.9,
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
                        const EdgeInsets.only(top: 20.0, right: 12, left: 12),
                    child: isgetaddressLoading == true
                        ? Container(
                            height: MediaQuery.of(context).size.height / 13,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.white, width: 0.5)),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3.5,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                          )
                        : getaddressList.length > 0
                            ? Container(
                                height: 79,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6.0),
                                          child: Icon(
                                            Icons.location_on,
                                            color: Colors.red[300],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, bottom: 10, top: 2),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                    "${AddressHouseNo}" +
                                                        "," +
                                                        "${AddressAppartmentName}" +
                                                        "," +
                                                        "${AddressStreet}",
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 14,
                                                    )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2.0),
                                                child: Text(
                                                    "${AddressLandmark}" +
                                                        "," +
                                                        "${AddressArea}",
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 14,
                                                    )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2.0),
                                                child: Text(
                                                    "${City}" +
                                                        "-" +
                                                        "${AddressPincode}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[700])),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            SlideLeftRoute(
                                                page: AddressScreen()));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 18.0),
                                        child: Image.asset(
                                            'assets/editicon.png',
                                            width: 18,
                                            height: 18,
                                            color: Colors.red[300]),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(right: 7.0, top: 20),
                                    //   child: Container(
                                    //     height: 30,
                                    //     width: MediaQuery.of(context).size.width / 4.5,
                                    //     decoration: BoxDecoration(
                                    //         border: Border.all(color: Colors.red[400]),
                                    //         borderRadius: BorderRadius.circular(5)),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "Change",
                                    //       style: TextStyle(color: Colors.red[400]),
                                    //     )),
                                    //   ),
                                    // )
                                  ],
                                ),
                              )
                            : Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        SlideLeftRoute(page: AddressScreen()));
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.white, width: 0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Text(
                                            "Add Address",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, FadeRoute(page: MyPointScreen()));
                      },
                      child: Container(
                        color: Colors.white,
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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      FadeRoute(
                          page: TearmsCon(
                        tearmscondition: generaldatalist[0]
                            ["SettingAboutUsURL"],
                        title: "About Us",
                      )));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.black54,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("About Us",
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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      FadeRoute(
                          page: TearmsCon(
                        tearmscondition: getaddressList[0]
                            ["SettingTermsConditionURL"],
                        title: "Tearms & Condition",
                      )));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset('assets/tearmscon.png',
                            width: 25, color: Colors.black54),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("Tearms & Condition",
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
              child: GestureDetector(
                onTap: () {
                  _contactUs();
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.call,
                            size: 22,
                            color: Colors.black54,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("Contact Us",
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
              child: GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: Container(
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
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16)),
                      )
                    ],
                  ),
                ),
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

  _getAddress() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isgetaddressLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.customerId),
        });
        Services.postforlist(apiname: 'getAddress', body: body).then(
            (ResponseList) async {
          if (ResponseList.length > 0) {
            setState(() {
              getaddressList = ResponseList;
              isgetaddressLoading = false;
              AddressStreet = ResponseList[0]["AddressStreet"];
              AddressArea = ResponseList[0]["AddressArea"];
              AddressLandmark = ResponseList[0]["AddressLandmark"];
              AddressAppartmentName = ResponseList[0]["AddressAppartmentName"];
              AddressPincode = ResponseList[0]["AddressPincode"];
              AddressAppartmentName = ResponseList[0]["AddressAppartmentName"];
              AddressHouseNo = ResponseList[0]["AddressHouseNo"];
            });
          } else {
            setState(() {
              isgetaddressLoading = false;
            });
          }
        }, onError: (e) {
          setState(() {
            isgetaddressLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _SettingApi() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.postforlist(apiname: 'getSetting').then((responselist) async {
          setState(() {
            isLoading = false;
          });
          if (responselist.length > 0) {
            setState(() {
              generaldatalist = responselist;
              whatsapp = "+91" + responselist[0]["SettingPhoneNumber"];
              msg = responselist[0]["SettingWhatsAppMessage"];
              address = responselist[0]["SettingAddress"];
              //set "data" here to your variable
            });
          } else {
            Fluttertoast.showToast(msg: "No Data Found !");
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
//      showMsg("No Internet Connection.");
    }
  }
}
