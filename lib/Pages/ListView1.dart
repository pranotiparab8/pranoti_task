import 'package:flutter/material.dart';

class ListView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget listWid(double height1, Color colour, String str2, String strImg) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(strImg), alignment: Alignment.topLeft),
            color: colour),
        height: height1,
        child: Center(child: Text(str2)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView"),
      ),
      body: ListView(
        children: <Widget>[
          listWid(50, Colors.lime, 'Apple', "images/cat.jpg"),
          SizedBox(height: 5),
          listWid(50, Colors.yellow, 'Banana', "images/cat.jpg"),
          SizedBox(height: 5),
          listWid(50, Colors.red, 'Mango', "images/cat.jpg"),
          SizedBox(height: 5),
          listWid(50, Colors.pink, 'Orange', "images/cat.jpg"),
        ],
      ),
    );
  }
}
