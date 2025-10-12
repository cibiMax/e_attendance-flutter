import 'package:e_attendance/data/models/clock_in_out_model.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_service.dart';
import 'package:e_attendance/domain/services/user/user_service_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClockingListController extends GetxController {
  final ClockinoutService _clockinoutService;
  final RxBool isloading = false.obs;
  final RxList<ClockInOutModel> list = <ClockInOutModel>[].obs;
  final RxList<ClockInOutModel> filteredList = <ClockInOutModel>[].obs;
  final RxString err = "".obs;
  final RxString selectedDepartment = "".obs;
  final Rx<DateTimeRange?> selectedRange = Rx<DateTimeRange?>(null);
  final TextEditingController departmentController = TextEditingController();

  ClockingListController({required ClockinoutService clockinoutService})
    : _clockinoutService = clockinoutService;

  @override
  void onInit() {
    fetchAttendances();
    super.onInit();
  }

  void fetchAttendances() async {
    try {
      isloading.value = true;
      var res = await _clockinoutService.getAllRecords();
      list.value = res;
      filteredList.value = res;
      isloading.value = false;
    } on UserServiceException catch (e) {
      err.value = e.message;
    }
  }

  void sortByEmail() {
    filteredList.sort((a, b) => (a.email ?? '').compareTo(b.email ?? ''));
    filteredList.refresh();
  }

  void sortByDate() {
    filteredList.sort((a, b) {
      final dateA = DateTime.tryParse(a.date ?? '') ?? DateTime(0);
      final dateB = DateTime.tryParse(b.date ?? '') ?? DateTime(0);
      return dateB.compareTo(dateA); // newest first
    });
    filteredList.refresh();
  }

  void filterByDepartment() {
    selectedDepartment.value = departmentController.text;
    filteredList.value = list
        .where((e) => e.departmnet?.toLowerCase() == departmentController.text.toLowerCase())
        .toList();
  }

  Future<void> pickDateRange(BuildContext context) async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (range != null) {
      selectedRange.value = range;
      filteredList.value = list.where((record) {
        if (record.date == null) return false;
        final recordDate = DateTime.tryParse(record.date!);
        if (recordDate == null) return false;
        return recordDate.isAfter(
              range.start.subtract(const Duration(days: 1)),
            ) &&
            recordDate.isBefore(range.end.add(const Duration(days: 1)));
      }).toList();
    }
  }
}
