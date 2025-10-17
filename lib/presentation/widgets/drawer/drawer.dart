import 'package:e_attendance/locator.dart';
import 'package:e_attendance/presentation/widgets/drawer/drawer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:e_attendance/core/theme/app_colors.dart';
import 'package:e_attendance/core/theme/app_dimensions.dart';
import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:get/get.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put<AppDrawerController>(AppDrawerController(auth: getIt<FirebaseAuth>()));
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
              Obx(
                () => controller.isloading.value
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.menuItems.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: controller.menuItems[index].icon,
                            title: Text(controller.menuItems[index].title),
                            onTap: () {
                              if (controller.menuItems[index].onClick != null)
                                controller.menuItems[index].onClick!();
                              else
                                Get.offNamed(controller.menuItems[index].route);
                            },
                          ),
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
  final Function()? onClick;

  MenuItem({
    required this.title,
    required this.route,
    required this.icon,
    this.onClick,
  });
}
