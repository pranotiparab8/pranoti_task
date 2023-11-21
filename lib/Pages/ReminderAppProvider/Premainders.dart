import 'package:flutter/material.dart';

import 'PRemainder.dart';
import 'PRemainderList.dart';
import 'Pnew_remainder.dart';

class PRemainders extends StatefulWidget {
  const PRemainders({Key? key}) : super(key: key);

  @override
  State<PRemainders> createState() => _PRemaindersState();
}

class _PRemaindersState extends State<PRemainders> {
  String name = "John Doe";
  String date = "";
  String freq = "";
  String editedName = 'name';
  String editeddate = 'name';
  String editedfreq = 'name';
  TextEditingController textEditingController = TextEditingController();
  final List<PRemainder> _registeredRemainders = [
    PRemainder(
        taskName: 'Birthday wish', date: '25-09-1995', frequency: 'daily'),
    PRemainder(taskName: 'bday', date: '25-09-1995', frequency: 'weekly'),
  ];

  void _openAddRemainderOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (ctx) => PNewRemainder(
        onAddRemainder: _addRemainder,
      ),
    );
  }

  void _addRemainder(PRemainder remainder) {
    setState(() {
      _registeredRemainders.add(remainder);
    });
  }

  void _removeExpense(PRemainder remainder) {
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

  void _updateRemainder(PRemainder remainder) {
    final remainderIndex = _registeredRemainders.indexOf(remainder);
    print("object updated");

    setState(() {});
    _showEditDialog();
    if (remainderIndex >= 0 && remainderIndex < _registeredRemainders.length) {
      setState(() {
        final remainder = _registeredRemainders[remainderIndex];
        _registeredRemainders[remainderIndex] = PRemainder(
          taskName: editedName,
          date: editeddate,
          frequency: editedfreq,
        );

        _registeredRemainders.insert(remainderIndex, remainder);
        _registeredRemainders.removeAt(remainderIndex);
      });
    }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(editedName);
        return AlertDialog(
          title: Text("Edit Fields"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: textEditingController,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {});
                  editedName = textEditingController.text;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  editedName = textEditingController.text;
                  name = editedName;
                  date = editeddate;
                  freq = editedfreq;
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
    setState(() {});
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No Remainders found. Start adding some!'),
    );
    if (_registeredRemainders.isNotEmpty) {
      mainContent = PRemainderList(
        remainders: _registeredRemainders,
        onRemoveExpense: _removeExpense,
        onUpdateRemainder: _updateRemainder,
      );
    }
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
            Expanded(child: mainContent),
          ],
        ));
  }
}
