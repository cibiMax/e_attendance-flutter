import 'package:e_attendance/core/theme/app_decorations.dart';
import 'package:e_attendance/core/theme/app_dimensions.dart';
import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/data/widget_models/textformfield_model.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextFormFieldModel textFormFieldModel;
  final String? obscureChar;

  const PasswordFormField({
    super.key,
    required this.textFormFieldModel,
    this.obscureChar = "*",
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isvisible = false;

  void togglePwdVisibility() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(validator: widget.textFormFieldModel.onvalidate,
      obscuringCharacter: widget.obscureChar!,
      obscureText: isvisible,
      controller: widget.textFormFieldModel.controller,
      onChanged: widget.textFormFieldModel.onchange,
      decoration: InputDecoration(
        border: AppDecorations.textfieldBorder,
        prefixIcon: widget.textFormFieldModel.prefixIcon,
        enabled: widget.textFormFieldModel.enabled!,
        suffixIcon: GestureDetector(
          onTap: togglePwdVisibility,
          child: isvisible ? AppIcons.pwdInvisible : AppIcons.pwdVisible,
        ),
        contentPadding: AppDimensions.contentPadding,
        hint: Text(widget.textFormFieldModel.hint, style: AppTextStyles.hint),
        label: Text(
          widget.textFormFieldModel.label,
          style: AppTextStyles.label,
        ),
      ),
    );
  }
}
