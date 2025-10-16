import 'package:intl/intl.dart';
import '../extensions/clock_status.dart' show ClockStatus;

class ClockUtils {
  static DateTime parseTime(String time) {
    final now = DateTime.now();

    DateTime parsed;
    try {
      parsed = DateFormat('hh:mm:ss a').parse(time);
    } catch (_) {
      parsed = DateFormat('hh:mm a').parse(time);
    }

    return DateTime(
      now.year,
      now.month,
      now.day,
      parsed.hour,
      parsed.minute,
      parsed.second,
    );
  }

  /// Calculates the status based on clock in/out and expected business hours
  static ClockStatus calculateStatus(
    String clockIn,
    String clockOut,
    String businessHours,
  ) {
    final inTime = parseTime(clockIn);
    final outTime = parseTime(clockOut);
    final duration = outTime.difference(inTime);

    final parts = businessHours.split(' to ');
    if (parts.length != 2) return ClockStatus.normal;

    final expectedStart = parseTime(parts[0]);
    final expectedEnd = parseTime(parts[1]);
    final expectedDuration = expectedEnd.difference(expectedStart);

    if (duration.inMinutes > expectedDuration.inMinutes + 2) {
      return ClockStatus.overtime;
    } else if (duration.inMinutes < expectedDuration.inMinutes - 2) {
      return ClockStatus.earlyClockOut;
    } else {
      return ClockStatus.normal;
    }
  }
}
