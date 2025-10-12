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
        // trailing:
        title: Row(mainAxisSize: MainAxisSize.min,
          children: [ 
            Text(StringConstants.location, style: AppTextStyles.subheading),
            TextButton(
          onPressed: () => controller.fetchLocation(),
          child: Text("Refresh"),
        ),
          ],
        ),
        subtitle: Obx(
          () => controller.isloading.value
              ? Text("", style: AppTextStyles.italicHint)
              : Text(controller.location.value,style: AppTextStyles.italicHint),
        ),
      ),
    );
  }
}
