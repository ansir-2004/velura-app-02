import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();
  UserModel? user;
  bool isLoading = false;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    user = await _service.signIn(email, password);
    isLoading = false;
    notifyListeners();
    return user != null;
  }

  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    notifyListeners();
    user = await _service.register(name, email, password);
    isLoading = false;
    notifyListeners();
    return user != null;
  }

  Future<void> logout() async {
    await _service.signOut();
    user = null;
    notifyListeners();
  }
}
