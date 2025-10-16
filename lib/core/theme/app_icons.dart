import 'package:e_attendance/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

///List of Icons used all over the App with base style for primary and secondary icons to be inherited by all icons
class AppIcons {
  ///Base Styles for primary and secondary Icons
  static const double _iconSize = 24.0;
  static Widget _primaryIconBase(IconData iconData) =>
      Icon(iconData, color: AppColors.primaryIconColor, size: _iconSize);
  static Widget _secondaryIconBase(IconData iconData) =>
      Icon(iconData, color: AppColors.secondaryIconColor, size: _iconSize);

  static Widget _staticIconBase(IconData iconData) =>
      Icon(iconData, color: AppColors.primaryColor, size: _iconSize);

  /// getters with the base Icons style
  static Widget email = _secondaryIconBase(Icons.email);
  static Widget password = _secondaryIconBase(Icons.lock);
  static Widget menu = _primaryIconBase(Icons.menu);
  static Widget logout = _primaryIconBase(Icons.logout);

  static Widget more = _primaryIconBase(Icons.more);
  static Widget login = _primaryIconBase(Icons.login);
  static Widget pwdVisible = _secondaryIconBase(Icons.visibility);
  static Widget pwdInvisible = _secondaryIconBase(Icons.visibility_off);
  static Widget departmentIcon = _secondaryIconBase(Icons.group);
  static Widget attendanceRecord = _secondaryIconBase(Icons.notes);
  static Widget calendar = _staticIconBase(Icons.date_range);
  static Widget refresh = _secondaryIconBase(Icons.refresh);

  static Widget elapsedTimeIcon = _staticIconBase(Icons.timelapse_rounded);

  static Widget userAccount = _secondaryIconBase(Icons.account_circle);
  static Widget userListTile = _staticIconBase(Icons.account_circle);

  static Widget clockIcon = _staticIconBase(Icons.timer_outlined);

  static Widget locationIcon = _staticIconBase(Icons.location_pin);
  static Widget timerIcon = _staticIconBase(Icons.timer);
  static Widget clockOut = Icon(
    Icons.power_settings_new,
    color: AppColors.primaryColor,
  );
   static Widget staticBaseLogout = Icon(
    Icons.logout,
    color: AppColors.primaryColor,
  );
  static Widget clockIn = Icon(Icons.login, color: AppColors.primaryColor);
  static Widget history = _staticIconBase(Icons.history);
  static Widget filter = _primaryIconBase(Icons.filter_alt);
  static Widget hours=_staticIconBase(Icons.hourglass_bottom);
}
