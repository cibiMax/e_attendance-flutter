import 'package:e_attendance/core/constants/string_constants.dart';
import 'package:e_attendance/core/theme/app_colors.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAlert({
  String? title = "",
  String? description = "",
  List<Widget>? actions,
  bool? isdismiss = true,
}) async {
  await Get.dialog(
    barrierDismissible: isdismiss!,

    PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(
          title!,
          style: AppTextStyles.heading.copyWith(color: AppColors.contentColor),
        ),
        content: Text(
          description??"",
          style: AppTextStyles.content,
        ),
        actions: actions,
      ),
    ),
  );
}


