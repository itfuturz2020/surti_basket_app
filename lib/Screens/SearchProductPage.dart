import 'package:flutter/material.dart';

class SearchProductPage extends StatefulWidget {
  @override
  _SearchProductPageState createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Product"),
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10.0,bottom: 10.0),
            child: TextFormField(
              cursorColor: Colors.grey,
              decoration: new InputDecoration(
                contentPadding: const EdgeInsets.all(3.0),
                hintText: 'What do you want ?',
                hintStyle: TextStyle(fontSize: 13),
                prefixIcon: Icon(Icons.search, color: Colors.black54, size: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          preferredSize: Size.fromHeight(55.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: ListView.separated(
          itemBuilder: (BuildContext context,int index){
            return InkWell(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Oats Breakfast"),
              ),
            );
          },
          itemCount: 10,
          separatorBuilder: (context,index){
            return Container(
              height: 1,
              color: Colors.grey[200],
            );
          },
        ),
      ),
    );
  }
}
