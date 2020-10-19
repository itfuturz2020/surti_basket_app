import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/Constant.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/InputField.dart';
import 'package:surti_basket_app/CustomWidgets/LoadingComponent.dart';
import 'package:surti_basket_app/transitions/ShowUp.dart';

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
  TextEditingController pincodetxt = new TextEditingController();

  final List<String> _addressTypeList = ["Home", "Office", "Other"];
  int selected_Index;
  String SelectedCity;
  bool isAddressLoading = false;
  bool isLoading=false;
  List _City = [];

  @override
  void initState() {
    getCityData();
    super.initState();
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
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InputFiled(
                        controller: houseNotxt,
                        hintText: "Home/Apt No",
                        label: "*House No",
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InputFiled(
                        controller: apratmenttxt,
                        hintText: "Apartment Name",
                        label: "Apartment Name",
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InputFiled(
                  controller: streettxt,
                  hintText: "Street details you locate",
                  label: "Street details you locate",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InputFiled(
                  controller: landmarkttxt,
                  hintText: "Landmark for easy to reach out",
                  label: "Landmark for easy to reach out",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InputFiled(
                  controller: areadetailtxt,
                  hintText: "Area Details",
                  label: "*Area Details",
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top:13.0,left:12),
                      child: _City.length > 0 ? DropdownButton(
                        hint: Text('Please Select City',style: TextStyle(fontSize: 14)),
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
                      ):CircularProgressIndicator(),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: InputFiled(
                          controller: pincodetxt,
                          hintText: "Pincode",
                          label: "Pincode",
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
                      _addAddress();
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

  _addAddress() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.customerId),
          "AddressHouseNo": houseNotxt.text,
          "AddressAppartmentName": apratmenttxt.text,
          "AddressStreet": streettxt.text,
          "AddressLandmark": landmarkttxt.text,
          "AddressArea": areadetailtxt.text,
          "AddressType": _addressTypeList[selected_Index].toString(),
          "AddressPincode": pincodetxt.text,
          "AddressCityName": SelectedCity,
        });
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
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
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
  }

  getCityData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.postforlist(apiname: 'getCity').then(
                (responselist) async {
              setState(() {
                isLoading = false;
              });
              if (responselist.length > 0) {
                setState(() {
                  _City = responselist;
                });
                print(_City);
              } else {
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
