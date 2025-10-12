import 'package:e_attendance/core/utils/app_utils/permission_util.dart';
import 'package:e_attendance/core/utils/extensions/toast_extension.dart';
import 'package:e_attendance/domain/services/auth/auth_service.dart';
import 'package:e_attendance/domain/services/auth/auth_service_exception.dart';
import 'package:e_attendance/presentation/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../../../core/app_routes/route_constants.dart';
import '../../../../core/constants/string_constants.dart' show StringConstants;
import '../../../../core/utils/extensions/loader_extension.dart';

class LoginController extends GetxController with WidgetsBindingObserver {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final PermissionUtil _permissionUtil;
  final AuthService _authService;
  Rx<AutovalidateMode> autovalidateMode = AutovalidateMode.disabled.obs;

  LoginController({
    required PermissionUtil permissionUtil,
    required AuthService authService,
  }) : _permissionUtil = permissionUtil,
       _authService = authService;

  @override
  void onInit() {
    getPermission();
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getPermission();
    }
  }

  void getPermission() async {
    PermissionStatus status = await _permissionUtil.checkStatus(
      Permission.location,
    );
    if (status.isPermanentlyDenied) {
      showAlert(
        title: StringConstants.permissionRequired,
        description: StringConstants.permissionDescription,
        actions: [
          TextButton(
            child: Text(StringConstants.opnSettings),
            onPressed: () async {
              Get.back(closeOverlays: true);
              await _permissionUtil.openSettingsDialog();
            },
          ),
        ],
      );
    }
    if (status.isDenied) {
      var res = await _permissionUtil.requestStatus(Permission.location);
      if (res == PermissionStatus.permanentlyDenied) {
        getPermission();
      }
    }
  }

  void onLogin() async {
    autovalidateMode.value = AutovalidateMode.always;
    if (formKey.currentState?.validate() ?? false == true) {
      try {
        Get.showLoadingDialog();
        await _authService.signInWithEmail(
          emailController.text,
          pwdController.text,
        );
        Get.hideLoading();
        if (_authService.currentUser()!.email!.toLowerCase().contains(
          "admin",
        )) {
          Get.offNamed(Routes.usersList);
        } else {
          Get.offNamed(Routes.home);
        }
        ;
      } on AuthServiceException catch (e) {
        Get.showToast(e.message, type: ToastType.error);
        Get.hideLoading();
      }
    } else {
      autovalidateMode.value = AutovalidateMode.always;
    }
  }

  void onSignUp() {
    Get.toNamed(Routes.signup);
  }
}
