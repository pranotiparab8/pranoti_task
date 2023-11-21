import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranoti_task/Pages/ReminderAppGetx/remainder_controller.dart';

import '../ReminderAppGetx/Remainder_item.dart';
import 'Remainder.dart';
import 'database.dart';

class RemainderList extends StatefulWidget {
  const RemainderList(
      {Key? key,
      required this.remainders,
      required this.onRemoveExpense,
      required this.onUpdateRemainder})
      : super(key: key);

  final List<Remainder> remainders;
  final void Function(Remainder remainder) onUpdateRemainder;
  final void Function(Remainder remainder) onRemoveExpense;

  @override
  State<RemainderList> createState() => _RemainderListState();
}

class _RemainderListState extends State<RemainderList> {
  @override
  Widget build(BuildContext context) {
    RemainderController myController = Get.put(RemainderController());
    print("length __${widget.remainders.length}");
    return ListView.builder(
      itemCount: widget.remainders.length, //myController.remainderList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(widget.remainders[index]),
        onDismissed: (direction) async {
          await DatabaseHelper().deleteTask(widget.remainders[index].id);
          widget.onRemoveExpense(widget.remainders[index]);
        },
        child: InkWell(
            onTap: () async {
              // await DatabaseHelper()
              //     .updateTask(widget.remainders[index].id - 1, taskData);
              await DatabaseHelper().updateTask(widget.remainders[index].id, {
                // 'id': myController.editedId,
                'taskName': myController.editedName.value,
                'date': myController.editeddate.value,
                'frequency': myController.editedfreq.value,
              });
              widget.onUpdateRemainder(widget.remainders[index]);
            },
            child: RemainderItem(widget.remainders[index])),
      ),
    );
  }
}
