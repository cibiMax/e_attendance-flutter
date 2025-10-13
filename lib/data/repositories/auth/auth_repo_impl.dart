import 'package:e_attendance/data/repositories/auth/auth_repo.dart';
import 'package:e_attendance/data/repositories/auth/auth_repo_exception.dart';
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
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          throw AuthRepoException(msg: "The Password is incorrect");
        case "invalid-credential":
          throw AuthRepoException(msg: "Invalid Credentials");
        case "user-not-found":
          throw AuthRepoException(msg: "No user Found");
        case "user-disabled":
          throw AuthRepoException(msg: "User disabled.Contact Admin");
        case "weak-password":
          throw AuthRepoException(msg: "Password Provided is too weak");
        default:
          throw AuthRepoException(msg: e.message ?? "");
      }
    } catch (e) {
      throw AuthRepoException(msg: "Unknown Error");
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw (AuthRepoException(msg: e.code));
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
      throw (AuthRepoException(msg: e.code));
    }
  }

  @override
  User? currentUser() {
    return _auth.currentUser;
  }
}
