import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:e_attendance/presentation/features/user/history/clockin_history_controller.dart'
    show ClockinHistoryController;
import 'package:e_attendance/presentation/widgets/appbar.dart';
import 'package:e_attendance/presentation/widgets/responsive_layout.dart';
import 'package:e_attendance/presentation/widgets/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_icons.dart';

class UserClockingHistory extends GetView<ClockinHistoryController> {
  const UserClockingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Clocking History"),
      body: ResponsiveLayout(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isloading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
        
                if (controller.err.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Failed to load history! Try again"),
                        const SizedBox(height: 10),
                        CustomTextButton(
                          btnModel: ButtonModel(
                            title: "Retry",
                            onclick: () => controller.fetchClockingHistory(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
        
                if (controller.list.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Clock-In History Found",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
        
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    final record = controller.list[index];
        
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //  Date and Duration
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AppIcons.calendar,
                                    const SizedBox(width: 5),
                                    Text(
                                      record.date ?? "--",
                                      style: AppTextStyles.subheading,
                                    ),
                                  ],
                                ),
                                if (record.duration != null)
                                  Row(
                                    children: [
                                      AppIcons.elapsedTimeIcon,
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        // decoration: AppDecorations.boxDecoration,
                                        child: Text(
                                          record.duration!,
                                          style: AppTextStyles.durationStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
        
                            // Clock In
                            Row(
                              children: [
                                AppIcons.clockIn,
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Clock In: ${record.clockInTime ?? "--"}",
                                      ),
                                      if (record.clockInLocation != null &&
                                          record.clockInLocation!.isNotEmpty)
                                        Text(
                                          record.clockInLocation!,
                                          style: AppTextStyles.italicHint,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
        
                            // Clock Out
                            Row(
                              children: [
                                AppIcons.clockOut,
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Clock Out: ${record.clockOutTime ?? "--"}",
                                      ),
                                      if (record.clockOutLocation != null &&
                                          record.clockOutLocation!.isNotEmpty)
                                        Text(
                                          record.clockOutLocation!,
                                          style:AppTextStyles.italicHint
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
