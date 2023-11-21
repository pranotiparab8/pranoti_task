import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PRemainderController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  RxInt selectedValue = 0.obs;
  RxList<bool> radioValues = List.generate(6, (index) => false).obs;

  RxList tmpArray = [].obs;
  RxMap<String, bool> values = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  }.obs;
  getCheckboxItems() {
    tmpArray.clear();
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    print(tmpArray);
  }

  RxList<String> frequency = [
    'Daily',
    'Weekly',
    'Monthly',
    'Quaterly',
    'Half-yearly',
    'Yearly',
  ].obs;
  //RxList<Remainder> remainderList = <Remainder>[].obs;
  DateTime? pickedDate;
}
