import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic_code_viewPage.dart';
import 'logic_controller.dart';

class LogicView extends StatefulWidget {
  const LogicView({Key? key}) : super(key: key);

  @override
  State<LogicView> createState() => _LogicViewState();
}

class _LogicViewState extends State<LogicView> {
  MylogicController myController = Get.put(MylogicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List of Logical programs")),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          final item = myController.logicList[0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: item.entries.map((entry) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: InkWell(
                  onTap: () {
                    myController.valueToPass.value = entry.key;
                    Get.to(CodeViewPage());
                  },
                  child: Text(
                    '${entry.key} ',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
