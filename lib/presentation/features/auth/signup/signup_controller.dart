import 'package:e_attendance/core/utils/extensions/loader_extension.dart';
import 'package:e_attendance/core/utils/extensions/toast_extension.dart';
import 'package:e_attendance/data/models/app_user_model.dart';
import 'package:e_attendance/domain/services/auth/auth_service_exception.dart';
import 'package:e_attendance/domain/services/user/user_service.dart';
import 'package:e_attendance/domain/services/user/user_service_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/services/auth/auth_service.dart';

class SignupController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  final AuthService _authService;
  final UserService _userService;
  Rx<AutovalidateMode> autovalidateMode = AutovalidateMode.disabled.obs;
  final GlobalKey<FormState> formKey = GlobalKey();

  SignupController({
    required AuthService authService,
    required UserService userService,
  }) : _authService = authService,
       _userService = userService;

  void onSignUp() async {
    try {
      if (formKey.currentState?.validate() ?? false == true) {
        Get.showLoadingDialog();
        var usercred = await _authService.signUpWithEmail(
          emailController.text,
          pwdController.text,
        );
        if (usercred?.user != null) {
          await _userService
              .createUser(
                AppUserModel(
                  role: roleController.text,
                  email: emailController.text,
                  departmentKey: departmentController.text,
                  userKey: usercred?.user?.uid,
                ),
              )
              .then((value) {
                Get.hideLoading();
                Get.showToast("User created Successfully.Login to continue");
              });
        } else {
          autovalidateMode.value = AutovalidateMode.always;
        }
      }

      ///Edge Case need to be handled on user creation in server side
    } on AuthServiceException catch (e) {
      Get.hideLoading();
      Get.showToast(e.message);
    } on UserServiceException catch (e) {
      await _authService.currentUser()?.delete();
      Get.hideLoading();
      Get.showToast(e.message);
    }
  }

  void toSignIn() {
    Get.back();
  }
}
