import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'RandomNumController.dart';

class RandomNum extends StatelessWidget {
  RandomNum({Key? key}) : super(key: key);

  var randomNumController = RandomNumController();

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Number Generator "),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Text(
                  '${randomNumController.x.value}',
                  style: TextStyle(fontSize: 30),
                )),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  randomNumController.x.value = (Random().nextInt(90) + 1);
                  print(randomNumController.x.value);
                },
                child: Text("Change")),
          ],
        ),
      ),
    );
  }
}
