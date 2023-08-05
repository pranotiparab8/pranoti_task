import 'package:flutter/material.dart';

class SimulatorScreenShot extends StatefulWidget {
  const SimulatorScreenShot({Key? key}) : super(key: key);

  @override
  State<SimulatorScreenShot> createState() => _SimulatorScreenShotState();
}

class _SimulatorScreenShotState extends State<SimulatorScreenShot> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    Widget contWid(String str, Color colour) {
      return Expanded(
        child: InkWell(
          onTap: () {
            abc(str);
          },
          child: Container(
            decoration: BoxDecoration(color: colour),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                        child: Text(
                      str,
                    ))),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Simulator Screen Shot"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                contWid("1", Colors.greenAccent),
                contWid("2", Colors.green),
              ],
            ),
          ),
          contWid("3", Colors.yellow),
          Expanded(
            child: Row(
              children: [
                contWid("4", Colors.red),
                contWid("5", Colors.blue),
              ],
            ),
          ),
          isShow ? contWid("6", Colors.amber) : Container(),
        ],
      ),
    );
  }

  void abc(String str) {
    switch (str) {
      case "1":
        print("One");
        break;
      case "2":
        print("Two");
        break;
      case "3":
        print("Three");
        break;
      case "4":
        print("Four");
        break;
      case "5":
        print("Five");
        break;
      case "6":
        print("Six");
        break;
    }
    // if (str == "1") {
    //   print("One");
    // } else if (str == "2") {
    //   print("Two");
    // } else if (str == "3") {
    //   print("Three");
    // } else if (str == "4") {
    //   print("Four");
    // } else if (str == "5") {
    //   print("Five");
    // } else if (str == "6") {
    //   print("Six");
    // }
  }
}
