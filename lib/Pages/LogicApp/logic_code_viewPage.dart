import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic_controller.dart';

class CodeViewPage extends StatefulWidget {
  const CodeViewPage({Key? key}) : super(key: key);
  // final String receivedValue;

  @override
  State<CodeViewPage> createState() => _CodeViewPageState();
}

class _CodeViewPageState extends State<CodeViewPage> {
  MylogicController myController = Get.put(MylogicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(myController.valueToPass.value)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                    '${myController.logicList.first[myController.valueToPass.value]}'),
              ),
              const Text("   Count:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                    controller: myController.textEditingController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(border: OutlineInputBorder())),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if ((myController.valueToPass.value) ==
                          "Fibonacci Series") {
                        myController.series.value =
                            myController.generateFibonacciSeries(int.parse(
                                myController.textEditingController.text));
                        myController.output.value =
                            myController.series.value.toString();
                      }
                      if ((myController.valueToPass.value) == "Prime number") {
                        myController.pattern.value =
                            myController.generatePattern(int.parse(
                                myController.textEditingController.text));
                        myController.output.value = myController.pattern.value;
                      }
                    },
                    child: const Text("Run")),
              ),
              Obx(() => Center(
                    child: Container(
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Text(myController.output.value),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
