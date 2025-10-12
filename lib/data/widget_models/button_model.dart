import 'package:flutter/material.dart';

class ButtonModel {
  final String title;
  final Widget? icon;
  final Function() onclick;


  const ButtonModel({
    
   required this.title,
     this.icon,
    required this.onclick,
  });
}
