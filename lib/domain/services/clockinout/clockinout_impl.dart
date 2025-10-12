import 'package:e_attendance/data/models/clock_in_out_model.dart';
import 'package:e_attendance/data/repositories/clock_in_out/clock_in_out_repo.dart';
import 'package:e_attendance/data/repositories/clock_in_out/clock_in_out_repo_exception.dart';
import 'package:e_attendance/data/repositories/user/user_repo.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_service.dart';

class ClockinoutServiceImpl implements ClockinoutService {
  final ClockInOutRepo clockInOutRepo;
  final UserRepository userRepository;

  ClockinoutServiceImpl({
    required this.clockInOutRepo,
    required this.userRepository,
  });
  @override
  Future<String?> create(ClockInOutModel data) async {
    try {
      return await clockInOutRepo.clockIn(data.toMap());
    } on ClockInOutRepoException catch (e) {
      throw (ClockInOutRepoException(msg: e.msg));
    }
  }

  @override
  Future<List<ClockInOutModel>> getUserRecords(String key) async {
    try {
      var res = await clockInOutRepo.getUserRecords(key);
      return res.map((e) => ClockInOutModel.fromMap(e)).toList();
    } on ClockInOutRepoException catch (e) {
      throw (ClockInOutRepoException(msg: e.msg));
    }
  }

  @override
  Future<void> update(ClockInOutModel data) async {
    try {
      return await clockInOutRepo.clockOut(data.toMap());
    } on ClockInOutRepoException catch (e) {
      throw (ClockInOutRepoException(msg: e.msg));
    }
  }

  @override
  Future<List<ClockInOutModel>> getAllRecords() async {
    try {
      var clockInOutRecords = await clockInOutRepo.getAllRecords();
      var userRecords = await userRepository.getAllUsers();
      final userMap = {for (var user in userRecords) user['userKey']: user};

      final List<Map<String, dynamic>> mergedRecords = clockInOutRecords.map((
        record,
      ) {
        final userKey = record['userKey'];
        final userData = userMap[userKey] ?? {};

        return {...record, ...userData};
      }).toList();

      return mergedRecords.map((e) => ClockInOutModel.fromMap(e)).toList();
    } on ClockInOutRepoException catch (e) {
      throw (ClockInOutRepoException(msg: e.msg));
    }
  }

  @override
  Future<ClockInOutModel?> getRecentUserRecord(String userKey) async {
    try {
      var res = await clockInOutRepo.getRecentRecord(userKey);
      if (res == null) return null;
      return ClockInOutModel.fromMap(res);
    } on ClockInOutRepoException catch (e) {
      throw (ClockInOutRepoException(msg: e.msg));
    }
  }
}
