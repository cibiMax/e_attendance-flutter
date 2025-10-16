import 'package:e_attendance/data/repositories/user/user_repo.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../core/app_exceptions/app_exception.dart';

class UserRepoImpl implements UserRepository {
  final FirebaseDatabase db;
  final String path = "AppUser";

  UserRepoImpl({required this.db});
  @override
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final res = await db.ref().child(path).get();
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
  Future<void> createUser(Map<String, dynamic> user) async {
    try {
      final ref = db.ref().child(path).child(user["userKey"]);
      await ref.set({...user});
      return;
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<Map<String, dynamic>?> isuser(String email) async {
    try {
      final ref = db.ref().child(path);
      final snapshot = await ref.orderByChild('email').equalTo(email).get();

      if (snapshot.exists) {
        var mainvalue = snapshot.children.first;

        final usersMap = Map<String, dynamic>.from(mainvalue.value as Map);
        return usersMap;
      } else {
        return null;
      }
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<String> getEmailByKey(String key) async {
    try {
      final ref = db.ref().child(path).child(key);
      final snapshot = await ref.get();

      if (snapshot.exists) {
        var mainvalue = snapshot.children.first;

        final usersMap = Map<String, dynamic>.from(mainvalue.value as Map);
        return usersMap["email"];
      } else {
        return "";
      }
    } catch (e) {
      throw AppException.handle(e);
    }
  }
}
