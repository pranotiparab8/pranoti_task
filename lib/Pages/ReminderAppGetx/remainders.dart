import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:pranoti_task/Pages/ReminderAppGetx/remainder_controller.dart';

import '../ReminderAppGetx/RemainderList.dart';
import 'Remainder.dart';
import 'add_frequency.dart';
import 'database.dart';
import 'new_remainder.dart';

class Remainders extends StatefulWidget {
  const Remainders({Key? key}) : super(key: key);

  @override
  State<Remainders> createState() => _RemaindersState();
}

class _RemaindersState extends State<Remainders> {
  RemainderController myController = Get.put(RemainderController());

  String concatenatedString = '';
  @override
  void initState() {
    super.initState();
    displayList();
  }

  Future<void> displayList() async {
    setState(() {});

    final database = await DatabaseHelper().database;
    print(await database.query('tasks'));
    myController.databaseList = await database.query('tasks');
    myController.registeredRemainders
        .assignAll(myController.databaseList.map((e) => Remainder(
              id: e['id'],
              taskName: e['taskName'],
              date: e['date'],
              frequency: e['frequency'],
            )));
  }

  void _openAddRemainderOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewRemainder(
        onAddRemainder: _addRemainder,
      ),
    );
  }

  void _addRemainder(Remainder remainder) {
    setState(() {
      //final database = await DatabaseHelper().database;
      myController.registeredRemainders.add(remainder);
      //_registeredRemainders.assignAll(await database.query('tasks'));
    });
  }

  void _removeExpense(Remainder remainder) {
    final remainderIndex = myController.registeredRemainders.indexOf(remainder);
    setState(() {
      myController.registeredRemainders.remove(remainder);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Remainder deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            myController.registeredRemainders.insert(remainderIndex, remainder);
          });
        },
      ),
    ));
  }

  void _updateRemainder(Remainder remainder) {
    print(remainder.id);
    _showEditDialog(remainder);
  }

  void _showEditDialog(Remainder remainder) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Edit Fields"),
          content: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TextField(
                  //   controller: myController.numEditingController1,
                  //   decoration: const InputDecoration(labelText: 'Id'),
                  //   onChanged: (value) {
                  //     myController.editedId.value =
                  //         myController.numEditingController1.text;
                  //   },
                  // ),
                  //const SizedBox(height: 5),
                  TextField(
                    controller: myController.textEditingController1,
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      myController.editedName.value =
                          myController.textEditingController1.text;
                    },
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Row(
                      children: [
                        Obx(() => (myController.pickedDate != null)
                            ? Text(myController.editeddate.value)
                            : const Text("No date selected")),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            setState(() {});

                            myController.pickedDate =
                                await showOmniDateTimePicker(
                              context: context,
                              //initialDate: DateTime.now(),
                              firstDate: DateTime(1600)
                                  .subtract(const Duration(days: 3652)),
                              lastDate: DateTime.now().add(
                                const Duration(days: 3652),
                              ),
                              is24HourMode: false,
                              isShowSeconds: false,
                              minutesInterval: 1,
                              secondsInterval: 1,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              constraints: const BoxConstraints(
                                maxWidth: 350,
                                maxHeight: 650,
                              ),
                              transitionBuilder:
                                  (context, anim1, anim2, child) {
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
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              barrierDismissible: true,
                            );
                            if (myController.pickedDate != null) {
                              myController.editeddate.value =
                                  myController.pickedDate.toString();
                            }
                          },
                          child: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            myController.editedfreq.value = myController
                                .frequency[myController.selectedValue.value];
                            Get.to(() => const AddFrequency());
                          },
                          child: const Text(
                            "Frequency",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          )),
                      const SizedBox(width: 10),
                      myController.selectedValue.value == 1
                          ? Text(concatenatedString)
                          : Text(myController
                              .frequency[myController.selectedValue.value]),
                    ],
                  )
                ],
              )),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  final remainderIndex =
                      myController.registeredRemainders.indexOf(remainder);
                  if (remainderIndex >= 0 &&
                      remainderIndex <
                          myController.registeredRemainders.length) {
                    print("done");
                    final remainder =
                        myController.registeredRemainders[remainderIndex];
                    myController.registeredRemainders[remainderIndex] =
                        Remainder(
                      id: remainder.id,
                      taskName: myController.editedName.value.toString(),
                      date: myController.editeddate.value.toString(),
                      frequency: myController.editedfreq.value.toString(),
                    );
                    setState(() {});
                    // myController.registeredRemainders
                    //     .insert(remainderIndex, remainder);
                    // myController.registeredRemainders.removeAt(remainderIndex);
                    print("all done");
                  }
                  // myController.editedId.value =
                  //     myController.numEditingController.text;
                  myController.editedName.value =
                      myController.textEditingController1.text;
                  myController.editedfreq.value =
                      myController.frequency[myController.selectedValue.value];
                  myController.editeddate.value =
                      myController.pickedDate.toString();
                  // myController.textEditingController.text = "";
                  // myController.frequency[myController.selectedValue.value] = "";
                  // myController.pickedDate = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter RemainderTracker'),
          actions: [
            IconButton(
                onPressed: _openAddRemainderOverlay,
                icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Obx(() => (myController.registeredRemainders.isNotEmpty)
                ? Expanded(
                    child: RemainderList(
                    remainders: myController.registeredRemainders,
                    onRemoveExpense: _removeExpense,
                    onUpdateRemainder: _updateRemainder,
                  ))
                : Expanded(
                    child: Center(
                      child: Text('No Remainders found. Start adding some!'),
                    ),
                  ))
          ],
        ));
  }
}
