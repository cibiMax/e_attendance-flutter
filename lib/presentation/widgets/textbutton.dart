import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final ButtonModel btnModel;
  const CustomTextButton({super.key, required this.btnModel});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: btnModel.onclick,
      child: Text(btnModel.title, style: AppTextStyles.label),
    );
  }
}
