import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/InputField.dart';
import 'package:surti_basket_app/Providers/Addressprovider.dart';
import 'package:surti_basket_app/Providers/CartProvider.dart';
import 'package:surti_basket_app/transitions/fade_route.dart';

import 'AddressScreen.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController houseNotxt = new TextEditingController();
  TextEditingController apratmenttxt = new TextEditingController();
  TextEditingController streettxt = new TextEditingController();
  TextEditingController landmarkttxt = new TextEditingController();
  TextEditingController areadetailtxt = new TextEditingController();
  TextEditingController addDescriptiontxt = new TextEditingController();
  TextEditingController pincodetxt = new TextEditingController();

  final List<String> _addressTypeList = ["Home", "Office", "Other"];
  int selected_Index;
  String SelectedCity;
  bool isAddressLoading = false;
  bool isLoading = false;
  List _City = [];
  Location location = new Location();
  LocationData locationData;
  String latitude, longitude;

  @override
  void initState() {
    getCityData();
    super.initState();
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Sorry",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text("we can deliver on this address"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: FlatButton(
                  child: new Text(
                    "Cancel",
                    style: TextStyle(color: appPrimaryMaterialColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.only(
            top: 6.0,
            bottom: 0.0,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              // Row(
              //   children: [
              //     Flexible(
              //       child: Padding(
              //         padding: const EdgeInsets.all(4.0),
              //         child: InputFiled(
              //           controller: houseNotxt,
              //           hintText: "Home/Apt No",
              //           label: "*House No",
              //         ),
              //       ),
              //     ),
              //     Flexible(
              //       child: Padding(
              //         padding: const EdgeInsets.all(4.0),
              //         child: InputFiled(
              //           controller: apratmenttxt,
              //           hintText: "Apartment Name",
              //           label: "Apartment Name",
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: InputFiled(
              //     controller: streettxt,
              //     hintText: "Street details you locate",
              //     label: "Street details you locate",
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: InputFiled(
              //     controller: landmarkttxt,
              //     hintText: "Landmark for easy to reach out",
              //     label: "Landmark for easy to reach out",
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InputFiled(
                  controller: areadetailtxt,
                  hintText: "Area Details",
                  label: "*Area Details",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InputFiled(
                  controller: addDescriptiontxt,
                  hintText: "Add Descriptions",
                  label: "*Add Descriptions",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13.0, left: 12),
                      child: _City.length > 0
                          ? DropdownButton(
                              hint: Text('Please Select City',
                                  style: TextStyle(fontSize: 14)),
                              // Not necessary for Option 1
                              value: SelectedCity,
                              onChanged: (newValue) {
                                setState(() {
                                  SelectedCity = newValue;
                                });
                              },
                              items: _City.map((City) {
                                return DropdownMenuItem<String>(
                                  child: new Text(City),
                                  value: City,
                                );
                              }).toList(),
                            )
                          : CircularProgressIndicator(),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: pincodetxt,
                        validator: (pin) {
                          if (pin.length != 6 || pin.length == 0) {
                            return 'Please enter Valid Pincode';
                          }
                          return null;
                        },
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: 'Enter Pincode',
                          hintStyle:
                              TextStyle(fontSize: 13.0, color: Colors.grey),
                          labelText: "Enter pincode",
                          labelStyle:
                              TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 10),
                    child: Text(
                      "  Select Address Type *",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 10,
                children: List.generate(_addressTypeList.length, (index) {
                  return SizedBox(
                    child: ChoiceChip(
                      shape: RoundedRectangleBorder(),
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(color: Colors.black),
                      label: Text(_addressTypeList[index]),
                      selected: selected_Index == index,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selected_Index = index;
                          });
                        }
                      },
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 40),
                child: SizedBox(
                  height: 45,
                  child: FlatButton(
                    color: appPrimaryMaterialColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.grey[200])),
                    onPressed: () {
                      //_addAddress();
                      _checkPinCode();
                    },
                    child: isAddressLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text(
                                  "Add Address",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      // color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ])),
      ),
    );
  }

  _getLocation() async {
    try {
      locationData = await location.getLocation();
      if (locationData != null) {
        setState(() {
          latitude = locationData.latitude.toString();
          longitude = locationData.longitude.toString();
          isLoading = false;
        });

        print("---------------->" + "${latitude}" + " " + "${longitude}");
      }
    } catch (e) {
      locationData = null;
    }
  }

  _checkPinCode() async {
    if (_formKey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isAddressLoading = true;
          });
          FormData body = FormData.fromMap({"PincodeNo": pincodetxt.text});
          Services.postForSave(apiname: 'checkPincode', body: body).then(
              (responseremove) async {
            if (responseremove.IsSuccess == true &&
                responseremove.Data != "0") {
              setState(() {
                isAddressLoading = false;
              });
              _addAddress();
            } else {
              setState(() {
                Fluttertoast.showToast(msg: responseremove.Message);
                //responseMessage = responseremove.Message;
                isAddressLoading = false;
              });
            }
          }, onError: (e) {
            setState(() {
              isAddressLoading = false;
            });
            print("error on call -> ${e.message}");
            Fluttertoast.showToast(msg: "something went wrong");
          });
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: "No Internet Connection");
      }
    } else {
      Fluttertoast.showToast(msg: "Please Enter All Fields");
    }
  }

  _addAddress() async {
    if (_formKey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          FormData body = FormData.fromMap({
            "CustomerId": prefs.getString(Session.customerId),
            "AddressHouseNo": "",
            "AddressAppartmentName": "",
            "AddressStreet": "",
            "AddressLandmark": "",
            "AddressArea": areadetailtxt.text,
            "AddressType": _addressTypeList[selected_Index].toString(),
            "AddressPincode": pincodetxt.text,
            "AddressCityName": SelectedCity,
            "AddressLat": "",
            "AddressLong": "",
            "AddressDetail": addDescriptiontxt.text,
          });
          print(body.fields);
          setState(() {
            isAddressLoading = true;
          });
          Services.postForSave(apiname: 'addAddress', body: body).then(
              (responseList) async {
            setState(() {
              isAddressLoading = false;
            });

            if (responseList.IsSuccess == true && responseList.Data == "1") {
              Fluttertoast.showToast(msg: "Address added successfully");
              //Navigator.push(context, FadeRoute(page: (AddressScreen())));
              await Provider.of<CartProvider>(context, listen: false)
                  .getAdressData();
              Navigator.pushReplacement(
                  context, FadeRoute(page: (AddressScreen())));
            } else {
              _showDialog(context);
            }
          }, onError: (e) {
            setState(() {
              isAddressLoading = false;
            });
            print("error on call -> ${e.message}");
            Fluttertoast.showToast(msg: "Something Went Wrong");
          });
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: "No Internet Connection.");
      }
    } else
      Fluttertoast.showToast(msg: "Please fill pincode field");
  }

  getCityData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.postforlist(apiname: 'getCity').then((responselist) async {
          if (responselist.length > 0) {
            setState(() {
              _City = responselist;
            });
            _getLocation();
            print(_City);
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "No City Found!");
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
}
