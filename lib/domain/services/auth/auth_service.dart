import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<void> signInWithEmail(String email, String password);
  Future<UserCredential?> signUpWithEmail(String email, String password);
  User? currentUser();
  Future<void> logoutUser();
}
