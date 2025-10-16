import 'package:e_attendance/core/app_exceptions/app_exception.dart';
import 'package:e_attendance/data/repositories/business%20hour/business_hour_repo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class BusinessHourRepoImpl extends BusinessHourRepo {
  final String path = "BusinessHours";
  final FirebaseDatabase _database;

  BusinessHourRepoImpl({required FirebaseDatabase database})
    : _database = database;

  @override
  Future<List<Map<String, dynamic>>> getBusinessHours() async {
    try {
      final snapshot = await _database.ref().child(path).get();

      if (!snapshot.exists) return [];

      final value = snapshot.value;

      if (value is List) {
        return value
            .where((e) => e != null)
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      }

      return [];
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<void> saveBusinessHours(List<Map<String, dynamic>> list) async {
    try {
      final data = list.asMap().map(
        (index, item) => MapEntry(index.toString(), item),
      );
      var res= _database.ref().child(path).push();
      


      await _database.ref().child(path).set(data);
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
Future<Map<String, dynamic>> getTodayBusinessHours() async {
  var today=DateFormat("EEEE").format(DateTime.now());
  try {
    final snapshot = await _database
        .ref()
        .child(path)
        .orderByChild("day")
        .equalTo(today)
        .get();

    if (!snapshot.exists) return {};

    final value = snapshot.value;

    if (value is Map) {
      final firstEntry = value.values.first;
      return Map<String, dynamic>.from(firstEntry as Map);
    }

    return {};
  } catch (e) {
    throw AppException.handle(e);
  }
}
}
