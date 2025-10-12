// lib/core/utils/connectivity_util.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();

  ConnectivityUtil() {
    _init();
  }

  void _init() {
    _connectivity.onConnectivityChanged.listen((result) {
      final isConnected = !result.contains(ConnectivityResult.none);
      _connectionController.add(isConnected);
    });
  }

  Stream<bool> get connectivityStream => _connectionController.stream;

  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  void dispose() {
    _connectionController.close();
  }
}
