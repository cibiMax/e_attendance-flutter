import 'package:e_attendance/data/models/app_user_model.dart';
import 'package:e_attendance/data/repositories/user/user_repo.dart';
import 'package:e_attendance/data/repositories/user/user_repo_exception.dart';
import 'package:e_attendance/domain/services/user/user_service.dart';
import 'package:e_attendance/domain/services/user/user_service_exception.dart';

class UserServiceImpl implements UserService {
  final UserRepository userRepository;
  UserServiceImpl({required this.userRepository});

  @override
  Future<void> createUser(AppUserModel user) async {
    try {
      return await userRepository.createUser(user.toMap());
    } on UserRepoException catch (e) {
      throw (UserServiceException(message: (e .msg)));
    }
  }

  @override
  Future<List<AppUserModel>> getUsers() async {
    try {
      var res = await userRepository.getAllUsers();
      return res.map((e) => AppUserModel.fromMap(e)).toList();
    } on UserRepoException catch (e) {
      throw UserServiceException(message: e.toString());
    }
  }

  @override
  Future<String?> isuserExist(String email) async {
    try {
      var res = await userRepository.isuser(email);
      return res?["userKey"] as String?;
    } on UserRepoException catch (e) {
      throw UserServiceException(message: e.toString());
    }
  }

  @override
  Future<String> getEmailByKey(String userKey) async {
    try {
      var res = await userRepository.getEmailByKey(userKey);
      return res;
    } catch (e) {
      throw UserServiceException(message: e.toString());
    }
  }
}
