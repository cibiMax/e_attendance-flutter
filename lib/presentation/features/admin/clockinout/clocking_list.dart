import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/presentation/widgets/appbar.dart';
import 'package:e_attendance/presentation/widgets/drawer.dart';
import 'package:e_attendance/presentation/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../data/widget_models/textformfield_model.dart';
import 'clocking_controller.dart';

class ClockingList extends GetView<ClockingListController> {
  const ClockingList({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: "Attendance"),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomDropdown(
              onchange: (v) => controller.filterByDepartment(),
              items: ["SDE", "Development", "Accounts"],
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
                          // Email
                          if (item.email != null)
                            Text(
                              item.email!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          

                          const SizedBox(height: 6),

                          // Department
                          if (item.departmnet != null)
                            Text("Department: ${item.departmnet}"),

                          const SizedBox(height: 4),

                          // Date
                          if (item.date != null) Text("Date: ${item.date}"),

                          const SizedBox(height: 4),

                          // Clock In / Out
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

                          if (item.clockInLocation != null &&
                              item.clockInLocation!.isNotEmpty)
                            Text("In Location: ${item.clockInLocation}"),
                          if (item.clockOutLocation != null &&
                              item.clockOutLocation!.isNotEmpty)
                            Text("Out Location: ${item.clockOutLocation}"),

                          const SizedBox(height: 4),

                          // Duration
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

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: const Border(top: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.sort),
                label: const Text(StringConstants.sortByEmail),
                onPressed: () => controller.sortByEmail(),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: const Text("Date Range"),
                onPressed: () => controller.pickDateRange(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
