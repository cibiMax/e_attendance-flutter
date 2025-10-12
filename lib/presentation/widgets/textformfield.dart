import 'package:e_attendance/core/theme/app_decorations.dart';
import 'package:e_attendance/core/theme/app_dimensions.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/data/widget_models/textformfield_model.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextFormFieldModel textformfieldModel;

  const CustomTextFormField({super.key, required this.textformfieldModel});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(textformfieldModel.label),
      controller: textformfieldModel.controller,
      validator: textformfieldModel.onvalidate,
      onChanged: textformfieldModel.onchange,
      inputFormatters: textformfieldModel.formatters,
      textInputAction: textformfieldModel.textInputAction,
      keyboardType: textformfieldModel.textInputType,
      decoration: InputDecoration(
        border: AppDecorations.textfieldBorder,
        prefixIcon: textformfieldModel.prefixIcon,
        enabled: textformfieldModel.enabled!,
        suffixIcon: textformfieldModel.suffixIcon,
        contentPadding: AppDimensions.contentPadding,
        hint: Text(textformfieldModel.hint, style: AppTextStyles.hint),
        label: Text(textformfieldModel.label, style: AppTextStyles.label),
      ),
    );
  }
}
