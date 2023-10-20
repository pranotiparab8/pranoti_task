import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranoti_task/Pages/ReminderApp/remainder_controller.dart';

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
      appBar: AppBar(title: Text("Add activity")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(7, (index) {
                return Obx(() => CheckboxListTile(
                      value: myController.checkboxValues[index],
                      title: Text(myController.weekDays[index]),
                      onChanged: (value) {
                        myController.checkboxValues[index] = value!;
                      },
                    ));
              }),
            )
        ],
      ),
    );
  }
}
