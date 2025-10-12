import 'package:e_attendance/core/utils/extensions/validation_extension.dart';

class ValidationUtils {
  static String? emailValidation(String? email) => email
      .validateField("Email")
      .required()
      .minLength(6)
      .maxLength(50)
      .email()
      .error;

  static String? pwdValidation(String? pwd) =>
      pwd.validateField("Password").required().password().error;
  static String? deptValidation(String? value) =>
      value.validateField("Department").required().error;
}
