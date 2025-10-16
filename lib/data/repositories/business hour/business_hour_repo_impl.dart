import 'package:firebase_database/firebase_database.dart';
import 'package:e_attendance/core/app_exceptions/app_exception.dart';
import 'package:e_attendance/data/models/business_hour_model.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'business_hour_repo.dart';

class BusinessHourRepoImpl extends BusinessHourRepo {
  final FirebaseDatabase _database;
  final String path = "BusinessHours";

  BusinessHourRepoImpl({required FirebaseDatabase database})
    : _database = database;

  @override
  Future<void> saveBusinessHours(List<BusinessHourModel> hours) async {
    try {
      final data = {for (final item in hours) item.day: item.toMap()};

      await _database.ref().child(path).set(data);
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<List<BusinessHourModel>> getBusinessHours() async {
    try {
      final snapshot = await _database.ref().child(path).get();
      if (!snapshot.exists) return [];

      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return data.entries
          .map(
            (entry) => BusinessHourModel.fromMap(
              Map<String, dynamic>.from(entry.value),
            ),
          )
          .toList();
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<BusinessHourModel?> getTodayBusinessHours() async {
    try {
      final today = DateTime.now();
      final dayName = DateFormat('EEEE').format(today); 

      final snapshot = await _database.ref().child('$path/$dayName').get();
      if (!snapshot.exists) return null;

      final map = Map<String, dynamic>.from(snapshot.value as Map);
      return BusinessHourModel.fromMap(map);
    } catch (e) {
      throw AppException.handle(e);
    }
  }
}
