import 'package:e_attendance/core/constants/image_constants.dart';
import 'package:e_attendance/core/constants/string_constants.dart';
import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:e_attendance/data/widget_models/textformfield_model.dart';
import 'package:e_attendance/presentation/features/auth/login/login_controller.dart';
import 'package:e_attendance/presentation/widgets/asset_image.dart';
import 'package:e_attendance/presentation/widgets/elevatedbutton.dart';
import 'package:e_attendance/presentation/widgets/passwordformfield.dart';
import 'package:e_attendance/presentation/widgets/responsive_layout.dart';
import 'package:e_attendance/presentation/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_validations/validation_utils.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ResponsiveLayout(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx(
              () => Form(
                autovalidateMode: controller.autovalidateMode.value,
                key: controller.formKey,
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.appTitle,
                      style: AppTextStyles.heading,
                    ),
                    CustomAssetImage(path: ImageConstants.loginCover),
                    CustomTextFormField(
                      textformfieldModel: TextFormFieldModel(
                        controller: controller.emailController,
                        prefixIcon: AppIcons.email,
                        label: StringConstants.email,
                        hint: StringConstants.enterEmail,
                        onvalidate: (email) =>
                            ValidationUtils.emailValidation(email),
                      ),
                    ),
                    PasswordFormField(
                      textFormFieldModel: TextFormFieldModel(
                        controller: controller.pwdController,
                        prefixIcon: AppIcons.password,
                        label: StringConstants.password,
                        hint: StringConstants.enterPwd,
                        onvalidate: (pwd) => ValidationUtils.pwdValidation(pwd),
                      ),
                    ),

                    CustomElevatedButton(
                      buttonModel: ButtonModel(
                        title: StringConstants.login,
                        onclick: controller.onLogin,
                      ),
                    ),
                    // CustomElevatedButton(
                    //   buttonModel: ButtonModel(
                    //     title: StringConstants.signup,
                    //     onclick: controller.onSignUp,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
