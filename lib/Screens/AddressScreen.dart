import 'package:flutter/material.dart';
import 'package:surti_basket_app/CustomWidgets/AddressComponent.dart';
import 'package:surti_basket_app/Screens/UpdateProfileScreen.dart';
import 'package:surti_basket_app/transitions/slide_route.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Address",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("SAVED ADDRESS",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, SlideLeftRoute(page: UpdateProfileScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("+ ADD NEW ADDRESS",
                          style: TextStyle(fontSize: 15, color: Colors.blueAccent,fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return AddressComponent();
              },
              itemCount: 2,
              shrinkWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
