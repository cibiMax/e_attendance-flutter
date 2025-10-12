abstract class ClockInOutRepo {
  Future<String?> clockIn(Map<String, dynamic> clockInOutModel);
  Future<void> clockOut(Map<String, dynamic> clockInOutModel);
  Future<List<Map<String, dynamic>>> getUserRecords(String userkey);
  Future<List<Map<String, dynamic>>> getAllRecords();
  Future<Map<String, dynamic>?> getRecentRecord(String userKey);
}
