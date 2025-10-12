import 'package:flutter/material.dart';

class CustomAssetImage extends StatelessWidget {
  final String path;
  const CustomAssetImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Image.asset(path);
  }
}