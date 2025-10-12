import 'package:e_attendance/core/theme/app_colors.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actionBtn;
  final Function(void)? onclick;
  final Widget? leading;
  final bool? iscenter;
  final bool? isdrawer;
  final GlobalKey? scaffoldKey;
  const CustomAppBar({
    super.key,
    required this.title,
    this.isdrawer = false,
    this.actionBtn,
    this.iscenter,
    this.leading,
    this.onclick,
     this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, kToolbarHeight),
      child: SafeArea(
        child: AppBar(
          leading:leading,
          actions: actionBtn,
          elevation: 10.0,
          centerTitle: iscenter,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.headingColor,
          title: Text(title, style: AppTextStyles.heading),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
