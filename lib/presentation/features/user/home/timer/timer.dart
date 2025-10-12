import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/presentation/features/user/home/timer/timer_controller.dart'
    show TimerController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ClockInDuration extends GetView<TimerController> {
  const ClockInDuration({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(leading: AppIcons.elapsedTimeIcon,
        title: Text(StringConstants.duration, style: AppTextStyles.subheading),
        subtitle: Obx(() => Text(controller.duration.value)),
      ),
    );
  }
}
