import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/app_routes/route_constants.dart';
import '../../../core/theme/app_icons.dart' show AppIcons;
import '../../../data/widget_models/button_model.dart';
import '../alert_dialog.dart';
import '../textbutton.dart';
import 'drawer.dart';

class AppDrawerController extends GetxController {
  final FirebaseAuth _auth;
  RxList<MenuItem> menuItems = <MenuItem>[].obs;
  RxBool isloading = false.obs;
  AppDrawerController({required FirebaseAuth auth}) : _auth = auth;

  @override
  void onInit() {
   
       getMenuItems();
   

    super.onInit();
  }

  
  @override
  void dispose() {
   
      Get.find<AppDrawerController>().dispose();

    super.dispose();
  }

  Future<void> getMenuItems() async {
    isloading.value = true;
    var isAdmin = await _auth.currentUser?.email?.contains("admin") ?? false;
    menuItems.value = isAdmin
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
              onClick: () => logout(),
            ),
          ];
    isloading.value = false;
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
