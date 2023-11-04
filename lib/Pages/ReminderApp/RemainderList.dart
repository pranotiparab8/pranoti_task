import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranoti_task/Pages/ReminderApp/Remainder_item.dart';
import 'package:pranoti_task/Pages/ReminderApp/remainder_controller.dart';

import 'Remainder.dart';

class RemainderList extends StatelessWidget {
  RemainderList(
      {Key? key, required this.remainders, required this.onRemoveExpense})
      : super(key: key);

  final List<Remainder> remainders;
  final void Function(Remainder remainder) onRemoveExpense;
  RemainderController myController = Get.put(RemainderController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: remainders.length, //myController.remainderList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(remainders[index]),
        onDismissed: (direction) {
          onRemoveExpense(remainders[index]);
        },
        child: RemainderItem(remainders[index]),
      ),
    );
  }
}
