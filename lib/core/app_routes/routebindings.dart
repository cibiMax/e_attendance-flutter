import 'package:e_attendance/core/utils/app_utils/permission_util.dart';
import 'package:e_attendance/data/repositories/local/clock_in_out/clock_in_out.dart';
import 'package:e_attendance/domain/services/auth/auth_service.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_service.dart';
import 'package:e_attendance/domain/services/user/user_service.dart';
import 'package:e_attendance/locator.dart';
import 'package:e_attendance/presentation/features/admin/clockinout/clocking_controller.dart';
import 'package:e_attendance/presentation/features/admin/clockinout/clocking_list.dart';
import 'package:e_attendance/presentation/features/admin/user/user_list_controller.dart';
import 'package:e_attendance/presentation/features/auth/login/login_controller.dart';
import 'package:e_attendance/presentation/features/auth/signup/signup_controller.dart';
import 'package:e_attendance/presentation/features/splash/splash_controller.dart';
import 'package:e_attendance/presentation/features/user/home/location/location_controller.dart';
import 'package:e_attendance/presentation/features/user/home/timer/timer_controller.dart';
import 'package:e_attendance/presentation/features/user/home/user_home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../presentation/features/user/history/clockin_history_controller.dart';
import '../utils/app_utils/geolocation_service.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        authService: getIt<AuthService>(),
        permissionUtil: getIt<PermissionUtil>(),
      ),
    );
  }
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignupController(
        authService: getIt<AuthService>(),
        userService: getIt<UserService>(),
      ),
    );
  }
}

class UserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController(locationUtil: getIt<LocationUtil>()));
    Get.lazyPut(() => TimerController());

    Get.lazyPut(
      () => UserHomeController(
        auth: getIt<FirebaseAuth>(),
        clockinoutService: getIt<ClockinoutService>(),
        locationController: Get.find<LocationController>(),
        timerController: Get.find<TimerController>(),
      ),
    );
  }
}

class ClockingHistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ClockinHistoryController(
        auth: getIt<FirebaseAuth>(),
        clockinoutService: getIt<ClockinoutService>(),
      ),
    );
  }
}

class UserListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserListController(userService: getIt<UserService>()));
  }
}

class ClockingListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () =>
          ClockingListController(clockinoutService: getIt<ClockinoutService>()),
    );
  }
}
