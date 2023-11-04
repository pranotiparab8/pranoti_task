import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Remainder.dart';

class RemainderController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  RxInt selectedValue = 0.obs;
  RxList<bool> radioValues = List.generate(6, (index) => false).obs;
  RxList<bool> checkboxValues = List.generate(7, (index) => false).obs;
  RxList<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ].obs;
  RxList<String> frequency = [
    'Daily',
    'Weekly',
    'Monthly',
    'Quaterly',
    'Half-yearly',
    'Yearly',
  ].obs;
  RxList<Remainder> remainderList = <Remainder>[].obs;
  DateTime? pickedDate;
}
