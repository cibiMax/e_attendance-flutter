import 'package:e_attendance/core/constants/local_constants.dart';
import 'package:e_attendance/core/utils/app_utils/local_util.dart';
import 'package:e_attendance/data/repositories/local/user/user.dart';

class UserLocalImpl implements UserLocal {
  final LocalUtils _localUtils;

  UserLocalImpl({required LocalUtils localUtils}) : _localUtils = localUtils;
  @override
  String? getUserKey() {
    return _localUtils.getString(SharedPreferencesConstants.userKey);
  }

  @override
  Future<void> saveUserKey(String key) async {
    return await _localUtils.saveString(
      SharedPreferencesConstants.userKey,
      key,
    );
  }
}
