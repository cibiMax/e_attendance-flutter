import 'dart:async';

import 'package:e_attendance/core/utils/app_utils/connectivity_util.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final ConnectivityUtil _connectivityUtil;
  late final StreamSubscription<bool> _connectivitySubscription;

  ConnectivityController({required ConnectivityUtil connectivityUtil})
    : _connectivityUtil = connectivityUtil;
  RxBool isconnected = false.obs;

  @override
  void onInit() {
    _connectivitySubscription = _connectivityUtil.connectivityStream.listen((
      data,
    ) {
      isconnected.value = data;
    });
    super.onInit();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
