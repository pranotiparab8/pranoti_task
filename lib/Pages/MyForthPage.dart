import 'package:flutter/material.dart';

class MyForthPage extends StatelessWidget {
  const MyForthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forth Page"),
      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text('4th Page', textAlign: TextAlign.start)),
          SizedBox(height: 20),
          Align(
              alignment: Alignment.center,
              child:
                  Image.asset("images/cat.jpg", alignment: Alignment.center)),
          SizedBox(height: 20),
          Align(
              alignment: Alignment.bottomRight,
              child:
                  ElevatedButton(onPressed: () {}, child: Icon(Icons.favorite)))
        ],
      ),
    );
  }
}
