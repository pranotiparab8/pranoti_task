import 'package:flutter/material.dart';

class MyThirdPage extends StatelessWidget {
  const MyThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('3rd Page'),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                // border: Border.all(
                //     color: Colors.green, width: 3, style: BorderStyle.solid),
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset("images/cat.jpg")),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: Icon(Icons.favorite))
        ],
      ),
    );
  }
}
