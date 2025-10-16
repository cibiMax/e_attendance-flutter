import 'package:e_attendance/core/app_exceptions/app_exception.dart';
import 'package:e_attendance/data/repositories/clock_in_out/clock_in_out_repo.dart';
import 'package:firebase_database/firebase_database.dart';

class ClockInOutRepoImpl implements ClockInOutRepo {
  final String path = "ClockInOut";
  final FirebaseDatabase db;

  ClockInOutRepoImpl({required this.db});
  @override
  Future<String?> clockIn(Map<String, dynamic> clockInOutModel) async {
    try {
      var ref = db.ref(path).child(clockInOutModel["userKey"]).push();

      await ref.set({...clockInOutModel, "key": ref.key});
      return ref.key;
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<void> clockOut(Map<String, dynamic> clockInOutModel) async {
    try {
      final userKey = clockInOutModel["userKey"] as String?;
      final recordKey = clockInOutModel["key"] as String?;

      final ref = db.ref(path).child(userKey!).child(recordKey!);

      await ref.set({...clockInOutModel});
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUserRecords(String userkey) async {
    try {
      final res = await db.ref().child(path).child(userkey).get();
      if (res.exists) {
        // Return raw data as list of maps
        final List<Map<String, dynamic>> users = res.children.map((child) {
          final data = Map<String, dynamic>.from(child.value as Map);
          return data;
        }).toList();

        return users;
      } else {
        return [];
      }
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllRecords() async {
    final List<Map<String, dynamic>> allRecords = [];

    try {
      final snapshot = await db.ref().child("ClockInOut").get();

      if (snapshot.exists && snapshot.value != null) {
        final allData = Map<String, dynamic>.from(snapshot.value as Map);

        allData.forEach((userKey, userRecords) {
          if (userRecords is Map) {
            userRecords.forEach((recordKey, recordData) {
              if (recordData is Map) {
                final record = Map<String, dynamic>.from(recordData);
                record['recordKey'] = recordKey;
                record['userKey'] = userKey; // keep user key if needed
                allRecords.add(record);
              }
            });
          }
        });
      }

      return allRecords;
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<Map<String, dynamic>?> getRecentRecord(String userKey) async {
    try {
      final ref = db.ref().child(path).child(userKey);

      // Query the last record
      final snapshot = await ref.orderByKey().limitToLast(1).get();

      if (!snapshot.exists) return null;

      final data = snapshot.value as Map<dynamic, dynamic>;
      final lastRecord = data.values.first as Map<dynamic, dynamic>;

      return Map<String, dynamic>.from(lastRecord);
    } catch (e) {
      throw AppException.handle(e);
    }
  }
}
