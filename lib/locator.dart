import 'package:e_attendance/core/utils/app_utils/connectivity_util.dart';
import 'package:e_attendance/core/utils/app_utils/geolocation_service.dart';
import 'package:e_attendance/core/utils/app_utils/local_util.dart';
import 'package:e_attendance/core/utils/app_utils/permission_util.dart';
import 'package:e_attendance/data/repositories/auth/auth_repo.dart';
import 'package:e_attendance/data/repositories/auth/auth_repo_impl.dart';
import 'package:e_attendance/data/repositories/business%20hour/business_hour_repo.dart';
import 'package:e_attendance/data/repositories/business%20hour/business_hour_repo_impl.dart';
import 'package:e_attendance/data/repositories/clock_in_out/clock_in_out_repo.dart';
import 'package:e_attendance/data/repositories/clock_in_out/clock_in_out_repo_impl.dart';
import 'package:e_attendance/data/repositories/local/clock_in_out/clock_in_out.dart';
import 'package:e_attendance/data/repositories/local/clock_in_out/clock_in_out_impl.dart';
import 'package:e_attendance/data/repositories/local/user/user.dart';
import 'package:e_attendance/data/repositories/local/user/user_impl.dart';
import 'package:e_attendance/data/repositories/user/user_repo.dart';
import 'package:e_attendance/data/repositories/user/user_repo_impl.dart';
import 'package:e_attendance/domain/services/auth/auth_service.dart';
import 'package:e_attendance/domain/services/auth/auth_service_impl.dart';
import 'package:e_attendance/domain/services/businesshour/business_hour_service.dart';
import 'package:e_attendance/domain/services/businesshour/business_hour_service_impl.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_impl.dart';
import 'package:e_attendance/domain/services/clockinout/clockinout_service.dart';
import 'package:e_attendance/domain/services/user/user_service.dart';
import 'package:e_attendance/domain/services/user/user_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

var getIt = GetIt.instance;
Future<void> setUpDependencies() async {
  final sharedPref = await SharedPreferences.getInstance();

  getIt.registerSingleton(FirebaseAuth.instance);
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<AuthService>(
    AuthServiceImpl(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerSingleton(PermissionUtil());
  getIt.registerSingleton(Location());
  getIt.registerSingleton(LocationUtil(location: getIt<Location>()));
  getIt.registerSingleton(FirebaseDatabase.instance);
  getIt.registerSingleton(sharedPref);
  getIt.registerSingleton<UserRepository>(
    UserRepoImpl(db: getIt<FirebaseDatabase>()),
  );
  getIt.registerSingleton<UserService>(
    UserServiceImpl(userRepository: getIt<UserRepository>()),
  );
  getIt.registerSingleton<ClockInOutRepo>(
    ClockInOutRepoImpl(db: getIt<FirebaseDatabase>()),
  );
  getIt.registerSingleton<ClockinoutService>(
    ClockinoutServiceImpl(
      clockInOutRepo: getIt<ClockInOutRepo>(),
      userRepository: getIt<UserRepository>(),
    ),
  );
  getIt.registerSingleton<LocalUtils>(
    LocalUtils(preferences: getIt<SharedPreferences>()),
  );
  getIt.registerSingleton<UserLocal>(
    UserLocalImpl(localUtils: getIt<LocalUtils>()),
  );
  getIt.registerSingleton<ClockInOutLocal>(
    ClockInOutLocalImpl(localUtils: getIt<LocalUtils>()),
  );
  getIt.registerSingleton(ConnectivityUtil());
  getIt.registerSingleton<BusinessHourRepo>(
    BusinessHourRepoImpl(database: getIt<FirebaseDatabase>()),
  );
  getIt.registerSingleton<BusinessHourService>(
    BusinessHourServiceImpl(businessHourRepo: getIt<BusinessHourRepo>()),
  );
}
