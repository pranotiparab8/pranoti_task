import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Pages/ChatApp/GetxApp/Chat_appGetx.dart';

void main() => runApp(MyApp());

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
      home: Chat_appGetx(),
    );
  }
}
