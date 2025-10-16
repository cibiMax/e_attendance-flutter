import 'package:e_attendance/core/app_routes/route_list.dart';
import 'package:e_attendance/core/utils/app_utils/connectivity_util.dart';
import 'package:e_attendance/locator.dart';
import 'package:e_attendance/presentation/features/common/connectivity/connectivity_controller.dart';
import 'package:e_attendance/presentation/widgets/drawer/drawer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) async {
    await setUpDependencies();

    bool res = getIt.allReadySync();

    Get.put(
      ConnectivityController(connectivityUtil: getIt<ConnectivityUtil>()),
    );
    Get.put(AppDrawerController(auth: getIt<FirebaseAuth>()));
    if (res) runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      theme: ThemeData(useMaterial3: false, primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
    );
  }
}
