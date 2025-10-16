
import 'package:e_attendance/data/models/business_hour_model.dart';

abstract class BusinessHourRepo {
  Future<List<BusinessHourModel>> getBusinessHours();
  Future<void> saveBusinessHours(List<BusinessHourModel> list);
  Future<BusinessHourModel?> getTodayBusinessHours();
}
