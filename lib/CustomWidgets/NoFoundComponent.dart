import 'package:flutter/material.dart';

class NoFoundComponent extends StatelessWidget {
  String ImagePath, Title;

  NoFoundComponent({this.ImagePath, this.Title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("${ImagePath}", width: 200),
            ],
          ),
          Text("${Title}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black54))
        ],
      ),
    );
  }
}
