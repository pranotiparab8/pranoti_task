import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PRemainder.dart';
import 'Premainder_controller.dart';

class PRemainderItem extends StatelessWidget {
  PRemainderItem(this.remainder, {super.key});
  PRemainderController myController = Get.put(PRemainderController());
  final PRemainder remainder;
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
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.date_range),
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
