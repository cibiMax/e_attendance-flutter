import 'package:e_attendance/core/app_routes/route_constants.dart';
import 'package:e_attendance/data/models/app_user_model.dart';
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:e_attendance/domain/services/user/user_service.dart';
import 'package:e_attendance/domain/services/user/user_service_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../widgets/alert_dialog.dart' show showAlert;
import '../../../widgets/textbutton.dart';

class UserListController extends GetxController {
  final UserService _userService;
  final RxBool isloading = false.obs;
  final RxList<AppUserModel> list = <AppUserModel>[].obs;
  final RxString err = "".obs;

  UserListController({required UserService userService})
    : _userService = userService;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isloading.value = true;
      var res = await _userService.getUsers();
      list.value = res;
      isloading.value = false;
    } on UserServiceException catch (e) {
      err.value = e.message;
    }
  }

  void toClockingHistory(String userKey) {
    Get.toNamed(Routes.clockingHistory, arguments: {"userKey": userKey});
  }

  logout() async {
    showAlert(
      isdismiss: true,
      title: "Logout?",
      description: "Are You Sure to Logout?",
      actions: [
        CustomTextButton(
          btnModel: ButtonModel(
            title: "Yes",
            onclick: () async {
              await FirebaseAuth.instance.signOut().then((value) {
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
