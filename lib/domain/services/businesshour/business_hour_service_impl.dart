import 'package:e_attendance/data/models/business_hour_model.dart';
import 'package:e_attendance/data/repositories/business%20hour/business_hour_repo.dart';
import 'package:e_attendance/domain/services/businesshour/business_hour_service.dart';

class BusinessHourServiceImpl extends BusinessHourService {
  final BusinessHourRepo _businessHourRepo;

  BusinessHourServiceImpl({required BusinessHourRepo businessHourRepo})
    : _businessHourRepo = businessHourRepo;

  @override
  Future<List<BusinessHourModel>> getBusinessHourSettings() async {
    final res = await _businessHourRepo.getBusinessHours();

    if (res.isEmpty) return [];

    return res.map((map) {
      final value = Map<String, dynamic>.from(map);
      return BusinessHourModel.fromMap(value);
    }).toList();
  }

  @override
  Future<void> saveBusinessHours(List<BusinessHourModel> businessHours) async {
    final data = businessHours.map((e) => e.toMap()).toList();
    await _businessHourRepo.saveBusinessHours(data);
  }

  @override
  Future<BusinessHourModel?> getTodayBusinessHours() async {
    var res = await _businessHourRepo.getTodayBusinessHours();
    if (res == {}) {
      return null;
    }
    return BusinessHourModel.fromMap(res);
  }
}
