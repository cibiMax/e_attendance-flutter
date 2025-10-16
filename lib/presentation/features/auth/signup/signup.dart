import 'package:e_attendance/core/app_validations/validation_utils.dart';
import 'package:e_attendance/core/theme/app_dimensions.dart';
import 'package:e_attendance/presentation/features/auth/signup/signup_controller.dart';
import 'package:e_attendance/presentation/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/image_constants.dart';
import '../../../../core/constants/string_constants.dart' show StringConstants;
import '../../../../core/theme/app_icons.dart' show AppIcons;
import '../../../../core/theme/app_text_styles.dart' show AppTextStyles;
import '../../../../data/widget_models/button_model.dart' show ButtonModel;
import '../../../../data/widget_models/textformfield_model.dart';
import '../../../widgets/asset_image.dart' show CustomAssetImage;
import '../../../widgets/elevatedbutton.dart' show CustomElevatedButton;
import '../../../widgets/passwordformfield.dart' show PasswordFormField;
import '../../../widgets/responsive_layout.dart';
import '../../../widgets/textformfield.dart';

class SignUp extends GetView<SignupController> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ResponsiveLayout(
          child: SingleChildScrollView(
            padding: AppDimensions.contentPadding,
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
                    CustomDropdown(
                      items: ["SDE", "Development", "Accounts"],
                      textFormFieldModel: TextFormFieldModel(
                        controller: controller.departmentController,
                        prefixIcon: AppIcons.departmentIcon,
                        label: StringConstants.dept,
                        hint: StringConstants.enterDept,
                        onvalidate: (value) =>
                            ValidationUtils.deptValidation(value),
                      ),
                    ),
                    CustomDropdown(
                      items: ["User", "Admin"],
                      textFormFieldModel: TextFormFieldModel(
                        controller: controller.roleController,
                        prefixIcon: AppIcons.departmentIcon,
                        label: StringConstants.role,
                        hint: StringConstants.enterRole,
                        onvalidate: (value) =>
                            ValidationUtils.deptValidation(value),
                      ),
                    ),
                    CustomElevatedButton(
                      buttonModel: ButtonModel(
                        title: StringConstants.signup,
                        onclick: controller.onSignUp,
                      ),
                    ),
                    CustomElevatedButton(
                      buttonModel: ButtonModel(
                        title: StringConstants.signIn,
                        onclick: controller.toSignIn,
                      ),
                    ),
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
