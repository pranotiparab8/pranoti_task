import 'package:flutter/material.dart';

import 'PRemainder.dart';
import 'PRemainder_item.dart';

class PRemainderList extends StatefulWidget {
  const PRemainderList(
      {Key? key,
      required this.remainders,
      required this.onRemoveExpense,
      required this.onUpdateRemainder})
      : super(key: key);

  final List<PRemainder> remainders;
  final void Function(PRemainder remainder) onUpdateRemainder;
  final void Function(PRemainder remainder) onRemoveExpense;

  @override
  State<PRemainderList> createState() => _PRemainderListState();
}

class _PRemainderListState extends State<PRemainderList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.remainders.length, //myController.remainderList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(widget.remainders[index]),
        onDismissed: (direction) {
          widget.onRemoveExpense(widget.remainders[index]);
        },
        child: InkWell(
            onTap: () {
              setState(() {});
              widget.onUpdateRemainder(widget.remainders[index]);
              print("list updated");
            },
            child: PRemainderItem(widget.remainders[index])),
      ),
    );
  }
}
