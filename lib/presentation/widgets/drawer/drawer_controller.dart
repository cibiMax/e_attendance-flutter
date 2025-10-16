import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_routes/route_constants.dart';
import '../../../core/theme/app_icons.dart' show AppIcons;
import '../../../data/widget_models/button_model.dart';
import '../alert_dialog.dart';
import '../textbutton.dart';
import 'drawer.dart';

class AppDrawerController extends GetxController {
  final FirebaseAuth _auth;
  late final List<MenuItem> menuItems;
  AppDrawerController({required FirebaseAuth auth}) : _auth = auth;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((time) async {
      var isAdmin = await _auth.currentUser?.email?.contains("admin") ?? false;
      menuItems = isAdmin
          ? [
              MenuItem(
                title: "Users",
                route: Routes.usersList,
                icon: AppIcons.userListTile,
              ),
              MenuItem(
                title: "Attendance",
                route: Routes.attendanceRecordList,
                icon: AppIcons.calendar,
              ),
              MenuItem(
                title: "ClockIn/Out",
                route: Routes.home,
                icon: AppIcons.clockIcon,
              ),

              MenuItem(
                title: "Business Hours",
                route: Routes.businessHours,
                icon: AppIcons.hours,
              ),
              MenuItem(
                route: Routes.login,
                title: "Log Out",
                icon: AppIcons.staticBaseLogout,
                onClick: logout,
              ),
            ]
          : [
              MenuItem(
                title: "ClockIn/Out",
                route: Routes.home,
                icon: AppIcons.clockIcon,
              ),
              MenuItem(
                title: "History",
                route: Routes.clockingHistory,
                icon: AppIcons.history,
              ),
              MenuItem(
                route: Routes.login,
                title: "Log Out",
                icon: AppIcons.staticBaseLogout,
                onClick: ()=> logout(),
              ),
            ];
    });

    super.onInit();
  }

  void logout() async {
    showAlert(
      isdismiss: true,
      title: "Logout?",
      description: "Are You Sure to Logout?",
      actions: [
        CustomTextButton(
          btnModel: ButtonModel(
            title: "Yes",
            onclick: () async {
              await _auth.signOut().then((value) {
                Get.offAllNamed(Routes.login);
              });
            },
          ),
        ),
        CustomTextButton(
          btnModel: ButtonModel(
            title: "No",
            onclick: () async {
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}
