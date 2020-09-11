import 'package:flutter/material.dart';


class AddressComponent extends StatefulWidget {
  @override
  _AddressComponentState createState() => _AddressComponentState();
}

class _AddressComponentState extends State<AddressComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:4.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Defualt Address:",style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold,fontSize: 15)),
                        Text(" Home",style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/edit.png',width: 18,height: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/delete.png',width: 18,height: 18),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mangroliya Keval",style: TextStyle(fontSize: 14,color: Colors.grey)),
                    Text("44 , Rambaug Society",style: TextStyle(fontSize: 14,color: Colors.grey)),
                    Text("A.K Road",style: TextStyle(fontSize: 14,color: Colors.grey)),
                    Text("Gausala",style: TextStyle(fontSize: 14,color: Colors.grey)),
                    Text("Mobile No: 9429828152",style: TextStyle(fontSize: 14,color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
