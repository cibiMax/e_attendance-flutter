import 'package:e_attendance/core/constants/string_constants.dart';
import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/presentation/features/user/home/location/location_controller.dart'
    show LocationController;
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LocationTile extends GetView<LocationController> {
  const LocationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: AppIcons.locationIcon,
        trailing:IconButton(onPressed: controller.fetchLocation, icon: AppIcons.refresh),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              style: AppTextStyles.subheading,
              StringConstants.location,
            ),
          ],
        ),
        subtitle: Obx(
          () => controller.isloading.value
              ? Center(child: CircularProgressIndicator())
              : Text(
                  controller.location.value,
                  style: AppTextStyles.italicHint,
                ),
        ),
      ),
    );
  }
}
