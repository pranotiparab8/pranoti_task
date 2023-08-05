import 'package:flutter/material.dart';

class MyFirstPage extends StatelessWidget {
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Page"),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('1st Page'),
          const SizedBox(height: 20),
          Expanded(child: Image.asset("images/cat.jpg")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Icon(Icons.favorite))
        ],
      ),
    );
  }
}
