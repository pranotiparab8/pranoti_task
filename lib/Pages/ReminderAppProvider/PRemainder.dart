import 'package:uuid/uuid.dart';

const uuid = Uuid();

//enum Frequency { daily, weekly, monthly, quaterly, halfyearly, yearly }

class PRemainder {
  final id;
  final taskName;
  final date;
  final frequency;

  PRemainder({
    this.taskName,
    this.date,
    this.frequency,
  }) : id = uuid.v4();
}
