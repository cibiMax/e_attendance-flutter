import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final TimeOfDay initialTime;
  const TimePicker({super.key, required this.initialTime});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
      child: TimePickerDialog(
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.inputOnly,
      ),
    );
  }
}
