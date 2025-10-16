import 'package:e_attendance/data/repositories/auth/auth_repo.dart';
import 'package:e_attendance/domain/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceImpl implements AuthService {
  final AuthRepository _authRepository;

  AuthServiceImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;
  @override
  Future<void> signInWithEmail(String email, String password) async {
    await _authRepository.signInWithEmail(email, password);
    return;
  }

  @override
  Future<void> logoutUser() async {
    await _authRepository.signOutUser();
  }

  @override
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    return await _authRepository.signUpWithEmail(email, password);
  }

  @override
  User? currentUser() {
    return _authRepository.currentUser();
  }
}
