import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranoti_task/Pages/ReminderAppGetx/remainder_controller.dart';

class AddFrequency extends StatefulWidget {
  const AddFrequency({Key? key}) : super(key: key);

  @override
  State<AddFrequency> createState() => _AddFrequencyState();
}

class _AddFrequencyState extends State<AddFrequency> {
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
                    myController.selectedValue.value = val!;
                  },
                  title: Text(myController.frequency[index]),
                ));
          }),
        ),
        if (myController.selectedValue.value == 1)
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
