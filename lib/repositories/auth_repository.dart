import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({required AuthService authService})
      : _authService = authService;

  Future<User?> getCurrentUser() async {
    return _authService.getCurrentUser();
  }

  Future<UserLocal?> loginWithEmailAndPassword(
      String email, String password) async {
    return _authService.loginWithEmailPassword(email, password);
  }

  Future<void> signUp(String email, String password, String displayName,
      String username, String mobileNumber, String role) async {
    await _authService.signUp(
        email: email,
        password: password,
        displayName: displayName,
        username: username,
        mobileNumber: mobileNumber,
        role: role);
  }

  Future<UserLocal?> signUpWithGoogle() async {
    return _authService.signUpWithGoogle();
  }

  Future<UserLocal?> signUpWithFacebook() async {
    return _authService.signUpWithFacebook();
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<UserLocal?> changeUsername(String username) async {
    return _authService.changeUsername(username);
  }

  Future<UserLocal?> changePhoneNumber(String phoneNumber) async {
    return _authService.chanePhoneNumber(phoneNumber);
  }
}
