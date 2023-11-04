import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranoti_task/Pages/ReminderApp/remainder_controller.dart';

import 'Remainder.dart';

class RemainderItem extends StatelessWidget {
  RemainderItem(this.remainder, {super.key});
  RemainderController myController = Get.put(RemainderController());
  final Remainder remainder;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Task: ${remainder.taskName}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium), //remainder.taskName //myController.remainderList[index]["taskName"]
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.date_range),
              // widget.date != null?
              Text(remainder.date), //remainder.date
              //  : Text("No date selected"),
              const Spacer(),
              Text(remainder.frequency,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium) //remainder.frequency
            ],
          )
        ],
      ),
    ));
  }
}
