import 'package:flutter/material.dart';
import 'package:pranoti_task/Pages/ReminderApp/RemainderList.dart';

import 'Remainder.dart';
import 'new_remainder.dart';

class Remainders extends StatefulWidget {
  const Remainders({Key? key}) : super(key: key);

  @override
  State<Remainders> createState() => _RemaindersState();
}

class _RemaindersState extends State<Remainders> {
  final List<Remainder> _registeredRemainders = [
    Remainder(
        taskName: 'Birthday wish', date: '25-09-1995', frequency: 'daily'),
    Remainder(taskName: 'bday', date: '25-09-1995', frequency: 'weekly'),
  ];

  void _openAddRemainderOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewRemainder(
        onAddRemainder: _addRemainder,
      ),
    );
  }

  void _addRemainder(Remainder remainder) {
    setState(() {
      _registeredRemainders.add(remainder);
    });
  }

  void _removeExpense(Remainder remainder) {
    final remainderIndex = _registeredRemainders.indexOf(remainder);
    setState(() {
      _registeredRemainders.remove(remainder);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Remainder deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredRemainders.insert(remainderIndex, remainder);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No Remainders found. Start adding some!'),
    );
    if (_registeredRemainders.isNotEmpty) {
      mainContent = RemainderList(
          remainders: _registeredRemainders, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter RemainderTracker'),
        actions: [
          IconButton(
              onPressed: _openAddRemainderOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Expanded(child: mainContent),
              ],
            )
          : Row(children: [
              Expanded(child: mainContent),
            ]),
    );
  }
}
