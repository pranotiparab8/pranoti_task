import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _Counter = 50;
  Timer? _timer;

  void startTime() {
    try {
      _timer?.cancel();
    } catch (e) {
      print(e);
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_Counter > 0) {
        setState(() {
          _Counter--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isRunning = _timer == null ? false : _timer!.isActive;
    bool isCounterZero = (_Counter == 0 || _Counter == 50) ? true : false;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_Counter',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: isCounterZero,
              child: ElevatedButton(
                onPressed: () {
                  startTime();
                  _Counter = 50;
                },
                child: Text('Start Timer'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: isRunning,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _timer?.cancel();
                    print("pause");
                  });
                },
                child: Text('Pause'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _timer?.cancel();
                    _Counter = 50;
                  });
                },
                child: Text('Reset')),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !isRunning,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    startTime();
                  });
                },
                child: Text('Resume'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
