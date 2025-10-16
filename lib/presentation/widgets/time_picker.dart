import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TimePickerDialog(initialTime: TimeOfDay(hour: 0, minute: 0));
  }
}
