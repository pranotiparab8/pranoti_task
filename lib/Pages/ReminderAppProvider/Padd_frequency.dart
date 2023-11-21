import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ReminderAppGetx/remainder_controller.dart';

class PAddFrequency extends StatefulWidget {
  const PAddFrequency({Key? key}) : super(key: key);

  @override
  State<PAddFrequency> createState() => _PAddFrequencyState();
}

class _PAddFrequencyState extends State<PAddFrequency> {
  RemainderController myController = Get.put(RemainderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Frequency")),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(6, (index) {
            return Obx(() => RadioListTile(
                  value: index,
                  groupValue: myController.selectedValue.value,
                  onChanged: (val) {
                    setState(() {});
                    myController.selectedValue.value = val!;
                  },
                  title: Text(myController.frequency[index]),
                ));
          }),
        ),
        if (myController.selectedValue.value == 1)
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: List.generate(7, (index) {
          //     return Obx(() => CheckboxListTile(
          //           value: myController.checkboxValues[index],
          //           title: Text(myController.weekDays[index]),
          //           onChanged: (value) {
          //             print(myController.checkboxValues[index]);
          //             values.forEach((key, value) {
          //               if (value == false) {
          //                 tmpArray.add(key);
          //                 //print(tmpArray);
          //               }
          //             });
          //
          //             myController.checkboxValues[index] = value!;
          //             //selecteditems.add(myController.checkboxValues[index]);
          //
          //             //myController.selectedValue.value = value;
          //           },
          //         ));
          //   }),
          // )
          Expanded(
            child: ListView(
              children: myController.values.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: myController.values[key],
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      myController.getCheckboxItems();
                      myController.values[key] = value!;
                      print(myController.values[key]);
                    });
                  },
                );
              }).toList(),
            ),
          ),
      ]),
    );
  }
}
