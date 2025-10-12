import 'dart:async';
import 'package:e_attendance/core/utils/app_utils/connectivity_util.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../core/app_routes/route_constants.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  final ConnectivityUtil _connectivity = ConnectivityUtil();

  var isConnected = true.obs;

  late StreamSubscription<bool> _connectivitySub;

  @override
  void onInit() {
    super.onInit();
    _listenConnectivity();
    _checkUser();
  }

  void _listenConnectivity() {
    _connectivitySub = _connectivity.connectivityStream.listen((status) {
      isConnected.value = status;
    });
  }

  Future<void> _checkUser() async {
    await Future.delayed(Duration(seconds: 2));

    if (!isConnected.value) {
      Get.snackbar("No Internet", "Please check your connection");
      return;
    }

    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      Get.offAllNamed(Routes.login); // user not signed in
      return;
    }

    // fetch role from RTDB
    final snapshot = await _db
        .child("AppUser")
        .child(currentUser.uid)
        .child("role")
        .get();
    if (!snapshot.exists) {
      // user exists in auth but not in DB

      // if (_auth.currentUser != null) {
      //   await _auth.currentUser?.delete();
      // }

      Get.offAllNamed(Routes.login);
      return;
    }

    final role = snapshot.value.toString();
    if (role == "admin") {
      Get.offAllNamed(Routes.usersList);
    } else {
      Get.offAllNamed(Routes.home);
    }
  }

  @override
  void onClose() {
    _connectivitySub.cancel();
    super.onClose();
  }
}
