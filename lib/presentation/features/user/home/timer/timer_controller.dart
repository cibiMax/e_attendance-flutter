import 'dart:async';
import 'package:e_attendance/core/utils/app_utils/date_time_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimerController extends GetxController {
  late DateTime _startTime;
  Timer? _timer;

  var duration = "00:00:00".obs;

  void startTimer(String clockInTime) {
    _startTime = _parseClockInTime(clockInTime);

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final hours = DateTimeUtils.formatHoursTimeFromReference(_startTime);
      final minutes = DateTimeUtils.formatMinTimeFromReference(_startTime);
      final seconds = DateTimeUtils.formatSecondsTimeFromReference(_startTime);

      duration.value = "$hours:$minutes:$seconds";
    });
  }



  DateTime _parseClockInTime(String clockInTime) {
    final now = DateTime.now();
    final parsedTime = DateFormat("hh:mm:ss a").parse(clockInTime);

    return DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
      parsedTime.second,
    );
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
