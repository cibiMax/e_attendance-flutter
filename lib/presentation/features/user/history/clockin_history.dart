import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/core/utils/extensions/clock_status.dart';
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:e_attendance/presentation/features/user/history/clockin_history_controller.dart'
    show ClockinHistoryController;
import 'package:e_attendance/presentation/widgets/appbar.dart';
import 'package:e_attendance/presentation/widgets/drawer/drawer.dart';
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
      appBar: CustomAppBar(title: "Clocking History"),drawer: AppDrawer(),
      body: ResponsiveLayout(
        child: Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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

                      final status = record.status != null
                          ? ClockStatusExt.fromString(record.status!)
                          : ClockStatus.normal;

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border(
                            left: BorderSide(color: status.color, width: 5),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🗓 Date & Duration
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

                            // 🕓 Clock In
                            Row(
                              children: [
                                AppIcons.clockIn,
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                            // 🕕 Clock Out
                            Row(
                              children: [
                                AppIcons.clockOut,
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Clock Out: ${record.clockOutTime ?? "--"}",
                                      ),
                                      if (record.clockOutLocation != null &&
                                          record.clockOutLocation!.isNotEmpty)
                                        Text(
                                          record.clockOutLocation!,
                                          style: AppTextStyles.italicHint,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            //   Status Badge
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: status.color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                child: Text(
                                  status.label,
                                  style: AppTextStyles.subheading.copyWith(
                                    color: status.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
