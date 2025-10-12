import 'package:e_attendance/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

///Global Centralized Declaration of Text Styles used in the App
class AppTextStyles {
  static const String _fontfamily = "Roboto";
  static const TextStyle _boldTextBase = TextStyle(
    fontFamily: _fontfamily,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle _normalTextBase = _boldTextBase.copyWith(
    fontWeight: FontWeight.normal,
  );
  static final TextStyle heading = _normalTextBase.copyWith(fontSize: 20);
  static final TextStyle subheading = _boldTextBase.copyWith(fontSize: 16);
  static final TextStyle content = _normalTextBase.copyWith(fontSize: 12.0);
  static final TextStyle hint = _normalTextBase.copyWith(
    fontSize: 14,
    color: AppColors.hintTextColor,
  );
  static final TextStyle label = _normalTextBase.copyWith(
    color: AppColors.labelTextColor,
    fontSize: 12,
  );
  static final TextStyle italicHint = AppTextStyles.hint.copyWith(
    fontStyle: FontStyle.italic,
  );

  static final TextStyle durationStyle = subheading;
}
