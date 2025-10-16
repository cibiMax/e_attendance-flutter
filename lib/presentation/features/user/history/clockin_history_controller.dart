import 'package:e_attendance/core/app_exceptions/app_exception.dart';
import 'package:e_attendance/data/models/clock_in_out_model.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_service.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get/get.dart';

class ClockinHistoryController extends GetxController {
  final ClockinoutService _clockinoutService;

  final FirebaseAuth _auth;
  final RxBool isloading = false.obs;
  final RxList<ClockInOutModel> list = <ClockInOutModel>[].obs;
  final RxString err = "".obs;
  late final String? userID;

  ClockinHistoryController({
    required ClockinoutService clockinoutService,
    String? userKey,
    required FirebaseAuth auth,
  }) : _clockinoutService = clockinoutService,

       _auth = auth;

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>?;

    userID = args?['userKey'];
    fetchClockingHistory();
    super.onInit();
  }

  void fetchClockingHistory() async {
    try {
      isloading.value = true;
      var res = await _clockinoutService.getUserRecords(
        userID ?? _auth.currentUser!.uid,
      );
      list.value = res;
      isloading.value = false;
    } on AppException catch (e) {
      err.value = e.msg;
    }
  }
}
