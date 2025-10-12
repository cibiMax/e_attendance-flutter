// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:e_attendance/core/theme/app_decorations.dart';
import 'package:e_attendance/core/theme/app_dimensions.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/data/widget_models/textformfield_model.dart';

class CustomDropdown extends StatelessWidget {
 final TextFormFieldModel textFormFieldModel;
 final List<String> items;
 final Function(String?)? onchange; 

  const CustomDropdown({ this.onchange,
    super.key,
    required this.textFormFieldModel, required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField<String>(width: double.infinity,
      leadingIcon:textFormFieldModel.prefixIcon,
      onSelected: (value) {
       textFormFieldModel.controller.text = value ?? "";
    if(onchange!=null){
      onchange!(value);
    }
      },
      controller: textFormFieldModel.controller,
      validator: textFormFieldModel.onvalidate,
      dropdownMenuEntries:items
          .map((e) => DropdownMenuEntry<String>(value: e, label: e))
          .toList(),
      inputDecorationTheme: InputDecorationTheme(
        border: AppDecorations.textfieldBorder,
        labelStyle: AppTextStyles.label,
        hintStyle: AppTextStyles.hint,
        contentPadding: AppDimensions.contentPadding,

        
      ),

      label: Text(textFormFieldModel.label),
    );
  }
}
