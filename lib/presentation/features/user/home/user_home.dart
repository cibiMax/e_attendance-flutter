import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/presentation/features/user/home/location/location.dart';
import 'package:e_attendance/presentation/features/user/home/timer/timer.dart';
import 'package:e_attendance/presentation/features/user/home/user_home_controller.dart'
    show UserHomeController;
import 'package:e_attendance/presentation/widgets/appbar.dart';
import 'package:e_attendance/presentation/widgets/drawer/drawer.dart';
import 'package:e_attendance/presentation/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/string_constants.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart' show AppTextStyles;
import '../../../../data/widget_models/button_model.dart';
import '../../../widgets/elevatedbutton.dart';

class UserHome extends GetView<UserHomeController> {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: CustomAppBar(title: StringConstants.clkinout),
        body: ResponsiveLayout(
          child: Expanded(
            child: Padding(
              padding: AppDimensions.contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              trailing: IconButton(
                                onPressed: controller.fetchTodayBHours,
                                icon: Icon(Icons.refresh_rounded),
                              ),
                              leading: AppIcons.timerIcon,
                              title: Text(
                                StringConstants.bHours,
                                style: AppTextStyles.subheading,
                              ),
                              subtitle: Obx(
                                () => Text(
                                  controller.businessHours.value,
                                  style: AppTextStyles.italicHint,
                                ),
                              ),
                            ),
                          ),
                          LocationTile(),

                          // const SizedBox(height: 10),

                          // LiveDateTime(),
                          // const SizedBox(height: 10),
                          Card(
                            child: ListTile(
                              leading: AppIcons.locationIcon,
                              title: Text(
                                StringConstants.inLocation,
                                style: AppTextStyles.subheading,
                              ),
                              subtitle: Obx(
                                () => Text(
                                  controller.inLocation.value,
                                  style: AppTextStyles.italicHint,
                                ),
                              ),
                            ),
                          ),

                          Card(
                            child: ListTile(
                              leading: AppIcons.locationIcon,
                              title: Text(
                                StringConstants.outLocation,
                                style: AppTextStyles.subheading,
                              ),
                              subtitle: Obx(
                                () => Text(
                                  controller.outLocation.value,
                                  style: AppTextStyles.italicHint,
                                ),
                              ),
                            ),
                          ),

                          ClockInDuration(),

                          Card(
                            child: ListTile(
                              leading: AppIcons.clockIcon,
                              title: Text(
                                StringConstants.clkIn,
                                style: AppTextStyles.subheading,
                              ),
                              subtitle: Obx(
                                () => Text(
                                  controller.clkInTime.value,
                                  style: AppTextStyles.italicHint,
                                ),
                              ),
                            ),
                          ),

                          Card(
                            child: ListTile(
                              leading: AppIcons.clockIcon,
                              title: Text(
                                StringConstants.clkOut,
                                style: AppTextStyles.subheading,
                              ),
                              subtitle: Obx(
                                () => Text(
                                  controller.clkOutTime.value,
                                  style: AppTextStyles.italicHint,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Buttons now part of scroll view
                  CustomElevatedButton(
                    buttonModel: ButtonModel(
                      title: StringConstants.clkIn,
                      onclick: controller.onclockIn,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    buttonModel: ButtonModel(
                      title: StringConstants.clkOut,
                      onclick: controller.onClockOut,
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
