import 'package:flutter/material.dart';
import 'package:pranoti_task/Pages/ReminderApp/local_notifications.dart';

DateTime scheduleTime = DateTime(2023, 11, 3, 11, 14);

class scheHomePage extends StatefulWidget {
  const scheHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<scheHomePage> createState() => _scheHomePageState();
}

class _scheHomePageState extends State<scheHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DatePickerTxt(),
          ScheduleBtn(),
        ],
      )),
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({Key? key}) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // DatePicker.showDateTimePicker(context,
        //     showTitleActions: true,
        //     onChanged: (date) => scheduleTime = date,
        //     onConfirm: (date) {});
      },
      child: Text('Select Date Time', style: TextStyle(color: Colors.blue)),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
          title: 'Schedule Notification',
          body: '$scheduleTime',
          scheduledNotificationDateTime: scheduleTime,
        );
      },
      child: const Text('Schedule Notifications'),
    );
  }
}
