import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:e_attendance/core/theme/app_colors.dart';
import 'package:e_attendance/core/theme/app_dimensions.dart';
import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:get/get.dart';

import '../../core/app_routes/route_constants.dart';

class AppDrawer extends StatelessWidget {
  
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
     final List<MenuItem> menuItems = [
    MenuItem(
      title: "Users",
      route: Routes.usersList,
      icon: AppIcons.userAccount,
    ),
    MenuItem(
      title: "Attendance",
      route: Routes.attendanceRecordList,
      icon: AppIcons.attendanceRecord,
    ),
     MenuItem(
      title: "ClockIn/Out",
      route: Routes.home,
      icon: AppIcons.clockIcon,
    ),
  ];

    return Drawer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: AppColors.primaryColor,
                child: Padding(
                  padding: AppDimensions.contentPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.accentColor,
                        child: AppIcons.userAccount,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser?.email ?? "",
                        style: AppTextStyles.heading.copyWith(
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: menuItems[index].icon,
                    title: Text(menuItems[index].title),
                    onTap: () => Get.offNamed(menuItems[index].route),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String route;
  final Widget icon;

  MenuItem({required this.title, required this.route, required this.icon});
}
