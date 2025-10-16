// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_attendance/core/utils/extensions/loader_extension.dart';
import 'package:e_attendance/core/utils/extensions/toast_extension.dart';
import 'package:flutter/material.dart';

import 'package:e_attendance/core/app_exceptions/app_exception.dart';
import 'package:e_attendance/core/utils/extensions/validation_extension.dart';
import 'package:e_attendance/domain/services/businesshour/business_hour_service.dart';

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
          txtcontrollers["${item.day}_from"]?.text = item.fromTime;
          txtcontrollers["${item.day}_to"]?.text =
              "${item.toHrs.toString().padLeft(2, '0')}:${item.toMin.toString().padLeft(2, '0')}";

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

      if (res != null && res) {
        List<BusinessHourModel> businessHoursModelList = [];

        for (int i = 0; i < businessHours.length; i++) {
          var item = businessHours[i];

          if (item.isSelected.value) {
            final fromText = txtcontrollers["${item.day}_from"]!.text;
            final toText = txtcontrollers["${item.day}_to"]!.text;

            final fromTimeParts = fromText.split(":");
            final toTimeParts = toText.split(":");

            int fromHrs = int.tryParse(fromTimeParts[0]) ?? 0;
            int fromMin = int.tryParse(fromTimeParts[1]) ?? 0;
            int toHrs = int.tryParse(toTimeParts[0]) ?? 0;
            int toMin = int.tryParse(toTimeParts[1]) ?? 0;

            businessHoursModelList.add(
              BusinessHourModel(
                fromTime: fromText,
                fromHrs: fromHrs,
                fromMin: fromMin,
                toHrs: toHrs,
                toMin: toMin,
                day: item.day,
              ),
            );
          }
        }
        await businessHourService.saveBusinessHours(businessHoursModelList);
      } else {
        validateMode.value = AutovalidateMode.always;
      }
      Get.hideLoading();
    } on AppException catch (e) {
      Get.hideLoading();
      Get.showToast(e.msg);
    }
  }

  void onFromTap(int index) async {
    TimeOfDay? res = await Get.dialog(
      TimePickerDialog(initialTime: TimeOfDay.fromDateTime(DateTime.now())),
    );
    if (res != null) {
      txtcontrollers["${workingDays[index]}_from"]!.text = res.format(
        Get.context!,
      );
      businessHours[index].isSelected.value = true;
    }
  }

  void onToTap(int index) async {
    var res = await Get.dialog(
      TimePickerDialog(initialTime: TimeOfDay.fromDateTime(DateTime.now())),
    );
    if (res != null) {
      txtcontrollers["${workingDays[index]}_to"]!.text = res.format(
        Get.context!,
      );
      businessHours[index].isSelected.value = true;
    }
  }
}
