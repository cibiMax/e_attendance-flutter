import 'package:e_attendance/data/models/business_hour_model.dart';

abstract class BusinessHourService {
  Future<List<BusinessHourModel>> getBusinessHourSettings();
  Future<void> saveBusinessHours(List<BusinessHourModel> businessHours);
  Future<BusinessHourModel?> getTodayBusinessHours();
}
