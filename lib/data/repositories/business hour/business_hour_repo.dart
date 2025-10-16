
abstract class BusinessHourRepo {
  Future<List<Map<dynamic, dynamic>>> getBusinessHours();
  Future<void> saveBusinessHours(List<Map<String, dynamic>> list);
  Future<Map<String, dynamic>> getTodayBusinessHours();
}
