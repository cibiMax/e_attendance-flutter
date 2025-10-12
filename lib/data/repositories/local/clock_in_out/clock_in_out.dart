abstract class ClockInOutLocal {
  ///save clock in time in local storage as key value
  Future<void> saveClockInTime(String time);

  ///get clockin time
  String? getClockInTime();

  ///save clockin inserted id (key)
  Future<void> saveClockInID(String id);
  String? getClockInID();
  Future<void> clearClockInID();
  Future<void> clearClockInTime();
}
