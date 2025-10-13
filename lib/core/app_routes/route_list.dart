import 'package:e_attendance/core/app_routes/route_constants.dart' show Routes;
import 'package:e_attendance/core/app_routes/routebindings.dart';
import 'package:e_attendance/presentation/features/admin/clockinout/clocking_list.dart';
import 'package:e_attendance/presentation/features/admin/user/user_list.dart';
import 'package:e_attendance/presentation/features/auth/login/login.dart';
import 'package:e_attendance/presentation/features/auth/signup/signup.dart';
import 'package:e_attendance/presentation/features/user/history/clockin_history.dart';
import 'package:e_attendance/presentation/features/user/home/user_home.dart';
import 'package:get/get.dart';

import '../../presentation/features/splash/splash.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.login, page: () => Login(), binding: LoginBinding()),

    GetPage(
      name: Routes.signup,
      page: () => SignUp(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => UserHome(),
      binding: UserHomeBinding(),
    ),
    GetPage(
      name: Routes.clockingHistory,
      page: () => UserClockingHistory(),
      binding: ClockingHistoryBindings(),
    ),
    GetPage(
      name: Routes.usersList,
      page: () => UserList(),
      binding: UserListBindings(),
    ),
       GetPage(
      name: Routes.attendanceRecordList,
      page: () => ClockingList(),
      binding: ClockingListBindings(),
    ),
  ];
}
