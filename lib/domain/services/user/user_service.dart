import 'package:e_attendance/data/models/app_user_model.dart';

abstract class UserService {
  Future<List<AppUserModel>> getUsers();
  Future<void > createUser(AppUserModel user);
  Future<String?> isuserExist(String email);
  Future<String> getEmailByKey(String userKey);
}
