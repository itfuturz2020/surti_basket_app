import 'package:flutter/material.dart';
import 'package:surti_basket_app/CustomWidgets/InputField.dart';
import 'package:surti_basket_app/transitions/ShowUp.dart';


class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController houseNotxt = new TextEditingController();
  TextEditingController apratmenttxt = new TextEditingController();

  final List<String> _addressTypeList = ["Home", "Office", "Other"];
  int selected_Index;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: ShowUp(
              delay: 500,
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
                    controller: apratmenttxt,
                    hintText: "Streat details you locate",
                    label: "Streat details you locate",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InputFiled(
                    controller: apratmenttxt,
                    hintText: "Landmark for easy to reach out",
                    label: "Landmark for easy to reach out",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InputFiled(
                    controller: apratmenttxt,
                    hintText: "Area Details",
                    label: "*Area Details",
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
                  children:
                  List.generate(_addressTypeList.length, (index) {
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
                              print(_addressTypeList[index]);
                            });
                          }
                        },
                      ),
                    );
                  }),
                ),
              ]),
            )),
      ),
    );
  }
}
