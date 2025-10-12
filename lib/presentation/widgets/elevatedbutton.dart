import 'package:e_attendance/core/theme/app_colors.dart';
import 'package:e_attendance/core/theme/app_decorations.dart';
import 'package:e_attendance/core/theme/app_dimensions.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/data/widget_models/button_model.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final ButtonModel buttonModel;
  final Color? bgColor;
  final Color? foregroundColor;
  final bool? enabled;
  const CustomElevatedButton({
    super.key,
    required this.buttonModel,
    this.enabled,
    this.bgColor = AppColors.elevatedBtnBgColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: AppDecorations.elevatedBtnStyle.copyWith(
        backgroundColor: WidgetStatePropertyAll(bgColor),
      ),
      onPressed: buttonModel.onclick,
      key: Key(buttonModel.title),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            <Widget>[
                  if (buttonModel.icon != null) buttonModel.icon!,
                  Text(
                    buttonModel.title,
                    style: AppTextStyles.subheading.copyWith(
                      color: AppColors.accentColor,
                    ),
                  ),
                ]
                .map(
                  (e) =>
                      Padding(padding: AppDimensions.btnRowPadding, child: e),
                )
                .toList(),
      ),
    );
  }
}
