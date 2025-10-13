import 'package:e_attendance/core/utils/app_utils/date_time_utils.dart';
import 'package:e_attendance/core/utils/extensions/loader_extension.dart';
import 'package:e_attendance/core/utils/extensions/toast_extension.dart';
import 'package:e_attendance/data/models/clock_in_out_model.dart';
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_exception.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_service.dart';
import 'package:e_attendance/presentation/features/user/home/location/location_controller.dart';
import 'package:e_attendance/presentation/features/user/home/timer/timer_controller.dart';
import 'package:e_attendance/presentation/widgets/alert_dialog.dart';
import 'package:e_attendance/presentation/widgets/textbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/app_routes/route_constants.dart';

class UserHomeController extends GetxController {
  final TimerController _timerController;
  final LocationController _locationController;
  final ClockinoutService _clockinoutService;

  final FirebaseAuth _auth;
  RxString clkInTime = "--:--".obs;
  RxString clkOutTime = "--:--".obs;
  RxString clkInKey = "".obs;
  RxString inLocation = "not Clocked In Yet".obs;
  RxString outLocation = "not Clocked Out Yet".obs;
  RxString date = "".obs;
  RxString userEmail="".obs;

  UserHomeController({
    required TimerController timerController,
    required LocationController locationController,
    required ClockinoutService clockinoutService,
    required FirebaseAuth auth,
  }) : _timerController = timerController,
       _locationController = locationController,
       _clockinoutService = clockinoutService,

       _auth = auth;

  @override
  void onInit() {
    fetchLatestAttendanceRecord();
    super.onInit();
  }

  void fetchLatestAttendanceRecord() async {
    var record = await _clockinoutService.getRecentUserRecord(
      _auth.currentUser!.uid,
    );
    if (record != null) {
      if (record.clockOutTime == null) {
        _timerController.startTimer(record.clockInTime!);
      }

      if (record.clockOutTime == null) {
        clkInTime.value = record.clockInTime ?? "--:--";
        clkOutTime.value = record.clockOutTime ?? "--:--";
        _timerController.duration.value = record.duration ?? "00:00:00";
        clkInKey.value = record.key!;
        inLocation.value = record.clockInLocation!;
        outLocation.value = record.clockOutLocation ?? "not clocked out yet";
        date.value = record.date ?? "";
      }
    }
    userEmail.value=_auth.currentUser!.email!;
  }

  @override
  void dispose() {
    _timerController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void onclockIn() async {
    try {
      if (_locationController.location.value == "") {
        Get.showToast("Enable location to continue");
        return;
      }

      if (clkInTime.value != "--:--"&&clkOutTime.value=="--:--") {
        Get.showToast("Already Clocked in!");
        return;
      }

      Get.showLoadingDialog();
      String inTime = DateTimeUtils.formatCurrentTime;
      var res = await _clockinoutService.create(
        ClockInOutModel(
          userKey: _auth.currentUser!.uid,
          clockInLocation: _locationController.location.value,
          clockInTime: inTime,
          date: DateTimeUtils.formatCurrentDate,
        ),
      );
      Get.showToast("ClockIn Success");
      if (res != null) {
        clkInTime.value = inTime;
        _timerController.startTimer(inTime);
        inLocation.value = _locationController.location.value;
        date.value = DateTimeUtils.formatCurrentDate;
        clkInKey.value = res;
        clkOutTime.value="--:--";
        outLocation.value="not Clocked Out Yet";


        Get.hideLoading();
      } else {
        Get.hideLoading();
      }
    } on ClockinoutException catch (e) {
      Get.showToast(e.message);
      Get.hideLoading();
    }
  }

  void onClockOut() async {
    try {
      if (clkInTime.value == "--:--" || clkOutTime.value != "--:--") {
        Get.showToast("Already Clocked Out!");
        return;
      }
      if (_locationController.location.value == "") {
        Get.showToast("Enable location to continue");
        return;
      }

      Get.showLoadingDialog();
      String outTime = DateTimeUtils.formatCurrentTime;
      await _clockinoutService.update(
        ClockInOutModel(
          clockInLocation: inLocation.value,
          clockInTime: clkInTime.value,
          date: date.value,
          key: clkInKey.value,
          userKey: _auth.currentUser!.uid,
          clockOutLocation: _locationController.location.value,
          clockOutTime: DateTimeUtils.formatCurrentTime,
          duration: _timerController.duration.value,
        ),
      );

      clkOutTime.value = outTime;
      outLocation.value=_locationController.location.value;
      _timerController.stopTimer();

      Get.hideLoading();
       Get.showToast("ClockOut Success");
    } on ClockinoutException catch (e) {
      Get.hideLoading();
      Get.showToast(e.message);
    }
  }

  toClockInOutHistory() {
    Get.toNamed(Routes.clockingHistory);
  }

  logout() async {
    showAlert(isdismiss: true,
      title: "Logout?",
      description: "Are You Sure to Logout?",
      actions: [
        CustomTextButton(
          btnModel: ButtonModel(
            title: "Yes",
            onclick: () async {
              await _auth.signOut().then((value) {
                Get.offAllNamed(Routes.login);
              });
            },
          ),
        ),
         CustomTextButton(
          btnModel: ButtonModel(
            title: "No",
            onclick: () async {
             Get.back();
            },
          ),
        ),
      ],
    );
  }
}
