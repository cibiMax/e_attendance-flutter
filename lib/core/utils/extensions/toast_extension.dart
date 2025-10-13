import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

enum ToastType { success, error, info, warning }

extension GetToastExtension on GetInterface {
  void showToast(
    String message, {
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
    Color? backgroundColor,
    TextStyle? textStyle,
    IconData? icon,
  }) {
   



  Fluttertoast.showToast(msg: message); }
}
