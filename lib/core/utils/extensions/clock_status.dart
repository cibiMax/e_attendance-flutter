import 'package:flutter/material.dart';

enum ClockStatus {
  normal,
  earlyClockOut,
  overtime,
}

extension ClockStatusExt on ClockStatus {
  String get label {
    switch (this) {
      case ClockStatus.normal:
        return "Normal";
      case ClockStatus.earlyClockOut:
        return "Early ClockOut";
      case ClockStatus.overtime:
        return "OT";
    }
  }

  static ClockStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case "normal":
        return ClockStatus.normal;
      case "early clockout":
        return ClockStatus.earlyClockOut;
      case "ot":
        return ClockStatus.overtime;
      default:
        return ClockStatus.normal;
    }
  }


  Color get color {
    switch (this) {
      case ClockStatus.normal:
        return Colors.green;
      case ClockStatus.earlyClockOut:
        return Colors.orange;
      case ClockStatus.overtime:
        return Colors.red;
    }
  }
}
