import 'package:flutter/material.dart';

class MySecondPage extends StatelessWidget {
  const MySecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('2st Page'),
          const SizedBox(height: 20),
          Align(
              alignment: Alignment.center,
              child: Image.asset("images/cat.jpg")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Icon(Icons.favorite))
        ],
      ),
    );
  }
}
