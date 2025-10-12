import 'package:e_attendance/data/repositories/auth/auth_repo.dart';
import 'package:e_attendance/data/repositories/auth/auth_repo_exception.dart';
import 'package:e_attendance/domain/services/auth/auth_service.dart';
import 'package:e_attendance/domain/services/auth/auth_service_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceImpl implements AuthService {
  final AuthRepository _authRepository;

  AuthServiceImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;
  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _authRepository.signInWithEmail(email, password);
      return;
    } on AuthRepoException catch (e) {
      throw AuthServiceException(message: e.msg);
    } 
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _authRepository.signOutUser();
    } on AuthRepoException  catch (e) {
      throw (AuthServiceException(message: e.msg));
    }
  }

  @override
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
    return  await _authRepository.signUpWithEmail(email,password);
    } on AuthRepoException catch  (e) {
      throw (AuthServiceException(message: e.msg.toString()));
    }
  }

  @override
  User? currentUser()  {
    return  _authRepository.currentUser();
  }
}
