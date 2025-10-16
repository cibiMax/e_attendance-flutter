// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:e_attendance/presentation/widgets/appbar.dart';
import 'package:e_attendance/presentation/widgets/drawer/drawer.dart';
import 'package:e_attendance/presentation/widgets/elevatedbutton.dart';
import 'package:e_attendance/presentation/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_attendance/core/theme/app_text_styles.dart';

import 'business_hour_settings_controller.dart';

class BusinessHoursSettings extends GetView<BusinessHoursSetingsController> {
  const BusinessHoursSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: AppDrawer(),
      appBar: CustomAppBar(title: "Business Hours"),
      body: ResponsiveLayout(
        child: Expanded(flex: 1,
          child: Obx(
            () => controller.businessHours.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: controller.formKey,
                    autovalidateMode: controller.validateMode.value,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.workingDays.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Obx(
                                  () => CheckboxListTile(
                                    selected: controller
                                        .businessHours[index]
                                        .isSelected
                                        .value,
                                    title: Text(
                                      controller.workingDays[index],
                                      style: AppTextStyles.subheading,
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () =>
                                                controller.onFromTap(index),
                                            onTapAlwaysCalled: true,
                                            validator: controller
                                                .businessHours[index]
                                                .onvalidate,
                                            controller: controller
                                                .txtcontrollers["${controller.workingDays[index]}_from"],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () => controller.onToTap(index),
                                            onTapAlwaysCalled: true,
                                            validator: controller
                                                .businessHours[index]
                                                .onvalidate,
                                            controller: controller
                                                .txtcontrollers["${controller.workingDays[index]}_to"],
                                          ),
                                        ),
                                      ],
                                    ),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: controller
                                        .businessHours[index]
                                        .isSelected
                                        .value,
                                    onChanged: (val) =>
                                        controller.onselectionChange(val, index),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        CustomElevatedButton(
                          buttonModel: ButtonModel(
                            title: "Save Changes",
                            onclick: controller.onSave,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class BusinessHourSetingsItem {
  final String? Function(String?) onvalidate;
  RxBool isSelected;
  final String day;
  final Map<String, TextEditingController> controllers;

  BusinessHourSetingsItem({
    required this.controllers,
    required this.day,
    required this.onvalidate,
    required this.isSelected,
  });
}
