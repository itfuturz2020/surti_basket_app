import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surti_basket_app/Common/Colors.dart';
import 'package:surti_basket_app/Common/services.dart';
import 'package:surti_basket_app/CustomWidgets/InputField.dart';

class UpdateAddress extends StatefulWidget {
  var updateaddress;

  UpdateAddress({this.updateaddress});

  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  final List<String> _addressTypeList = ["Home", "Office", "Other"];
  int selected_Index;

  bool isupdateLoading = false;
  String Addresstype;

  final _formKey = GlobalKey<FormState>();
  TextEditingController houseNotxt = new TextEditingController();
  TextEditingController apratmenttxt = new TextEditingController();
  TextEditingController streettxt = new TextEditingController();
  TextEditingController landmarkttxt = new TextEditingController();
  TextEditingController areadetailtxt = new TextEditingController();
  TextEditingController pincodetxt = new TextEditingController();

  @override
  void initState() {
    setState(() {
      houseNotxt.text = widget.updateaddress["AddressHouseNo"];
      apratmenttxt.text = widget.updateaddress["AddressAppartmentName"];
      streettxt.text = widget.updateaddress["AddressStreet"];
      landmarkttxt.text = widget.updateaddress["AddressLandmark"];
      areadetailtxt.text = widget.updateaddress["AddressArea"];
      pincodetxt.text = widget.updateaddress["AddressPincode"];
      if (widget.updateaddress["AddressType"] == "Home") {
        setState(() {
          selected_Index = 0;
        });
      } else if (widget.updateaddress["AddressType"] == "Office") {
        setState(() {
          selected_Index = 1;
        });
      } else {
        setState(() {
          selected_Index = 2;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InputFiled(
                  controller: pincodetxt,
                  hintText: "Pincode",
                  label: "Pincode",
                ),
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
                      _updateAddress();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: isupdateLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                )
                              : Text(
                                  "Update Address",
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

  _updateAddress() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isupdateLoading = true;
        });

        FormData body = FormData.fromMap({
          "AddressId": "${widget.updateaddress["AddressId"]}",
          "AddressHouseNo": houseNotxt.text,
          "AddressAppartmentName": apratmenttxt.text,
          "AddressStreet": streettxt.text,
          "AddressLandmark": landmarkttxt.text,
          "AddressArea": areadetailtxt.text,
          "AddressPincode": pincodetxt.text,
          "AddressType": _addressTypeList[selected_Index].toString(),
        });

        Services.postForSave(apiname: 'updateAddress', body: body).then(
            (response) async {
          setState(() {
            isupdateLoading = false;
          });
          if (response.IsSuccess == true && response.Data == "1") {
            Fluttertoast.showToast(
                msg: "Address Updated Successfully",
                gravity: ToastGravity.BOTTOM);
          }
        }, onError: (e) {
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
          //showMsg("something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }
}
