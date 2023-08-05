import 'dart:math';

import 'package:flutter/material.dart';

class RandomNumGenerate extends StatefulWidget {
  RandomNumGenerate({Key? key}) : super(key: key);

  @override
  State<RandomNumGenerate> createState() => _RandomNumGenerateState();
}

class _RandomNumGenerateState extends State<RandomNumGenerate> {
  int x = 1;
  Random random = Random();
  TextEditingController controllerMin = TextEditingController();
  TextEditingController controllerMax = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Number Generator "),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 35,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Min"),
                    controller: controllerMin,
                  ),
                ),
                Text("  to  "),
                SizedBox(
                    width: 35,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Max"),
                      controller: controllerMax,
                    )),
              ],
            ),
            Text(
              '$x',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    x = (random.nextInt((int.parse(controllerMax.text) -
                            int.parse(controllerMin.text))) +
                        int.parse(controllerMin.text));
                  });
                },
                child: Text("Change")),
          ],
        ),
      ),
    );
  }
}
