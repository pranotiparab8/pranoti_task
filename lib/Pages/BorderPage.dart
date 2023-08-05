import 'package:flutter/material.dart';

class BorderPage extends StatelessWidget {
  const BorderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Border Page"),
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.green, width: 5, style: BorderStyle.solid),
            // border: Border.symmetric(
            //     horizontal: BorderSide.none, vertical: BorderSide.none),
            //borderRadius: BorderRadius.circular(200),
            // borderRadius: BorderRadius.horizontal(
            //     left: Radius.circular(100), right: Radius.circular(200)),
            //borderRadius: BorderRadius.all(Radius.circular(600)),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(100),
                topLeft: Radius.circular(50),
                topRight: Radius.circular(100)),
            // gradient: LinearGradient(
            //     colors: Colors.accents,
            //     begin: Alignment.topRight,
            //     end: Alignment.bottomLeft),
            image: DecorationImage(
                image: AssetImage("images/cat.jpg"), fit: BoxFit.fill),
            // gradient: RadialGradient(colors: [
            //   Colors.blue,
            //   Colors.red,
            // ], radius: 1),
            boxShadow: [
              BoxShadow(
                  color: Colors.red,
                  blurRadius: 10,
                  spreadRadius: 5,
                  blurStyle: BlurStyle.outer,
                  offset: Offset.zero)
            ]),
        // child: Align(
        //     alignment: Alignment.center, child: Image.asset("images/cat.jpg")),
      ),
    );
  }
}
