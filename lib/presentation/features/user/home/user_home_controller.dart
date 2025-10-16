import 'package:e_attendance/core/app_exceptions/app_exception.dart';
import 'package:e_attendance/core/constants/string_constants.dart';
import 'package:e_attendance/core/utils/app_utils/date_time_utils.dart';
import 'package:e_attendance/core/utils/extensions/clock_status.dart';
import 'package:e_attendance/core/utils/extensions/loader_extension.dart';
import 'package:e_attendance/core/utils/extensions/toast_extension.dart';
import 'package:e_attendance/data/models/clock_in_out_model.dart';
import 'package:e_attendance/domain/services/businesshour/business_hour_service.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_service.dart';
import 'package:e_attendance/presentation/features/user/home/location/location_controller.dart';
import 'package:e_attendance/presentation/features/user/home/timer/timer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/app_routes/route_constants.dart';
import '../../../../core/utils/app_utils/clock_in_out_utils.dart'
    show ClockUtils;

class UserHomeController extends GetxController {
  final TimerController _timerController;
  final LocationController _locationController;
  final ClockinoutService _clockinoutService;
  final BusinessHourService _businessHourService;

  final FirebaseAuth _auth;
  RxString clkInTime = StringConstants.initialClkValue.obs;
  RxString businessHours = "".obs;

  RxString clkOutTime = StringConstants.initialClkValue.obs;
  RxString clkInKey = "".obs;
  RxString inLocation = "not Clocked In Yet".obs;
  RxString outLocation = "not Clocked Out Yet".obs;
  RxString date = "".obs;
  RxString userEmail = "".obs;

  UserHomeController({
    required TimerController timerController,
    required LocationController locationController,
    required ClockinoutService clockinoutService,
    required BusinessHourService businessHourService,
    required FirebaseAuth auth,
  }) : _timerController = timerController,
       _locationController = locationController,
       _clockinoutService = clockinoutService,
       _businessHourService = businessHourService,
       _auth = auth;

  @override
  void onInit() {
    fetchTodayBHours();
    fetchLatestAttendanceRecord();
    super.onInit();
  }

  void fetchTodayBHours() async {
    try {
      var res = await _businessHourService.getTodayBusinessHours();
      if (res != null) {
        businessHours.value = "${res.from} to ${res.to}";
      }
    } on AppException catch (e) {
      Get.showToast(e.msg);
    }
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
        clkInTime.value = record.clockInTime ?? StringConstants.initialClkValue;
        clkOutTime.value =
            record.clockOutTime ?? StringConstants.initialClkValue;
        _timerController.duration.value = record.duration ?? "00:00:00";
        clkInKey.value = record.key!;
        inLocation.value = record.clockInLocation!;
        outLocation.value = record.clockOutLocation ?? "not clocked out yet";
        date.value = record.date ?? "";
      }
    }
    userEmail.value = _auth.currentUser!.email!;
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

    if(businessHours.value.isEmpty){
       Get.showToast("Cannot clock in since business hours are empty");
       return;
    }

    if (clkInTime.value != StringConstants.initialClkValue &&
        clkOutTime.value == StringConstants.initialClkValue) {
      Get.showToast("Already Clocked in!");
      return;
    }

    // Restrict Clock In to business hours only
    if (businessHours.value.isNotEmpty) {
      final parts = businessHours.value.split(' to ');
      if (parts.length == 2) {
        final now = DateTime.now();
        final startTime = ClockUtils.parseTime(parts[0]);
        final endTime = ClockUtils.parseTime(parts[1]);

        if (now.isBefore(startTime) || now.isAfter(endTime)) {
          Get.showToast(
            "Clock In is only allowed during business hours (${parts[0]} - ${parts[1]})",
          );
          return;
        }
      }
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
      clkOutTime.value = StringConstants.initialClkValue;
      outLocation.value = "not Clocked Out Yet";
    }

    Get.hideLoading();
  } on AppException catch (e) {
    Get.hideLoading();
    Get.showToast(e.msg);
  }
}

  void onClockOut() async {
    try {
      if (clkInTime.value == StringConstants.initialClkValue ||
          clkOutTime.value != StringConstants.initialClkValue) {
        Get.showToast("Already Clocked Out!");
        return;
      }
      if (_locationController.location.value == "") {
        Get.showToast("Enable location to continue");
        return;
      }

      Get.showLoadingDialog();

      final outTime = DateTimeUtils.formatCurrentTime;

      final status = ClockUtils.calculateStatus(
        clkInTime.value,
        outTime,
        businessHours.value,
      );

      await _clockinoutService.update(
        ClockInOutModel(
          userKey: _auth.currentUser!.uid,
          clockInTime: clkInTime.value,
          clockOutTime: outTime,
          clockInLocation: inLocation.value,
          clockOutLocation: _locationController.location.value,
          date: date.value,
          key: clkInKey.value,
          duration: _timerController.duration.value,
          status: status.label,
        ),
      );

      clkOutTime.value = outTime;
      outLocation.value = _locationController.location.value;
      _timerController.stopTimer();

      Get.hideLoading();
      Get.showToast("Clock Out Success — ${status.label}");
    } on AppException catch (e) {
      Get.hideLoading();
      Get.showToast(e.msg);
    }
  }

  toClockInOutHistory() {
    Get.toNamed(Routes.clockingHistory);
  }

 }
