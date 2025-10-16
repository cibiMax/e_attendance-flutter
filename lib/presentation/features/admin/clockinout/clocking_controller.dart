import 'package:e_attendance/data/models/clock_in_out_model.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_service.dart';
import 'package:e_attendance/domain/services/user/user_service_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClockingListController extends GetxController {
  final ClockinoutService _clockinoutService;

  final RxBool isloading = false.obs;
  final RxList<ClockInOutModel> list = <ClockInOutModel>[].obs;
  final RxList<ClockInOutModel> filteredList = <ClockInOutModel>[].obs;
  final RxString err = "".obs;

  final RxString selectedDepartment = "".obs;
  final Rx<DateTimeRange?> selectedRange = Rx<DateTimeRange?>(null);
  final RxString sortType = "".obs;

  final TextEditingController departmentController = TextEditingController();

  ClockingListController({required ClockinoutService clockinoutService})
    : _clockinoutService = clockinoutService;

  @override
  void onInit() {
    fetchAttendances();
    super.onInit();
  }

  Future<void> fetchAttendances() async {
    try {
      isloading.value = true;
      err.value = "";
      final res = await _clockinoutService.getAllRecords();
      list.value = res;
      filteredList.value = res;
    } on UserServiceException catch (e) {
      err.value = e.message;
    } finally {
      isloading.value = false;
    }
  }

  void applyFilters() {
    List<ClockInOutModel> tempList = List.from(list);

    ///dev-cibi filter by department
    if (selectedDepartment.value.isNotEmpty) {
      tempList = tempList
          .where(
            (e) =>
                e.department?.toLowerCase() ==
                selectedDepartment.value.toLowerCase(),
          )
          .toList();
    }

    // dev-cibi date range filter
    if (selectedRange.value != null) {
      tempList = tempList.where((record) {
        if (record.date == null) return false;
        final recordDate = DateFormat("dd/MM/yyyy").tryParse(record.date!);
        if (recordDate == null) return false;
        return recordDate.isAfter(
              selectedRange.value!.start.subtract(const Duration(days: 1)),
            ) &&
            recordDate.isBefore(
              selectedRange.value!.end.add(const Duration(days: 1)),
            );
      }).toList();
    }

    // email sorting to filter by Email ID
    if (sortType.value == "email") {
      tempList.sort((a, b) => (a.email ?? '').compareTo(b.email ?? ''));
    }

    filteredList.value = tempList;
  }

  ///filter by Department
  void setDepartmentFilter() {
    selectedDepartment.value = departmentController.text.trim();
    applyFilters();
  }

  // email sorting to filter by Email ID
  void sortByEmail() {
    sortType.value = "email";
    applyFilters();
  }

  // email sorting to filter by Email
  Future<void> pickDateRange(BuildContext context) async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: selectedRange.value,
    );

    if (range != null) {
      selectedRange.value = range;
      applyFilters();
    }
  }

  ///clear all filters
  void clearFilters() {
    selectedDepartment.value = "";
    selectedRange.value = null;
    sortType.value = "";
    departmentController.clear();
    filteredList.value = list;
  }

  bool get hasActiveFilters =>
      selectedDepartment.value.isNotEmpty ||
      selectedRange.value != null ||
      sortType.value.isNotEmpty;
}
