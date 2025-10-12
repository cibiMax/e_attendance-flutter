import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signInWithEmail(String email, String password);
  Future<void> signOutUser();
  Future<UserCredential?> signUpWithEmail(String email, String password);

  User? currentUser();
}
