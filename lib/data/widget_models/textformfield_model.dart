import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Common Shared helper Model class for input text fields
class TextFormFieldModel {
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Function(String?)? onchange;
  final String label;
  final String hint;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? formatters;
  final String? Function(String?)? onvalidate;

  const TextFormFieldModel({
    this.textInputType = TextInputType.text,
    this.onvalidate,
    this.formatters,
    this.textInputAction = TextInputAction.next,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.onchange = _defaultChanged,
    required this.label,
    required this.hint,
    this.enabled = true,
  });

  /// a default fallback method to onchange event since it is optional to avoid null exceptions
  static void _defaultChanged(String? val) => {};
}
