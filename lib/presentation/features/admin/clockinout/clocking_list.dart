import 'package:e_attendance/core/constants/string_constants.dart';
import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:e_attendance/data/widget_models/textformfield_model.dart';
import 'package:e_attendance/presentation/widgets/appbar.dart';
import 'package:e_attendance/presentation/widgets/drawer/drawer.dart';
import 'package:e_attendance/presentation/widgets/dropdown.dart';
import 'package:e_attendance/presentation/widgets/elevatedbutton.dart';
import 'package:e_attendance/presentation/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'clocking_controller.dart';

class ClockingList extends GetView<ClockingListController> {
  const ClockingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: "Attendance"),

      body: ResponsiveLayout(
        child: Expanded(flex:1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomDropdown(
                  onchange: (v) => controller.setDepartmentFilter(),
                  items: const ["SDE", "Development", "Accounts"],
                  textFormFieldModel: TextFormFieldModel(
                    controller: controller.departmentController,
                    prefixIcon: AppIcons.departmentIcon,
                    label: StringConstants.dept,
                    hint: StringConstants.enterDept,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isloading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.err.isNotEmpty) {
                    return Center(child: Text(controller.err.value));
                  }
                  if (controller.filteredList.isEmpty) {
                    return const Center(child: Text("No attendance records"));
                  }
          
                  return ListView.builder(
                    itemCount: controller.filteredList.length,
                    itemBuilder: (context, index) {
                      final item = controller.filteredList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.email != null)
                                Text(
                                  item.email!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              const SizedBox(height: 6),
                              if (item.department != null)
                                Text("Department: ${item.department}"),
                              const SizedBox(height: 4),
                              if (item.date != null) Text("Date: ${item.date}"),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  if (item.clockInTime != null)
                                    Text("In: ${item.clockInTime}"),
                                  const SizedBox(width: 12),
                                  if (item.clockOutTime != null)
                                    Text("Out: ${item.clockOutTime}"),
                                ],
                              ),
                              const SizedBox(height: 4),
                              if (item.clockInLocation?.isNotEmpty ?? false)
                                Text("In Location: ${item.clockInLocation}"),
                              if (item.clockOutLocation?.isNotEmpty ?? false)
                                Text("Out Location: ${item.clockOutLocation}"),
                              const SizedBox(height: 4),
                              if (item.duration != null)
                                Text("Duration: ${item.duration}"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Obx(
          () => Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      buttonModel: ButtonModel(
                        title: "Sort By Email",
                        onclick: controller.sortByEmail,
                      ),
                    ),
                    CustomElevatedButton(
                      buttonModel: ButtonModel(
                        title: "Sort by Date",
                        onclick:()=> controller.pickDateRange(context),
                      ),
                    ),
                  ],
                ),
                if (controller.hasActiveFilters)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: CustomElevatedButton(
                      buttonModel: ButtonModel(
                        title: "Clear Filters",
                        onclick: controller.clearFilters,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
