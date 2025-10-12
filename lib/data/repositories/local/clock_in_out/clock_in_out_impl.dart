import 'package:e_attendance/data/repositories/local/clock_in_out/clock_in_out.dart';
import 'package:e_attendance/core/constants/local_constants.dart';
import 'package:e_attendance/core/utils/app_utils/local_util.dart';

class ClockInOutLocalImpl extends ClockInOutLocal {
  final LocalUtils _localUtils;
  ClockInOutLocalImpl({required LocalUtils localUtils})
    : _localUtils = localUtils;

  ///save clock in time in local storage as key value
  @override
  Future<void> saveClockInTime(String time) async {
    await _localUtils.saveString(SharedPreferencesConstants.clockInTime, time);
  }

  ///get clockin time
  @override
  String? getClockInTime() {
    return _localUtils.getString(SharedPreferencesConstants.clockInTime);
  }

  ///save clock in ID
  @override
  Future<void> saveClockInID(String id) async {
    await _localUtils.saveString(SharedPreferencesConstants.clockInID, id);
  }

  @override
  String? getClockInID() {
    return _localUtils.getString(SharedPreferencesConstants.clockInID);
  }

  @override
  Future<void> clearClockInID() async {
    await _localUtils.remove(SharedPreferencesConstants.clockInID);
  }

  @override
  Future<void> clearClockInTime() async {
    await _localUtils.remove(SharedPreferencesConstants.clockInTime);
  }
}
