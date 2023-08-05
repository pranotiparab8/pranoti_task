import 'dart:math';

import 'package:flutter/material.dart';

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int x = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dice "),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                //child: Image.asset('images/dice$x.png'),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 5,
                    color: Colors.black,
                  ),
                ),
                height: 300,
                width: 300,
                child: Column(
                  children: [
                    Visibility(visible: x == 1, child: buildContainer1()),
                    Visibility(visible: x == 2, child: buildContainer2()),
                    Visibility(visible: x == 3, child: buildContainer3()),
                    Visibility(visible: x == 4, child: buildContainer4()),
                    Visibility(visible: x == 5, child: buildContainer5()),
                    Visibility(visible: x == 6, child: buildContainer6()),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    x = Random().nextInt(6) + 1;
                    print(x);
                  });
                },
                child: const Text("Change")),
          ],
        ),
      ),
    );
  }

  Container buildContainer1() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(85),
        child: const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 50,
        ));
  }

  Container buildContainer2() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(10),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 50,
            ),
            SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 50,
            )
          ],
        ));
  }

  Container buildContainer3() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(5),
        child: const Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 45,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 45,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 45,
                ),
              ],
            ),
          ],
        ));
  }

  Container buildContainer4() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(10),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                )
              ],
            ),
          ],
        ));
  }

  Container buildContainer5() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(5),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 45,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 45,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 45,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 45,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 45,
                ),
              ],
            ),
          ],
        ));
  }

  Container buildContainer6() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(5),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40,
                ),
              ],
            ),
          ],
        ));
  }
}
