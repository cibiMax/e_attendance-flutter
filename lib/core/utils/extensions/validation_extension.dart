import 'package:e_attendance/core/app_validations/reg_exp.dart';


class FieldValidator {
  final String? value;
  final String fieldName;
  String? _error;

  FieldValidator(this.value, this.fieldName);

  FieldValidator required() {
    if (_error != null) return this; 
    if (value == null || value!.trim().isEmpty) {
      _error = '$fieldName is required';
    }
    return this;
  }

  FieldValidator minLength(int min) {
    if (_error != null) return this; 
    if ((value?.length ?? 0) < min) {
      _error = '$fieldName must be at least $min characters';
    }
    return this;
  }

  FieldValidator maxLength(int max) {
    if (_error != null) return this; 
    if ((value?.length ?? 0) > max) {
      _error = '$fieldName must be at most $max characters';
    }
    return this;
  }
FieldValidator email(){
   if (_error != null) return this; 
    
    if (!AppRegExp.email.hasMatch(value!.trim())) {
      _error = 'Enter a valid $fieldName';
    }
    return this;
}
  FieldValidator password() {
    if (_error != null) return this; 
  
    if (!AppRegExp.pwd.hasMatch(value!.trim())) {
      _error = 'Enter a valid $fieldName';
    }
    return this;
  }

  String? get error => _error;
}

extension FieldValidationExtension on String? {
  FieldValidator validateField(String fieldName) => FieldValidator(this, fieldName);
}
