import 'package:e_attendance/core/app_exceptions/app_exception.dart';
import 'package:e_attendance/data/repositories/auth/auth_repo.dart';
import 'package:e_attendance/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _auth = getIt<FirebaseAuth>();
  @override
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      var res = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AppException.handle(e);
    }
  }

  @override
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
    throw AppException.handle(e);    }
  }

  @override
  User? currentUser() {
    return _auth.currentUser;
  }
}
