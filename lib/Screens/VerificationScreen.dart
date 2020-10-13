import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/Screens/RegistrationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class VerificationScreen extends StatefulWidget {
  var mobile, logindata;

  VerificationScreen({this.mobile, this.logindata});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isLoading = false;
  String rndnumber;
  TextEditingController txtOTP = new TextEditingController();

  @override
  void initState() {
    _sendOTP();
  }

  saveDataToSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        Session.customerId, widget.logindata["CustomerId"].toString());
//            prefs.setString(Session.addressId,responselist[0]["addressId"]);
    await prefs.setString(
        Session.CustomerName, widget.logindata["CustomerName"]);
    await prefs.setString(
        Session.CustomerCompanyName, widget.logindata["CustomerCompanyName"]);
    await prefs.setString(
        Session.CustomerEmailId, widget.logindata["CustomerEmailId"]);
    await prefs.setString(
        Session.CustomerPhoneNo, widget.logindata["CustomerPhoneNo"]);

    Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false);
  }

  _sendOTP() async {
    var rnd = new Random();
    setState(() {
      rndnumber = "";
    });
    for (var i = 0; i < 4; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    print(rndnumber);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        FormData body = FormData.fromMap({
          "PhoneNo": "${widget.mobile}",
          "OTP": "$rndnumber",
        });
        Services.postForSave(apiname: 'sendOTP', body: body).then(
            (response) async {
          if (response.IsSuccess == true && response.Data == "1") {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "OTP send successfully", gravity: ToastGravity.BOTTOM);
          } else {
            Fluttertoast.showToast(
                msg: "OTP not Send", gravity: ToastGravity.BOTTOM);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 21),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top + 2,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "Enter Verification Code",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text("We have sent the verification code on",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text("${widget.mobile}"),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 80),
                    child: PinCodeTextField(
                      controller: txtOTP,
                      autofocus: false,
                      wrapAlignment: WrapAlignment.center,
                      highlight: true,
                      pinBoxHeight: 50,
                      pinBoxWidth: 50,
                      pinBoxRadius: 8,
                      highlightColor: Colors.grey,
                      defaultBorderColor: Colors.grey,
                      hasTextBorderColor: Colors.black,
                      maxLength: 4,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text("Enter verification code you received on SMS",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 13.0, right: 13, top: 30),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: RaisedButton(
                        color: appPrimaryMaterialColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () {
                          rndnumber == txtOTP.text
                              ? widget.logindata == null
                                  ? Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RegistrationScreen(
                                                Mobile: widget.mobile,
                                              )),
                                      (route) => false)
                                  : saveDataToSession()
                              : Fluttertoast.showToast(msg: "OTP is wrong");
                        },
                        child: Text(
                          "Verify",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text("Resend OTP",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
