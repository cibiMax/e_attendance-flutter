import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatElapsedTimeFromClockIn(DateTime clockIn) {
  final totalSeconds = DateTime.now().difference(clockIn).inSeconds;

  final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
  final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
  final seconds = (totalSeconds % 60).toString().padLeft(2, '0');

  return '$hours:$minutes:$seconds';
}
  static String get formatCurrentDate =>
      DateFormat("dd/MM/yyyy").format(DateTime.now());
  static String get displayDate =>
      DateFormat("MMM dd yyyy,EEEE").format(DateTime.now());
  static String get formatCurrentTime =>
      DateFormat("hh:mm:ss a").format(DateTime.now());
  static String formatHoursTimeFromReference(DateTime clockInTime) {
  final diff = DateTime.now().difference(clockInTime);
  final hours = diff.inHours;
  return hours.toString().padLeft(2, '0');
}

static String formatMinTimeFromReference(DateTime clockInTime) {
  final diff = DateTime.now().difference(clockInTime);
  final minutes = diff.inMinutes % 60;
  return minutes.toString().padLeft(2, '0');
}

static String formatSecondsTimeFromReference(DateTime clockInTime) {
  final diff = DateTime.now().difference(clockInTime);
  final seconds = (diff.inSeconds % 60); 
  return seconds.toString().padLeft(2, '0');
}
static String formattedHistoryDate(String date) =>
      DateFormat("dd \n MMMM,\n yyyy").format(DateFormat("dd/MM/yyy").parse(date));
}
