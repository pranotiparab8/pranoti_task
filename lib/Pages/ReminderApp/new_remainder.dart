import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:pranoti_task/Pages/ReminderApp/remainder_controller.dart';

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
  void _submitRemainderData() {
    widget.onAddRemainder(Remainder(
        taskName: myController.textEditingController.text,
        date: myController.pickedDate != null
            ? DateFormat('dd-MM-yyyy').format(myController.pickedDate!)
            : null,
        frequency: myController.frequency[myController.selectedValue.value]));
    Navigator.pop(context);
  }

  RemainderController myController = Get.put(RemainderController());
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: myController.textEditingController,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: "Task Name"),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              myController.pickedDate != null
                  ? Text(
                      "${DateFormat('dd-MM-yyyy').format(myController.pickedDate!)}")
                  : Text("No date selected"),
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
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
                },
                child: const Icon(Icons.calendar_month),
              ),
            ],
          ),
          const SizedBox(height: 30),
          InkWell(
              onTap: () {
                Get.to(() => AddFrequency());
              },
              child: const Text(
                "Frequency",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )),
          Obx(() =>
              Text(myController.frequency[myController.selectedValue.value])),
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
                  _submitRemainderData();
                  final database = await DatabaseHelper().database;
                  await database.insert(
                    'tasks',
                    {
                      'taskName': myController.textEditingController.text,
                      'date': myController.pickedDate != null
                          ? DateFormat('dd-MM-yyyy')
                              .format(myController.pickedDate!)
                          : null,
                      'frequency': myController
                          .frequency[myController.selectedValue.value],
                    },
                  );
                  // _getTextFromUser(
                  //     myController.textEditingController.text,
                  //     myController.pickedDate != null
                  //         ? DateFormat('dd-MM-yyyy')
                  //             .format(myController.pickedDate!)
                  //         : null,
                  //     myController.frequency[myController.selectedValue.value]);
                  await DatabaseHelper().updateTask(5, {
                    'taskName': "Hello5",
                    'date': '25-09-1098',
                    'frequency': 'daily',
                  });
                  //await database.delete('tasks');
                  await DatabaseHelper().deleteTask(1);
                  print(await database.query('tasks'));
                  // myController.remainderList
                  //     .assignAll(await database.query('tasks'));

                  debugPrint(
                      'Notification Scheduled for ${myController.pickedDate}');
                  NotificationService().scheduleNotification(
                      title: myController.textEditingController.text,
                      body: myController.pickedDate != null
                          ? DateFormat('dd-MM-yyyy')
                              .format(myController.pickedDate!)
                          : null,
                      scheduledNotificationDateTime: myController.pickedDate!);
                  //Navigator.of(context).pop();
                  setState(() {});
                },
                child: const Text("Save Expense")),
          ]),
          InkWell(
            onTap: () async {
              final database = await DatabaseHelper().database;
              await database.insert(
                'tasks',
                {
                  'taskName': myController.textEditingController.text,
                  'date': myController.pickedDate != null
                      ? DateFormat('dd-MM-yyyy')
                          .format(myController.pickedDate!)
                      : null,
                  'frequency':
                      myController.frequency[myController.selectedValue.value],
                },
              );
              // _getTextFromUser(
              //     myController.textEditingController.text,
              //     myController.pickedDate != null
              //         ? DateFormat('dd-MM-yyyy')
              //             .format(myController.pickedDate!)
              //         : null,
              //     myController.frequency[myController.selectedValue.value]);
              await DatabaseHelper().updateTask(5, {
                'taskName': "Hello5",
                'date': '25-09-1098',
                'frequency': 'daily',
              });
              //await database.delete('tasks');
              await DatabaseHelper().deleteTask(1);
              print(await database.query('tasks'));
              // myController.remainderList
              //     .assignAll(await database.query('tasks'));

              Navigator.of(context).pop();
              debugPrint(
                  'Notification Scheduled for ${myController.pickedDate}');
              NotificationService().scheduleNotification(
                  title: myController.textEditingController.text,
                  body: myController.pickedDate != null
                      ? DateFormat('dd-MM-yyyy')
                          .format(myController.pickedDate!)
                      : null,
                  scheduledNotificationDateTime: myController.pickedDate!);
              setState(() {});
            },
            child: const Text("Notify",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ],
      ),
    );
  }

  // _getTextFromUser(taskName, date, frequency) {
  //   setState(() {
  //     myController.remainderList.add(Remainder(
  //       taskName: taskName,
  //       date: date,
  //       frequency: frequency,
  //     ));
  //   });
  // }
}
