import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class AppException implements Exception {
  final String msg;
  AppException({required this.msg});

  factory AppException.handle(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case "wrong-password":
          return AppException(msg: "The Password is incorrect");
        case "invalid-credential":
          return AppException(msg: "Invalid Credentials");
        case "user-not-found":
          return AppException(msg: "No user Found");
        case "user-disabled":
          return AppException(msg: "User disabled. Contact Admin");
        case "weak-password":
          return AppException(msg: "Password Provided is too weak");
        default:
          return AppException(msg: e.message ?? "Auth Error");
      }
    } else if (e is SocketException) {
      return AppException(msg: "No Internet Connection");
    } else if (e is FirebaseException) {
      return AppException(msg: e.code);
    } else if (e is TypeError || e is FormatException) {
      return AppException(msg: "Data Error: ${e.toString()}");
    } else {
      return AppException(msg: e.toString());
    }
  }

  @override
  String toString() => msg;
}
