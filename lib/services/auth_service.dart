import '../models/user_model.dart';

class AuthService {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<UserModel?> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _currentUser = UserModel(id: '1', name: 'Velura User', email: email);
    return _currentUser;
  }

  Future<UserModel?> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _currentUser = UserModel(id: '2', name: name, email: email);
    return _currentUser;
  }

  Future<void> signOut() async {
    _currentUser = null;
  }
}
