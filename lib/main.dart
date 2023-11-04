import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'Pages/ReminderApp/local_notifications.dart';
import 'Pages/ReminderApp/remainders.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // Widget build(BuildContext context) {
  //   return MultiProvider(
  //     providers: [
  //       // ChangeNotifierProvider(create: (_) => CountProvider()),
  //       ChangeNotifierProvider(create: (_) => ChatScreenProvider()),
  //     ],
  //     child: MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       home: Chat_app10(),
  //     ),
  //   );
  //   // return ChangeNotifierProvider(
  //   //   create: (_) => CountProvider(),
  //   //   child: MaterialApp(
  //   //     debugShowCheckedModeBanner: false,
  //   //     home: ExampleOneScreen(),
  //   //   ),
  //   // );
  // }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Flutter Notifications',
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: Colors.blue),
      // home: scheHomePage(title: 'Flutter Local Notifications'),
      home: Remainders(),
    );
  }
}
