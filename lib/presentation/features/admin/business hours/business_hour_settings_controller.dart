// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_attendance/core/utils/extensions/loader_extension.dart';
import 'package:e_attendance/core/utils/extensions/toast_extension.dart';
import 'package:e_attendance/presentation/widgets/time_picker.dart';
import 'package:flutter/material.dart';

import 'package:e_attendance/core/app_exceptions/app_exception.dart';
import 'package:e_attendance/core/utils/extensions/validation_extension.dart';
import 'package:e_attendance/domain/services/businesshour/business_hour_service.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/business_hour_model.dart'
    show BusinessHourModel;
import 'businesshours.dart';
import 'package:get/get.dart';

class BusinessHoursSetingsController extends GetxController {
  final BusinessHourService businessHourService;
  RxList<BusinessHourSetingsItem> businessHours =
      <BusinessHourSetingsItem>[].obs;
  final List<String> workingDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  Map<String, TextEditingController> txtcontrollers = {};
  final formKey = GlobalKey<FormState>();
  Rx<AutovalidateMode> validateMode = AutovalidateMode.disabled.obs;
  BusinessHoursSetingsController({required this.businessHourService});

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((time) {
      getValues();
      refillForm();
    });
  }

  void refillForm() async {
    Get.showLoadingDialog();
    try {
      var res = await businessHourService.getBusinessHourSettings();

      if (res.isNotEmpty) {
        for (var item in res) {
          txtcontrollers["${item.day}_from"]?.text = item.from;
          txtcontrollers["${item.day}_to"]?.text = item.to;

          final index = workingDays.indexOf(item.day);
          if (index != -1) {
            businessHours[index].isSelected.value = true;
          }
        }
      }

      Get.hideLoading();
    } on AppException catch (e) {
      Get.hideLoading();
      Get.showToast(e.msg);
    }
  }

  getValues() {
    for (var day in workingDays) {
      txtcontrollers["${day}_from"] = TextEditingController();
      txtcontrollers["${day}_to"] = TextEditingController();
    }
    businessHours.value = workingDays
        .map<BusinessHourSetingsItem>(
          (e) => BusinessHourSetingsItem(
            controllers: txtcontrollers,
            isSelected: false.obs,
            day: e,
            onvalidate: (value) {
              if (businessHours[workingDays.indexOf(e)].isSelected.value) {
                return value.validateField("Field").required().error;
              } else {
                return null;
              }
            },
          ),
        )
        .toList();
  }

  void onselectionChange(bool? value, int index) {
    businessHours[index].isSelected.value = value ?? false;
  }

  void onSave() async {
    try {
      Get.showLoadingDialog();
      var res = formKey.currentState?.validate();

      // Ensure at least one day is selected
      var isSelectedNotEmpty = businessHours.any(
        (e) => e.isSelected.value == true,
      );

      if (res != null && res) {
        if (!isSelectedNotEmpty) {
          Get.showToast("Add Business Hours for at least one day to continue");
          return;
        }

        List<BusinessHourModel> businessHoursModelList = [];

        for (var item in businessHours) {
          if (item.isSelected.value) {
            final fromText =
                txtcontrollers["${item.day}_from"]!.text; // e.g., "09:30 AM"
            final toText =
                txtcontrollers["${item.day}_to"]!.text; // e.g., "05:30 PM"

            var businessHourModel = BusinessHourModel(
              day: item.day,
              from: fromText,
              to: toText,
            );

            businessHoursModelList.add(businessHourModel);
          }
        }

        await businessHourService.saveBusinessHours(businessHoursModelList);
      } else {
        validateMode.value = AutovalidateMode.always;
      }

      Get.hideLoading();Get.showToast("Business Hours Saved Successfully");

    } on AppException catch (e) {
      Get.hideLoading();
      Get.showToast(e.msg);
    }
  }

  void onFromTap(int index) async {
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);
    final text = txtcontrollers["${workingDays[index]}_from"]!.text;
    if (text.isNotEmpty) {
      final parsed = DateFormat("hh:mm a").parse(text);
      initialTime = TimeOfDay(hour: parsed.hour, minute: parsed.minute);
    }

    TimeOfDay? res = await Get.dialog(TimePicker(initialTime: initialTime));

    if (res != null) {
      DateTime now = DateTime.now();
      DateTime time = DateTime(
        now.year,
        now.month,
        now.day,
        res.hour,
        res.minute,
      );
      final formattedTime = DateFormat("hh:mm a").format(time);
      txtcontrollers["${workingDays[index]}_from"]!.text = formattedTime;
      businessHours[index].isSelected.value = true;
    }
  }

  void onToTap(int index) async {
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);
    final text = txtcontrollers["${workingDays[index]}_to"]!.text;
    if (text.isNotEmpty) {
      final parsed = DateFormat("hh:mm a").parse(text);
      initialTime = TimeOfDay(hour: parsed.hour, minute: parsed.minute);
    }

    TimeOfDay? res = await Get.dialog(TimePicker(initialTime: initialTime));

    if (res != null) {
      DateTime now = DateTime.now();
      DateTime time = DateTime(
        now.year,
        now.month,
        now.day,
        res.hour,
        res.minute,
      );
      final formattedTime = DateFormat("hh:mm a").format(time);
      txtcontrollers["${workingDays[index]}_to"]!.text = formattedTime;
      businessHours[index].isSelected.value = true;
    }
  }
}
