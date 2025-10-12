import 'package:e_attendance/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

///Global declaration of decoration constants like border of container or card,textboxes etc.,
class AppDecorations {
  static const InputBorder textfieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
  static final ButtonStyle elevatedBtnStyle = ElevatedButton.styleFrom(
    fixedSize: Size(double.infinity, 50.0),
    backgroundColor: AppColors.elevatedBtnBgColor,
    foregroundColor: AppColors.elevatedBtnTxtColor,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );

  static BoxDecoration boxDecoration = BoxDecoration(
    color: AppColors.primaryColorLight,
    borderRadius: BorderRadius.circular(6),
  );
}
