

import 'package:e_attendance/data/models/clock_in_out_model.dart';

abstract class ClockinoutService {
  Future<List<ClockInOutModel>>getUserRecords(String userKey);
    Future<ClockInOutModel?>getRecentUserRecord(String userKey);

  Future<String?> create(ClockInOutModel data);
  Future<void> update(ClockInOutModel data);
    Future<List<ClockInOutModel>>getAllRecords();


}