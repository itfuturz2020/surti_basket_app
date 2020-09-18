import 'package:flutter/material.dart';


class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(),
      bottomNavigationBar: Container(
        height: 45,
        color: Colors.white,
        child: Row(
          children: [
            Column(
              children: [
                Text("RS 450"),
                Text("Saved 5 %"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
