import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../ReminderAppGetx/remainder_controller.dart';
import 'Remainder.dart';
import 'add_frequency.dart';
import 'database.dart';
import 'local_notifications.dart';

class NewRemainder extends StatefulWidget {
  const NewRemainder({Key? key, required this.onAddRemainder})
      : super(key: key);
  final void Function(Remainder remainder) onAddRemainder;
  @override
  State<NewRemainder> createState() => _NewRemainderState();
}

class _NewRemainderState extends State<NewRemainder> {
  RemainderController myController = Get.put(RemainderController());
  AddFrequency addFrequency = const AddFrequency();
  String concatenatedString = '';

  @override
  Widget build(BuildContext context) {
    concatenatedString = myController.tmpArray.join(' ');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField(
          //   controller: myController.numEditingController,
          //   decoration: const InputDecoration(
          //       border: UnderlineInputBorder(), labelText: "Task ID"),
          // ),
          const SizedBox(height: 20),
          TextField(
            controller: myController.textEditingController,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: "Task Name"),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Obx(() => (myController.pickedDate1.value != null)
                  ? Text(myController.pickedDate1.value)
                  //myController.pickedDate != null
                  : const Text("No date selected")),
              //DateFormat('dd-MM-yyyy').format(myController.pickedDate!)
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  setState(() {});
                  print(
                      "myController.pickedDate1.value ${myController.pickedDate1.value}");
                  print("myController.pickedDate ${myController.pickedDate}");

                  myController.pickedDate = await showOmniDateTimePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime(1600).subtract(const Duration(days: 3652)),
                    lastDate: DateTime.now().add(
                      const Duration(days: 3652),
                    ),
                    is24HourMode: false,
                    isShowSeconds: false,
                    minutesInterval: 1,
                    secondsInterval: 1,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    constraints: const BoxConstraints(
                      maxWidth: 350,
                      maxHeight: 650,
                    ),
                    transitionBuilder: (context, anim1, anim2, child) {
                      return FadeTransition(
                        opacity: anim1.drive(
                          Tween(
                            begin: 0,
                            end: 1,
                          ),
                        ),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 200),
                    barrierDismissible: true,
                  );
                  if (myController.pickedDate != null) {
                    myController.pickedDate1.value =
                        "${myController.pickedDate}";
                  }
                },
                child: const Icon(Icons.calendar_month),
              ),
            ],
          ),
          const SizedBox(height: 30),
          InkWell(
              onTap: () {
                Get.to(() => const AddFrequency());
              },
              child: const Text(
                "Frequency",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )),
          Obx(() => (myController.selectedValue.value == 1)
              ? Text(concatenatedString)
              : Text(myController.frequency[myController.selectedValue.value])),
          const SizedBox(height: 30),
          Row(children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () async {
                  //_submitRemainderData();
                  final database = await DatabaseHelper().database;
                  await database.insert(
                    'tasks',
                    {
                      //'id': myController.numEditingController.text,
                      'taskName': myController.textEditingController.text,
                      'date': myController.pickedDate != null
                          ? DateFormat('dd-MM-yyyy')
                              .format(myController.pickedDate!)
                          : const Text("No date selected"),
                      'frequency': (myController.selectedValue.value == 1)
                          ? concatenatedString
                          : myController
                              .frequency[myController.selectedValue.value]
                    },
                  );
                  // await DatabaseHelper().updateTask(5, {
                  //   'taskName': "Hello5",
                  //   'date': '25-09-1098',
                  //   'frequency': 'daily',
                  // });
                  //await database.delete('tasks');
                  //await DatabaseHelper().deleteTask(1);
                  print(await database.query('tasks'));

                  myController.databaseList = await database.query('tasks');
                  myController.registeredRemainders
                      .assignAll(myController.databaseList.map((e) => Remainder(
                            id: e['id'],
                            taskName: e['taskName'],
                            date: e['date'],
                            frequency: e['frequency'],
                          )));
                  print("datalist ${myController.databaseList}");
                  print(
                      "myController.registeredRemainders ${myController.registeredRemainders}");

                  debugPrint(
                      'Notification Scheduled for ${myController.pickedDate}');
                  NotificationService().scheduleNotification(
                      title: myController.textEditingController.text,
                      body: myController.pickedDate != null
                          ? DateFormat('dd-MM-yyyy')
                              .format(myController.pickedDate!)
                          : "No date selected",
                      scheduledNotificationDateTime: myController.pickedDate!);

                  myController.textEditingController.text = '';
                  myController.pickedDate1.value = 'No date selected';
                  Navigator.of(context).pop();
                },
                child: const Text("Save")),
          ]),
        ],
      ),
    );
  }
}
