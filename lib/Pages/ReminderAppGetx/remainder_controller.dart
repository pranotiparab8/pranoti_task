import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Remainder.dart';

class RemainderController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();
  //TextEditingController numEditingController = TextEditingController();
  //TextEditingController numEditingController1 = TextEditingController();
  RxInt selectedValue = 0.obs;
  RxList<bool> radioValues = List.generate(6, (index) => false).obs;
  RxList<Remainder> registeredRemainders = <Remainder>[].obs;
  List databaseList = [];
  var tmpArray = [];
  RxString editeddate = 'No date selected'.obs;
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
  DateTime? pickedDate = DateTime.now();
  RxString pickedDate1 = 'No date selected'.obs;
  RxString editedName = 'name'.obs;
  // RxInt editedId = 0.obs;
  RxString editedfreq = 'name'.obs;
}
